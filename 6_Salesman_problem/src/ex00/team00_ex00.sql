-- маршруты с минимальной суммарной стоимостью путешествия, если стартовать из города «a»
SELECT 
    total_cost, 
    '{' || route || '}' AS tour 
FROM tours
WHERE total_cost = (SELECT MIN(total_cost) FROM tours)
ORDER BY 
    total_cost, 
    tour;
