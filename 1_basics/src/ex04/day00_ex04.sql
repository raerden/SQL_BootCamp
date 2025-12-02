SELECT name || ' (age:' || age || ',gender:''' || gender || ''',adress:''' || address || ''')' as person_information 
FROM person 
ORDER BY person_information;