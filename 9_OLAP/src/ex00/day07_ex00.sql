-- Вывести агрегацию. Индентификаторы людей и количество посещенных пиццерий
SELECT 
	person_id,
	count(pizzeria_id) AS count_of_visits
FROM person_visits pv
GROUP BY person_id
ORDER BY 2 DESC, 1 ASC