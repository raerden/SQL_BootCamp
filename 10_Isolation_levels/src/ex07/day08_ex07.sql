--  Ситуация взаимоблокировки (deadlock) в базе данных.

-- Сессия #1
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE pizzeria SET rating=4 WHERE id = 1;			-- удержание id=1
-- Session #2 SET rating=4 WHERE id = 2;
UPDATE pizzeria SET rating=5 WHERE id = 2;			-- запрос на id=2
-- Session #2 SET rating=5 WHERE id = 1;
COMMIT;


-- Сессия #2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Session #1 SET rating=4 WHERE id = 1;
UPDATE pizzeria SET rating=4 WHERE id = 2;			-- удержание id=2
-- Session #1 SET rating=5 WHERE id = 2;
UPDATE pizzeria SET rating=5 WHERE id = 1;			-- запрос на id=1
-- ERROR:  deadlock detected				--Postgres сбрасывает вторую сессию
-- Session #1 COMMIT;
COMMIT;
-- ROLLBACK			-- и откатывает её изменения.

SELECT * FROM pizzeria WHERE id=1 or id=2;
-- id |   name    | rating 
----+-----------+--------
--  1 | Pizza Hut |      4
--  2 | Dominos   |      5
