SELECT id as menu_id FROM menu

EXCEPT

SELECT DISTINCT menu_id  FROM person_order

order by 1