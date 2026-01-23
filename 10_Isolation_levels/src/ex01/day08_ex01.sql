--  "Аномалия потери обновления" (Lost Update Anomaly)

-- Сессия #1
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; 		-- rating: 5
UPDATE pizzeria SET rating=4 WHERE name='Pizza Hut';
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut';		-- rating: 3.6



-- Сессия #2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM pizzeria WHERE name='Pizza Hut';		-- rating: 5
-- session #1 update rating to 4
UPDATE pizzeria SET rating=3.6 WHERE name='Pizza Hut';
-- **Ожидание commit in session #1
-- Finished update after commit in session #1
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut';		-- rating: 3.6

-- Обновление рейтинга до 4 в сессии #1 потеряно.