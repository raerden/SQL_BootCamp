-- "Неповторяющееся чтение" (Non-Repeatable Reads), но на уровне изоляции READ COMMITTED.

-- Сессия #1
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 4
-- Session #2 update rating to 3.6
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 3.6
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 3.6



-- Сессия #2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE pizzeria SET rating=3.6 WHERE name='Pizza Hut';
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 3.6

-- первый select увидел одно значение
-- второй select видит другое значение. Неповторяющееся чтение.