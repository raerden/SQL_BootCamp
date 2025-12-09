WITH visit_pz AS (
	SELECT pz.name as pizzeria_name
	FROM person_visits pv
	JOIN person ps ON ps.id = pv.person_id
	JOIN pizzeria as pz ON pz.id = pv.pizzeria_id
	WHERE ps.name='Andrey'
),  order_pz AS (
	SELECT pz.name as pizzeria_name
	FROM person_order po
	JOIN menu as m ON m.id = po.menu_id
	JOIN person ps ON ps.id = po.person_id
	JOIN pizzeria as pz ON pz.id = m.pizzeria_id
	WHERE ps.name='Andrey'
)

SELECT * FROM visit_pz
EXCEPT
SELECT * FROM order_pz
ORDER BY 1;