-- SQL функция это именованный sql запрос.

CREATE OR REPLACE FUNCTION fnc_persons_female()
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
	WHERE gender = 'female';
$$;

CREATE OR REPLACE FUNCTION fnc_persons_male()
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
	WHERE gender = 'male';
$$;

SELECT * FROM fnc_persons_male();
SELECT * FROM fnc_persons_female();




-- найти представления в БД
SELECT table_name
 FROM information_schema.views
 WHERE table_schema = 'public';
 
SELECT * FROM v_persons_female ORDER BY 1;
SELECT * FROM v_persons_male ORDER BY 1;
 
 