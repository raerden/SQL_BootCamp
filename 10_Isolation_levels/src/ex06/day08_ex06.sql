--  "Фантомное чтение" (Phantom Reads), но на уровне изоляции REPEATABLE READ

-- Сессия #1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;	-- Снимок на всю транзакцию
SELECT SUM(rating) FROM pizzeria; 				-- sum: 26.9
-- Session #2 INSERT 'Kazan Pizza 2' rating=4
-- Session #2 COMMIT;
SELECT SUM(rating) FROM pizzeria; 				-- sum: 26.9 - Фантом отсутствует. Одни данные в пределах текущей транзакции
COMMIT;
SELECT * FROM pizzeria WHERE name='Pizza Hut'; -- rating: 30.9



-- Сессия #2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
INSERT INTO pizzeria (id, name, rating) VALUES (11, 'Kazan Pizza 2', 4);
COMMIT;
SELECT SUM(rating) FROM pizzeria; 				-- sum: 30.9


