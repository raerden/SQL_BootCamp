SELECT gs::date AS missing_date
FROM generate_series('2022-01-01'::date, '2022-01-10'::date, interval '1 day') AS gs
LEFT JOIN (SELECT * FROM person_visits WHERE person_id = 1 OR  person_id = 2) as pv
ON pv.visit_date = gs::date
WHERE person_id IS NULL
ORDER BY missing_date;
