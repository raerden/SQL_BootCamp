--DROP TABLE IF EXISTS person_audit;
-- Создать таблицу для аудита изменений в таблице person
CREATE TABLE person_audit
( 
	created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
	type_event CHAR(1) NOT NULL DEFAULT 'I',
	row_id BIGINT NOT NULL,
	name VARCHAR,
	age INTEGER,
	gender VARCHAR,
	address VARCHAR,
   	constraint ch_type_event check ( type_event in ('I','U', 'D'))
  );

-- Триггераня функция. Вносит дату/время, тип изменения, и новые данные в person_audit
CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
	VALUES ('I', new.id, new.name, new.age, new.gender, new.address);
    RETURN NEW;
END;
$$;

-- Триггер таблицы person отслеживающие операции Insert и вызывающий функцию fnc_trg_person_insert_audit()
CREATE OR REPLACE TRIGGER trg_person_insert_audit
    AFTER INSERT ON person
    FOR EACH ROW
    EXECUTE FUNCTION fnc_trg_person_insert_audit();

-- Вносим новые данные в таблицу person
INSERT INTO person (id, name, age, gender, address) 
VALUES (10,'Damir', 22, 'male', 'Irkutsk');

-- Проверяем как всё сработало.
SELECT * FROM person;
SELECT * FROM person_audit;

-- Очистные сооружения
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit();
DELETE FROM person_audit;
DELETE FROM person WHERE id = 10;



