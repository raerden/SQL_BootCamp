--  создаём таблицу для хранения маршрутов и их стоимостей
DROP TABLE IF EXISTS tours;

CREATE TABLE IF NOT EXISTS tours
    (id SERIAL PRIMARY KEY,
     route TEXT,
     total_cost INT);

DROP FUNCTION IF EXISTS take_cost(INT, INT);

CREATE OR REPLACE FUNCTION take_cost(last_city INT, curr_city INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
	res INT;
BEGIN
 	SELECT cost INTO res
       FROM costs
        WHERE (point1 = last_city AND point2 = curr_city) 
			  OR
              (point2 = last_city AND point1 = curr_city);

	return res;
END;
$$;


DROP FUNCTION IF EXISTS tour_search(TEXT, INT, INT, INT);

CREATE OR REPLACE FUNCTION tour_search(
    path TEXT, 
    last_city INT, 
    total_cost INT, 
    visits_count INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    curr_city RECORD;
    total_cities INT;
    curr_cost INT;
BEGIN
    -- Получаем общее количество городов
    SELECT COUNT(*) INTO total_cities FROM cities;
    
    -- если все города посетили - заносим в таблицу туров
    IF visits_count = total_cities THEN
        -- Прибавить первый город в path
        path:= path || ', a';
        -- Прибавить cost до первого города в total_cost
		total_cost:= total_cost + take_cost(last_city, 1);
        INSERT INTO tours (route, total_cost)
        VALUES (path, total_cost);
        RETURN;
    END IF;

    -- обход всех непосещённых городов
    FOR curr_city IN
        SELECT id, city
        FROM cities
        WHERE path NOT LIKE '%' || city || '%'  -- альтернативная проверка
    LOOP
        -- ищем стоимость переезда
		curr_cost:= take_cost(last_city, curr_city.id);

		PERFORM tour_search(
			path || ', ' || curr_city.city,
			curr_city.id,
			total_cost + curr_cost,
			visits_count + 1
		);
    END LOOP;
END;
$$;

SELECT tour_search('a', 1, 0, 1);
SELECT id, '{' || route || '}' as route, total_cost FROM tours;
