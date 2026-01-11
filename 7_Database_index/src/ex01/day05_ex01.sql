SET enable_seqscan = off;

EXPLAIN ANALYZE
SELECT pizza_name, name 
FROM pizzeria pz 
JOIN menu m ON m.pizzeria_id = pz.id;

