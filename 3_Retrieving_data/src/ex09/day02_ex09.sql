SELECT 
	name
FROM person_order AS po
JOIN person AS p
ON po.person_id = p.id
JOIN menu AS m
ON po.menu_id = m.id
WHERE gender = 'female' AND pizza_name = 'pepperoni pizza'

INTERSECT

SELECT 
	name
FROM person_order AS po
JOIN person AS p
ON po.person_id = p.id
JOIN menu AS m
ON po.menu_id = m.id
WHERE gender = 'female' AND pizza_name = 'cheese pizza'

