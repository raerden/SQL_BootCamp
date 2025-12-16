-- маршруты с минимальной и максимальной суммарной стоимостью путешествия, если стартовать из города «a»
SELECT 
    total_cost, 
    '{' || route || '}' AS tour 
FROM tours
WHERE 
    total_cost = (SELECT MIN(total_cost) FROM tours) OR
    total_cost = (SELECT MAX(total_cost) FROM tours)
ORDER BY 
    total_cost, 
    tour;
