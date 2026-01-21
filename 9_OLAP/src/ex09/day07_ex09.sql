-- Вернуть агрегированную информацию по адресу каждого человека
-- Вычисляемый столбец с формулой: макс.возраст - (мин.возраст / макс.возраст)
-- средний возраст по каждому городу
-- результат сравнения среднего возраста. Если формула > ср.возраста вернуть true иначе false

SELECT 
	address,
	round(max(age) - (min(age) / max(age)::numeric), 2) AS formula,
	round(avg(age::numeric), 2) AS average,
	CASE 
		WHEN (max(age) - (min(age) / max(age)::numeric)) > (avg(age::numeric)) 
		THEN 'true'
		ELSE 'false'
	END AS comparsion
FROM person
GROUP BY address 
ORDER BY 1

