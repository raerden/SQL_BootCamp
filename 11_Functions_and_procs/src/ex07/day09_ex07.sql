DROP FUNCTION IF EXISTS func_minimum(VARIADIC arr numeric[]);

CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr numeric[])
RETURNS numeric
LANGUAGE SQL
AS $$
	SELECT min(x) FROM unnest($1) AS x;
$$

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
SELECT func_minimum(6, 7, 5, 4.4);

SELECT unnest('{1,2,4,5}'::integer[]);