--Загальна кількість фільмів у кожній категорії: Напишіть SQL-запит, який виведе назву категорії та кількість фільмів у кожній категорії.
SELECT category.name AS category_name, COUNT(film.film_id) AS film_count
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

--Середня тривалість фільмів у кожній категорії: Напишіть запит, який виведе назву категорії та середню тривалість фільмів у цій категорії.
SELECT category.name AS category_name, AVG(film.length) AS average_length
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

--Мінімальна та максимальна тривалість фільмів: Напишіть запит, який виведе мінімальну та максимальну тривалість фільмів у базі даних.
SELECT MIN(length) AS min_length, MAX(length) AS max_length
FROM film;

--Загальна кількість клієнтів: Напишіть запит, який поверне загальну кількість клієнтів у базі даних.
SELECT COUNT(customer_id) AS total_customers
FROM customer;

--Сума платежів по кожному клієнту: Напишіть запит, який виведе ім'я клієнта та загальну суму платежів, яку він здійснив.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_payments
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

--П'ять клієнтів з найбільшою сумою платежів: Напишіть запит, який виведе п'ять клієнтів, які здійснили найбільшу кількість платежів, у порядку спадання.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_payments
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY total_payments DESC
LIMIT 5;

--Загальна кількість орендованих фільмів кожним клієнтом: Напишіть запит, який поверне ім'я клієнта та кількість фільмів, які він орендував.
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS total_rentals
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

--Середній вік фільмів у базі даних: Напишіть запит, який виведе середній вік фільмів (різниця між поточною датою та роком випуску фільму).
SELECT AVG(EXTRACT(YEAR FROM NOW()) - f.release_year) AS average_age
FROM film f;

--Кількість фільмів, орендованих за певний період: Напишіть запит, який виведе кількість фільмів, орендованих у період між двома вказаними датами.
SELECT COUNT(rental_id) AS total_rentals
FROM rental
WHERE rental_period && tsrange('2005-05-20 00:00:00', '2005-07-15 23:59:59');

--Сума платежів по кожному місяцю: Напишіть запит, який виведе загальну суму платежів, здійснених кожного місяця.
SELECT TO_CHAR(payment.payment_date, 'YYYY-MM') AS payment_month, 
       SUM(payment.amount) AS total_payments
FROM payment
GROUP BY payment_month;

--Максимальна сума платежу, здійснена клієнтом: Напишіть запит, який виведе максимальну суму окремого платежу для кожного клієнта.
SELECT customer.first_name, customer.last_name, MAX(payment.amount) AS max_payment
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

--Середня сума платежів для кожного клієнта: Напишіть запит, який виведе ім'я клієнта та середню суму його платежів.
SELECT customer.first_name, customer.last_name, AVG(payment.amount) AS average_payment
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

--Кількість фільмів у кожному рейтингу (rating): Напишіть запит, який поверне кількість фільмів для кожного з можливих рейтингів (G, PG, PG-13, R, NC-17).
SELECT film.rating, COUNT(film.film_id) AS film_count
FROM film
GROUP BY film.rating;

--Середня сума платежів по кожному магазину (store): Напишіть запит, який виведе середню суму платежів, здійснених у кожному магазині.
SELECT store.store_id, AVG(payment.amount) AS average_payment
FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;