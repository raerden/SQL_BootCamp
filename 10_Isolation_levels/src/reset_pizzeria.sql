DELETE FROM pizzeria WHERE id >= 10;
UPDATE pizzeria SET rating=3 WHERE id=1;
UPDATE pizzeria SET rating=4.3 WHERE id=2;

SELECT * FROM pizzeria;
SELECT SUM(rating) FROM pizzeria;