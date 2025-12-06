SELECT tmp.object_name FROM (
SELECT person.name AS object_name, '1' as sort FROM person
UNION ALL
SELECT menu.pizza_name, '2' as sort FROM menu
ORDER BY sort, object_name) as tmp