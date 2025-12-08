SELECT 
	name 
FROM person_order AS po
JOIN person AS p
ON po.person_id = p.id
JOIN menu AS m
ON po.menu_id = m.id
WHERE gender = 'male' 
AND address IN ('Moscow','Samara') 
AND pizza_name IN ('pepperoni pizza', 'mushroom pizza')
ORDER BY name DESC;
