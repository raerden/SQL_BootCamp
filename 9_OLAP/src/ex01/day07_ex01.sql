-- Изменить прошлый запрос так чтобы возвращал имя человека
-- вывести только топ 4 визитеров

SELECT 
	name,
	count(pizzeria_id) AS count_of_visits
FROM person_visits pv
JOIN person p ON p.id = pv.person_id 
GROUP BY name
ORDER BY 2 DESC, 1 ASC
LIMIT 4;