-- создаём таблицу для хранения маршрутов и их стоимостей
CREATE TABLE IF NOT EXISTS tours
    (id SERIAL PRIMARY KEY,
     route TEXT,
     total_cost INT);

-- очищаем таблицу туров, чтобы случайно не заполнить её дважды
TRUNCATE tours;

-- функция получения стоимости между двумя городами по их id
CREATE OR REPLACE FUNCTION take_cost(city1 INT, city2 INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN 
        (SELECT cost 
        FROM costs
        WHERE (point1 = city1 AND point2 = city2) OR
              (point2 = city1 AND point1 = city2));
END;
$$;

-- хранимая рекурсивная процедура, которая ищет все маршруты
--DROP PROCEDURE IF EXISTS tour_search(TEXT, INT, INT, INT);
CREATE OR REPLACE PROCEDURE tour_search(path TEXT,     -- строка с маршрутом из городов, разделённых запятой
                                        last_city_id INT, -- id последнего посещённого города
                                        total_cost INT, -- суммарные издержки маршрута
                                        visits_count INT) -- количество уже посещённых городов (по маршруту)
LANGUAGE plpgsql
AS $$
DECLARE
    first_city_id CONSTANT INT := 1;
    first_city_name CONSTANT TEXT := (SELECT city FROM cities WHERE id = 1);
    total_cities CONSTANT INT := (SELECT COUNT(*) FROM cities);
    curr_city RECORD;  -- запись-бегунок таблицы городов
BEGIN
    -- если все города посетили - заносим в таблицу туров и выходим из функции
    IF visits_count = total_cities THEN
        INSERT INTO tours (route, total_cost)
        VALUES ( 
                -- завершаем строковый маршрут добавляя ", a}"
                path || ',' || first_city_name,
                -- добавляем cost до первого города
                total_cost + take_cost(last_city_id, first_city_id)
                );
        RETURN;
    END IF;

    -- обход всех непосещённых в этом маршруте городов
    FOR curr_city IN
                    SELECT id, city FROM cities
                    WHERE STRPOS(path, city) = 0
    LOOP -- синтаксис цикла FOR
        -- тут процедура вызывает саму себя, на то она и рекурсивная:
        CALL tour_search(path || ',' || curr_city.city,
                         curr_city.id,
                         total_cost + take_cost(last_city_id, curr_city.id),
                         visits_count + 1);
    END LOOP;
END;
$$;

-- начальный вызов рекурсивной процедуры
CALL tour_search('a', 1, 0, 1);
