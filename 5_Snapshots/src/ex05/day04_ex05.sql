CREATE VIEW v_price_with_discount AS
SELECT 
	ps.name, 
	m.pizza_name, 
	m.price, 
	round(m.price - m.price * 0.1) AS discount_price 
FROM person_order po
JOIN person ps ON ps.id = po.person_id
JOIN menu m ON m.id = po.menu_id
ORDER BY name, pizza_name;

SELECT * FROM v_price_with_discount 