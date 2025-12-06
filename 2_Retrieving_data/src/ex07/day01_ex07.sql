SELECT order_date, name || ' (age:' || age || ')' as person_information FROM person_order
INNER JOIN person
ON person.id = person_order.person_id
ORDER BY order_date, person_information