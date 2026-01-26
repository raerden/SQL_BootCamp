DROP FUNCTION IF EXISTS fnc_persons_male();
DROP FUNCTION IF EXISTS fnc_persons_female();

CREATE OR REPLACE FUNCTION fnc_persons(pgender varchar='female')
RETURNS TABLE (
    id bigint,
    name varchar,
    age integer,
    gender varchar,
    address varchar
)
LANGUAGE SQL
AS $$
	SELECT id, name, age, gender, address 
	FROM person
	WHERE gender = pgender;
$$;


SELECT * FROM fnc_persons(pgender := 'male');
SELECT * FROM fnc_persons('male'); -- можно и так
SELECT * FROM fnc_persons();





-- найти представления в БД
SELECT table_name
 FROM information_schema.views
 WHERE table_schema = 'public';
 
SELECT * FROM v_persons_female ORDER BY 1;
SELECT * FROM v_persons_male ORDER BY 1;
 
