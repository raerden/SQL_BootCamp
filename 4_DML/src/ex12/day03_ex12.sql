WITH persons AS (
	SELECT 
	generate_series(1, (SELECT count(*) FROM person)) as order_id,
	generate_series(1, (SELECT max(id) FROM person)) as person_id
)

INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT 
	order_id + (SELECT MAX(id) FROM person_order) AS order_id, 
	person_id, 
	(SELECT id FROM menu WHERE pizza_name = 'greek pizza') as menu_id,
	'2022-02-25' as order_date
FROM persons
JOIN person ON person.id = persons.person_id

-- select * from person_order