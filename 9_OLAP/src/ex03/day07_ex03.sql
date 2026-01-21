-- Группировка ресторанов, суммирование посещений и заказов
WITH visits AS (
    SELECT 
        p.name,
        COUNT(*) AS cnt
    FROM person_visits pv
    JOIN pizzeria p ON p.id = pv.pizzeria_id
    GROUP BY p.name
),
orders AS (
    SELECT 
        p.name,
        COUNT(*) AS cnt
    FROM person_order po
    JOIN menu m ON m.id = po.menu_id
    JOIN pizzeria p ON p.id = m.pizzeria_id
    GROUP BY p.name
)
SELECT
    coalesce(v.name, o."name") AS name,
    coalesce(v.cnt, 0) + coalesce(o.cnt, 0) AS total_count
FROM visits v
FULL JOIN orders o ON v.name = o.name
ORDER BY 2 DESC, 1;


