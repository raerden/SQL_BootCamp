SELECT COALESCE(ps.name, '-') AS person_name, pv.visit_date, COALESCE(pz.name,'-') AS pizzeria_name
FROM person as ps
FULL JOIN (SELECT * FROM person_visits WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03') as pv
ON pv.person_id = ps.id
FULL JOIN pizzeria as pz
ON pv.pizzeria_id = pz.id
ORDER BY 1, 2, 3;