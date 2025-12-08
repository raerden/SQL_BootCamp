SELECT pz.name FROM 
	person_visits AS pv
JOIN 
	(SELECT id FROM
	person 
	WHERE name = 'Dmitriy') AS p
ON pv.person_id = p.id
JOIN pizzeria AS pz
ON pv.pizzeria_id = pz.id
JOIN menu AS m
ON pz.id = m.pizzeria_id
WHERE  pv.visit_date = '2022-01-08'
	AND m.price < 800
