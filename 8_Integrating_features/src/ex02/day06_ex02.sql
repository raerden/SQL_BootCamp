SELECT 
	p.name,
	m.pizza_name,
	m.price,
	m.price * (1 - pd.discount / 100) AS discount_price,
	pz.name AS pizzeria_name
FROM person_order po
JOIN person p ON p.id = po.person_id
JOIN menu m ON po.menu_id = m.id 
JOIN pizzeria pz ON pz.id = m.pizzeria_id
JOIN person_discounts pd ON pd.person_id = p.id AND pd.pizzeria_id = pz.id 
ORDER BY 1,2
