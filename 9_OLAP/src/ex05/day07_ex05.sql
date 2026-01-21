-- Вернуть список уникальных имен людей, сделавших хотя бы один заказ в любой из пиццерий
-- запрещено GROUP BY, any type (UNION,...) working with sets

SELECT DISTINCT name FROM person_order po 
JOIN person p ON p.id = po.person_id 
ORDER BY 1