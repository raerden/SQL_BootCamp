
-- Триггерная функция для отслеживания UPDATE в таблице person
CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
	VALUES ('U', old.id, old.name, old.age, old.gender, old.address);
    RETURN NEW;
END;
$$;

-- Триггер отслеживающий события UPDATE в таблице person
CREATE OR REPLACE TRIGGER trg_person_update_audit
    AFTER UPDATE ON person
    FOR EACH ROW
    EXECUTE FUNCTION fnc_trg_person_update_audit();


UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

SELECT * FROM person_audit;

SELECT * FROM person;


-- Очистные сооружения
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_update_audit();
DELETE FROM person_audit;
DELETE FROM person WHERE id = 10;



