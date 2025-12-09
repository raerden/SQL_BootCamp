SELECT pizza_name, price, pz.name as pizzeria_name, visit_date FROM menu m
JOIN pizzeria pz ON pz.id = m.pizzeria_id
JOIN person_visits pv ON pv.pizzeria_id = pz.id
JOIN person ps ON ps.id = pv.person_id
WHERE ps.name = 'Kate' 
AND price BETWEEN 800 and 1000
ORDER BY 1,2,3

