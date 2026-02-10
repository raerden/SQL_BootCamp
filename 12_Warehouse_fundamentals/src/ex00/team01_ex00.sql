WITH 
	last_currency AS ( -- CTE валюта с последней обновлённой ставкой
		SELECT DISTINCT ON (id) 
	        id,
	        name,
	        rate_to_usd
	    FROM currency
	    ORDER BY id, name, updated DESC),

	data_table AS (  -- CTE почти все необходимые данные
		SELECT
			COALESCE(usr.name, 'not defined') AS name,
			COALESCE(usr.lastname, 'not defined') AS lastname,
			bln.type AS type,
			sum(bln.money) AS volume,
			COALESCE(crn.name, 'not defined') AS currency_name,
			COALESCE(crn.rate_to_usd, 1) AS last_rate_to_usd
		FROM balance bln
		FULL JOIN "user" usr ON bln.user_id = usr.id
		FULL JOIN last_currency crn ON bln.currency_id = crn.id
		GROUP BY usr.name, usr.lastname, bln.type, crn.name, crn.rate_to_usd)
	  
-- главный SQL-запрос, возвращает сумму всех средств транзакций из балансов пользователей
SELECT *,
	volume * last_rate_to_usd AS total_volume_in_usd
FROM data_table
ORDER BY name DESC,
		 lastname ASC, 
		 type ASC;