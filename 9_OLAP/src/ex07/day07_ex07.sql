-- Вернуть общий средний рейтинг для всех ресторанов

SELECT 
	round(avg(rating) , 4) AS global_rating
FROM pizzeria;

