CREATE INDEX IF NOT EXISTS idx_menu_pizzeria_id ON menu (pizzeria_id);

CREATE INDEX IF NOT EXISTS idx_person_order_person_id ON person_order (person_id);
CREATE INDEX IF NOT EXISTS idx_person_order_menu_id ON person_order (menu_id);

CREATE INDEX IF NOT EXISTS idx_person_visits_person_id ON person_visits (person_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_pizzeria_id ON person_visits (pizzeria_id);

-- Проверка созданных индексов
SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'public'
AND SUBSTR(indexname,1,4) = 'idx_'
ORDER BY tablename, indexname;