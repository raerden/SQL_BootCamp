DROP VIEW v_persons_female;
DROP VIEW v_persons_male;
DROP VIEW v_generated_dates; 
DROP VIEW v_price_with_discount;
DROP VIEW v_symmetric_union;
DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;


-- посмотреть список всех таблиц представления по типам

-- SELECT viewname AS name, 'VIEW' AS type
-- FROM pg_views
-- WHERE schemaname = 'public'

-- UNION ALL

-- SELECT matviewname AS name, 'MATERIALIZED VIEW' AS type
-- FROM pg_matviews
-- WHERE schemaname = 'public';
