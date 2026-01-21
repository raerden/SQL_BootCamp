-- вывести топ3 ресторанов по посещениям и заказам

(SELECT 
	p.name,
	count(*) AS count,
	'visit' AS action_type
FROM person_visits pv
JOIN pizzeria p ON p.id = pv.pizzeria_id 
GROUP BY p.name
ORDER BY 2 DESC
LIMIT 3)
	UNION
(SELECT 
	p.name,
	count(po.*) AS count,
	'order' AS action_type
FROM person_order po
JOIN menu m ON m.id = po.menu_id  
JOIN pizzeria p ON p.id  = m.pizzeria_id
GROUP BY p.name
ORDER BY 2 DESC
LIMIT 3)
ORDER BY 3, 2 DESC