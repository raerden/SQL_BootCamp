DROP FUNCTION IF EXISTS fnc_fibonacci(integer);

CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop integer=10)
RETURNS TABLE (fbn integer) 
LANGUAGE SQL
AS $$
	WITH RECURSIVE nums(a,b) AS (
	    SELECT 0, 1
	    UNION ALL
	    SELECT b, a + b
	    FROM nums
	    WHERE b < pstop
	)
	SELECT a FROM nums;
$$

SELECT * FROM fnc_fibonacci(20);
SELECT * FROM fnc_fibonacci(100);

