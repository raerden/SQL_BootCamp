DROP FUNCTION fnc_person_visits_and_eats_on_date(varchar, NUMERIC, date);

CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
	pperson varchar='Dmitriy',
	pprice numeric=500,
	pdate date='2022-01-08'
	)
RETURNS TABLE (pizzeria varchar)
LANGUAGE plpgsql
AS $$
BEGIN
-- для plpgsql нужно указать тип возвращаемого значения QUERY.
-- Иначе возвращает только одно значение или запись, а не таблицу
	RETURN QUERY SELECT DISTINCT pz.name FROM person_visits pv
	JOIN person p ON p.id = pv.person_id
	JOIN pizzeria pz ON pz.id = pv.pizzeria_id
	JOIN menu m ON m.pizzeria_id = pz.id
	WHERE p.name = pperson AND m.price < pprice AND pv.visit_date = pdate;
END;
$$;


SELECT * FROM fnc_person_visits_and_eats_on_date(pprice := 800);
SELECT * FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');






-- найти представления в БД
SELECT table_name
 FROM information_schema.views
 WHERE table_schema = 'public';
 
SELECT * FROM v_persons_female ORDER BY 1;
SELECT * FROM v_persons_male ORDER BY 1;
 
