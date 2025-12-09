WITH no_order as (SELECT id as menu_id FROM menu
EXCEPT
SELECT menu_id  FROM person_order)

SELECT pizza_name, price, pz.name as pizzeria_name FROM menu m
JOIN pizzeria pz
ON m.pizzeria_id = pz.id
WHERE m.id IN (SELECT * FROM no_order)
ORDER BY 1,2;
