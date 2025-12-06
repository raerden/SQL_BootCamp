SELECT action_date, person.name AS person_name FROM person
INNER JOIN
	(SELECT order_date AS action_date, person_id FROM person_order
	INTERSECT ALL
	SELECT visit_date, person_id FROM person_visits
	) as t1
ON person.id = t1.person_id
ORDER BY action_date, person_name DESC