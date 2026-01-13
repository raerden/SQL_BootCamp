-- добавить комментарии к таблице и ее столбцам.
COMMENT ON TABLE person_discounts IS 'Таблица персональных скидок клиентов в пиццериях';
COMMENT ON COLUMN person_discounts.id IS 'PRIMARY KEY записи';
COMMENT ON COLUMN person_discounts.person_id IS 'FOREIGN KEY. ID клиента из таблицы persons';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'FOREIGN KEY. ID пиццерии из таблицы pizzeria';
COMMENT ON COLUMN person_discounts.discount IS 'Размер персональной скидки клиента в пиццерии в процентах';

--просмотреть комментарии
SELECT obj_description('person_discounts'::regclass);
SELECT col_description('person_discounts'::regclass, ordinal_position)
FROM information_schema.columns
WHERE table_name = 'person_discounts';

-- Удалить комментарии
COMMENT ON TABLE person_discounts IS NULL;
COMMENT ON COLUMN person_discounts.id IS NULL;
COMMENT ON COLUMN person_discounts.person_id IS NULL;
COMMENT ON COLUMN person_discounts.pizzeria_id IS NULL;
COMMENT ON COLUMN person_discounts.discount IS NULL;

