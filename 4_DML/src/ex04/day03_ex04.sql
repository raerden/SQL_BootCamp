WITH male_pz AS (
	SELECT pz.name as pizzeria_name
	FROM person_order po
	JOIN menu as m ON m.id = po.menu_id
	JOIN person ps ON ps.id = po.person_id
	JOIN pizzeria as pz ON pz.id = m.pizzeria_id
	WHERE gender='male'
),  female_pz AS (
	SELECT pz.name as pizzeria_name
	FROM person_order po
	JOIN menu as m ON m.id = po.menu_id
	JOIN person ps ON ps.id = po.person_id
	JOIN pizzeria as pz ON pz.id = m.pizzeria_id
	WHERE gender='female'
)

(SELECT * FROM male_pz 
	EXCEPT 
SELECT * FROM female_pz)

UNION

(SELECT * FROM female_pz 
	EXCEPT 
SELECT * FROM male_pz)
order by 1;