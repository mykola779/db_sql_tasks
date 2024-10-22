--Частина 1: Запити на вибірку даних (SELECT)
--Отримання списку фільмів та їх категорій: Напишіть SQL-запит, який виведе назву фільму, тривалість і категорію для кожного фільму.
SELECT film.title AS "Назва фільму", 
       film.length AS "Тривалість (хв)", 
       category.name AS "Категорія"
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id;


--Фільми, орендовані певним клієнтом: Напишіть запит, який виведе список фільмів, орендованих одним із клієнтів, разом з датами оренди.
SELECT 
    f.title AS "Назва фільму",
    r.rental_period AS "Дата оренди"
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    c.customer_id = 123;
    
--Популярність фільмів: Напишіть запит, який виведе топ-5 найпопулярніших фільмів на основі кількості оренд.
SELECT 
	f.title AS "Назва фільму", COUNT(r.rental_id) AS "Кількість оренд"
FROM 
	film f
JOIN 
	inventory i ON f.film_id = i.film_id
JOIN 
	rental r ON i.inventory_id = r.inventory_id
GROUP BY 
	f.title
ORDER BY 
	"Кількість оренд" DESC
LIMIT 
	5;

--Частина 2: Маніпуляції з даними (INSERT, UPDATE, DELETE)
--Додавання нового клієнта: Додайте новий запис у таблицю клієнтів. Ім'я клієнта — "Alice Cooper", адреса — "123 Main St", місто — "San Francisco".

WITH country_insert AS (
    INSERT INTO country (country)
    VALUES ('USA')
    RETURNING country_id
),

city_insert AS (
    INSERT INTO city (city, country_id)
    VALUES ('San Francisco', (SELECT country_id FROM country_insert))
    RETURNING city_id
),

address_insert AS (
    INSERT INTO address (address, district, phone, city_id)
    VALUES ('123 Main St', 'Central District', '1235213412', (SELECT city_id FROM city_insert))
    RETURNING address_id
)

INSERT INTO customer (first_name, last_name, address_id, store_id)
VALUES ('Alice', 'Cooper', (SELECT address_id FROM address_insert), 1);  

--Оновлення адреси клієнта: Оновіть адресу клієнта "Alice Cooper" на "456 Elm St".
UPDATE address
SET address = '456 Elm St'
WHERE address_id = (
    SELECT address_id
    FROM customer
    WHERE first_name = 'Alice' AND last_name = 'Cooper'
);

--Видалення клієнта: Видаліть запис про клієнта "Alice Cooper" з бази даних.
DELETE FROM customer
WHERE first_name = 'Alice' AND last_name = 'Cooper';

SELECT * FROM customer
WHERE first_name = 'Alice' AND last_name = 'Cooper';
