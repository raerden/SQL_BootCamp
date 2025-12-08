SELECT 
	m.pizza_name as pizza_name, pz.name AS pizzeria_name 
FROM person_order AS po
JOIN 
	(SELECT id FROM person
		WHERE name IN ('Denis', 'Anna')
	) AS p
ON po.person_id = p.id
JOIN menu AS m
ON po.menu_id = m.id
JOIN pizzeria AS pz
ON m.pizzeria_id = pz.id
ORDER BY 1, 2;

