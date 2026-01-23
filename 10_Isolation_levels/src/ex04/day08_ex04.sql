--  "Неповторяющееся чтение" (Non-Repeatable Reads), на уровне изоляции SERIALIZABLE.

-- Сессия #1
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 3.6
-- session #2 update rating to 3
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 3.6
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 3



-- Сессия #2
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE pizzeria SET rating=3 WHERE name='Pizza Hut';
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating 3