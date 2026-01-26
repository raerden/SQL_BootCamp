-- просмотреть все триггеры и функции таблицы person
SELECT
    tg.tgname        AS trigger_name,
    p.proname        AS function_name,
    tg.tgenabled     AS enabled,
    tg.tgtype        AS type_code
FROM pg_trigger tg
JOIN pg_proc p ON p.oid = tg.tgfoid
WHERE tg.tgrelid = 'person'::regclass
  AND NOT tg.tgisinternal;

-- Удаляем предыдущие триггеры и функции таблицы person
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit();
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_update_audit();
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit();
DELETE FROM person_audit;

SELECT * FROM person_audit;


-- Триггерная функция для записи DML событий таблицы person в журнал person_audit
CREATE OR REPLACE FUNCTION fnc_trg_person_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
		VALUES ('I', new.id, new.name, new.age, new.gender, new.address);
    ELSIF (TG_OP = 'UPDATE') THEN
		INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
		VALUES ('U', old.id, old.name, old.age, old.gender, old.address);
    ELSIF (TG_OP = 'DELETE') THEN
		INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
		VALUES ('D', old.id, old.name, old.age, old.gender, old.address);
    END IF;

	IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
	    RETURN NEW;
	ELSE
		RETURN OLD;
	END IF;
END;
$$;

-- Триггер отслеживающий DML события в таблице person
CREATE OR REPLACE TRIGGER trg_person_audit
    AFTER INSERT OR UPDATE OR DELETE ON person
    FOR EACH ROW
    EXECUTE FUNCTION fnc_trg_person_audit();

-- Вносим изменения в таблицу person
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk'); 
UPDATE person SET name = 'Bulat' WHERE id = 10; 
UPDATE person SET name = 'Damir' WHERE id = 10; 
DELETE FROM person WHERE id = 10;


SELECT * FROM person_audit;

SELECT * FROM person;


-- Очистные сооружения
DROP TRIGGER IF EXISTS trg_person_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_audit();
DELETE FROM person_audit;
DELETE FROM person WHERE id = 10;



