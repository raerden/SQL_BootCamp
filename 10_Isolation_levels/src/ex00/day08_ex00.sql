--  Simple transaction

-- Сессия #1
-- Начало транзакции
BEGIN;
-- Вносим изменения в БД
UPDATE pizzeria SET rating=5 WHERE name='Pizza Hut';
-- Проверяем внесенные изменения
SELECT * FROM pizzeria WHERE name='Pizza Hut';
-- Конец транзакции
COMMIT;


-- Сессия #2
-- Получаем данные из базы
SELECT * FROM pizzeria WHERE name='Pizza Hut';

