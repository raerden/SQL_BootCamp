--  "Аномалию потери обновления" (Lost Update Anomaly), но на уровне изоляции REPEATABLE READ. 

-- Сессия #1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM pizzeria WHERE name='Pizza Hut';			-- rating: 3.6
UPDATE pizzeria SET rating=4 WHERE name='Pizza Hut';
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut';			-- rating: 4



-- Сессия #2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM pizzeria WHERE name='Pizza Hut';			-- rating: 3.6
UPDATE pizzeria SET rating=3.6 WHERE name='Pizza Hut';
-- **waiting for commit udpdate in session #1
-- COMMIT; in session #1
-- ERROR:  could not serialize access due to concurrent update
COMMIT;
-- ROLLBACK
SELECT * FROM pizzeria WHERE name='Pizza Hut';			-- rating: 4

-- Postgres запрещает второй сессии перезаписать те данные которые обновились в сессии1
-- несмотря на то что обе сессии работают со своим снимком состояния на начало транзакции