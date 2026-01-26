
-- Триггерная функция для отслеживания DELETE в таблице person
CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO person_audit (type_event, row_id, name, age, gender, address)
	VALUES ('D', old.id, old.name, old.age, old.gender, old.address);
    RETURN OLD;
END;
$$;

-- Триггер отслеживающий события DELETE в таблице person
CREATE OR REPLACE TRIGGER trg_person_delete_audit
    AFTER DELETE ON person
    FOR EACH ROW
    EXECUTE FUNCTION fnc_trg_person_delete_audit();


DELETE FROM person WHERE id = 10;

SELECT * FROM person_audit;

SELECT * FROM person;


-- Очистные сооружения
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit();
DELETE FROM person_audit;
DELETE FROM person WHERE id = 10;
