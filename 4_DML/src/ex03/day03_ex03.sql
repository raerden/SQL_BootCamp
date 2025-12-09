WITH visits AS (
	SELECT pz.name as pizzeria_name, gender
	FROM pizzeria pz
	JOIN person_visits pv ON pz.id = pv.pizzeria_id
	JOIN person ps ON ps.id = pv.person_id
)

(
	SELECT pizzeria_name FROM visits WHERE gender='male'
	EXCEPT ALL
	SELECT pizzeria_name FROM visits WHERE gender='female'
)
UNION ALL
(
	SELECT pizzeria_name FROM visits WHERE gender='female'
	EXCEPT ALL
	SELECT pizzeria_name FROM visits WHERE gender='male'
)
ORDER BY 1;
