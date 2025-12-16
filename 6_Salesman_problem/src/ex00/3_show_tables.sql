SELECT 
    costs.id AS id, 
    c1.city AS city1,
    c2.city AS city2,
    cost
FROM costs 
JOIN cities c1 ON costs.point1 = c1.id
JOIN cities c2 ON costs.point2 = c2.id
ORDER BY costs.id;

SELECT route, total_cost FROM tours
ORDER BY total_cost, route;