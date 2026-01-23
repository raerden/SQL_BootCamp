-- "Фантомное чтение" (phantom reads), но на уровне изоляции READ COMMITTED

-- Сессия #1
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT SUM(rating) FROM pizzeria; 				-- sum: 21.9
-- Session #2 INSERT 'Kazan Pizza' rating=5
-- Session #2 COMMIT;
SELECT SUM(rating) FROM pizzeria; 				-- sum: 26.9 Фантомные данные внутри одной транзакции.
COMMIT;
SELECT SUM(rating) FROM pizzeria; 				-- sum: 26.9



-- Сессия #2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO pizzeria (id, name, rating) VALUES (10, 'Kazan Pizza', 5);
COMMIT;
SELECT SUM(rating) FROM pizzeria; 				-- sum: 26.9
