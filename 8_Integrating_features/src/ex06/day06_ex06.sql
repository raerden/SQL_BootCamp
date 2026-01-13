-- Удалить последовательность значений
DROP SEQUENCE IF EXISTS seq_person_discounts CASCADE;

CREATE SEQUENCE seq_person_discounts 
START WITH 1
INCREMENT BY 1

-- установить взятие следующего значения из последовательности
ALTER TABLE person_discounts
ALTER COLUMN id SET DEFAULT nextval('seq_person_discounts');

-- передвинуть последовательность на количество строк в person_discounts
SELECT setval(
    'seq_person_discounts',
    (SELECT COUNT(*)+1 FROM person_discounts)
);


INSERT INTO person_discounts (person_id, pizzeria_id, discount)
VALUES
	(1,4,50),
	(2,5,60)

SELECT * FROM person_discounts;

DELETE FROM person_discounts WHERE id > 13;



