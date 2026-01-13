DROP TABLE IF EXISTS person_discounts;

CREATE TABLE person_discounts (
    id BIGINT PRIMARY KEY,
    person_id BIGINT,
    pizzeria_id BIGINT,
    discount NUMERIC,

    CONSTRAINT fk_person_discounts_person_id
        FOREIGN KEY (person_id) REFERENCES person(id),

    CONSTRAINT fk_person_discounts_pizzeria_id
        FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id)
);


SELECT 
    table_name, constraint_name, constraint_type  
FROM information_schema.table_constraints
WHERE table_name = 'person_discounts'
  AND constraint_type = 'FOREIGN KEY';



