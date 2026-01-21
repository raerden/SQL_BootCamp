-- Вернуть для каждой пиццерии
-- Общее количество заказов
-- среднюю цену
-- максимальную цену пиццы
-- минимальную цены пиццы
-- отсортировать по названию пиццерии. Округлить среднюю цену до 2 знаков после запятой

SELECT 
	p.name,
	count(*) AS count_of_orders,
	round(avg(m.price),2) AS average_price,
	max(m.price) AS max_price,
	min(m.price) AS min_price
FROM person_order po 
JOIN menu m ON m.id = po.menu_id 
JOIN pizzeria p ON p.id = m.pizzeria_id 
GROUP BY 1
ORDER BY 1;