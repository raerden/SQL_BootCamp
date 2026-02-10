-- Были добавлены данные:
-- insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
-- insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

-- функция, возвращающая курс к $ по id валюты и дате баланса
CREATE OR REPLACE FUNCTION get_rate_by_date(cur_id BIGINT, by_date TIMESTAMP) 
RETURNS NUMERIC
AS $$
	WITH t1 AS ( -- ставка на ближайшую дату в прошлом
			SELECT rate_to_usd AS rate FROM currency
			WHERE id = cur_id AND updated <= by_date
			ORDER BY updated DESC LIMIT 1),
	 	 t2 AS ( -- ставка на ближайшую дату в будущем
			SELECT rate_to_usd AS rate FROM currency
			WHERE id = cur_id AND updated > by_date
			ORDER BY updated LIMIT 1)
	SELECT COALESCE((SELECT * FROM t1), (SELECT * FROM t2))
    -- таким образом, если t1 не NULL, вернёт t1, иначе вернёт t2
$$ LANGUAGE SQL;

-- главный SQL-запрос, выводит для всех пользователей все операции по балансу 
-- с указанием наименования валюты и рассчитанным значением суммы в USD
SELECT DISTINCT
    COALESCE(usr.name, 'not defined') AS name,
    COALESCE(usr.lastname, 'not defined') AS lastname,
    crn.name AS currency_name,
    bln.money * get_rate_by_date(bln.currency_id, bln.updated) AS currency_in_usd
FROM balance bln
FULL JOIN "user" usr ON bln.user_id = usr.id      
JOIN currency crn ON bln.currency_id = crn.id
WHERE crn.name IS NOT NULL
ORDER BY name DESC,
         lastname ASC,
         currency_name ASC;



DROP FUNCTION get_rate_by_date(cur_id BIGINT, by_date TIMESTAMP);
DELETE FROM currency WHERE updated = '2022-01-01 13:29';
DELETE FROM currency WHERE updated = '2022-01-08 13:29';

