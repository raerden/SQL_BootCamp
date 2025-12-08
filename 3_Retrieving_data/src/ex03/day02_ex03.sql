WITH gst AS 
	(SELECT gs::date AS missing_date 
	 FROM generate_series('2022-01-01'::date, '2022-01-10'::date, interval '1 day') AS gs)

SELECT missing_date FROM gst
LEFT JOIN 
	(SELECT * FROM person_visits WHERE person_id = 1 OR  person_id = 2) as pv
ON pv.visit_date = gst.missing_date
WHERE pv.person_id IS NULL
ORDER BY missing_date;
