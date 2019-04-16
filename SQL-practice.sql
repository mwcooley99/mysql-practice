USE sakila;

DESCRIBE actor;

# 1a
SELECT first_name, last_name
FROM actor
ORDER BY last_name, first_name;

# 1b
SELECT concat(upper(first_name), ' ', upper(last_name)) AS `Actor Name`
FROM actor
ORDER BY `Actor Name`;

# 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

# 2b
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

# 2c
SELECT *
FROM actor
WHERE last_name REGEXP 'LI';

# 2d
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

# 3a
ALTER TABLE actor
ADD description BLOB;

DESCRIBE actor;

# 3b
ALTER TABLE actor
DROP COLUMN description;

DESCRIBE actor;

# 4a
SELECT last_name, COUNT(last_name) as last_name_count
FROM actor
GROUP BY last_name;

# 4b
SELECT last_name, COUNT(last_name) as last_name_count
FROM actor
GROUP BY last_name
HAVING last_name_count > 1;

# 4c
# Find actor
SELECT first_name, last_name
FROM actor
WHERE first_name = 'Groucho' and last_name = 'Williams';

# Update actor name
UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'Groucho' and last_name = 'Williams';

# Check to see if the name is updated
SELECT first_name, last_name
FROM actor
WHERE first_name = 'Harpo' and last_name = 'Williams';

# 4d
UPDATE actor
SET first_name = 'Groucho'
WHERE first_name = 'Harpo' and last_name = 'Williams';

SELECT first_name, last_name
FROM actor
WHERE first_name = 'Groucho' and last_name = 'Williams';

# 5a
SHOW CREATE TABLE address;

# 6a
SELECT s.first_name, s.last_name,
       CONCAT(a.address, ' ' , c.city, ' ', a.postal_code) as address
FROM staff AS s
LEFT JOIN address as a ON s.address_id = a.address_id
LEFT JOIN city as c ON a.city_id = c.city_id;

# 6b
SELECT CONCAT(s.first_name, ' ', s.last_name) AS Name, SUM(p.amount) AS Total_Sales
FROM staff s LEFT JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id
ORDER BY Total_Sales DESC;

# 6c
SELECT f.title, COUNT(fa.actor_id) as Actor_Count
FROM film f INNER JOIN film_actor fa
       ON f.film_id = fa.film_id
GROUP BY f.film_id
ORDER BY Actor_Count DESC;

# 6d
SELECT f.title, COUNT(inv.film_id) as `Number of Copies`
FROM inventory inv LEFT JOIN film f
       ON inv.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

# 6e
SELECT c.first_name, c.last_name, SUM(p.amount) AS `Total Amount Paid`
FROM customer c LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

# 7a
SELECT title FROM film
WHERE (title LIKE 'Q%') OR (title LIKE 'K%')
ORDER BY title;

# 7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
                     FROM film_actor
                     WHERE film_id IN (SELECT film_id
                                          FROM film
                                          WHERE title = 'Alone Trip')) ;
# 7c
SELECT c.first_name, c.last_name, c.email, c3.country
FROM customer c LEFT JOIN address a ON c.address_id = a.address_id
LEFT JOIN city c2 ON a.city_id = c2.city_id
LEFT JOIN country c3 ON c2.country_id = c3.country_id
WHERE c3.country = 'Canada';

# 7d
SELECT f.title
FROM film f
    LEFT JOIN film_category fc ON f.film_id = fc.film_id
    LEFT JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

# 7e
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
    LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
    LEFT JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY rental_count DESC;

# 7F
SELECT s.store_id, SUM(p.amount) as total_sales
FROM store s
    LEFT JOIN staff s2 ON s.store_id = s2.store_id
    LEFT JOIN payment p ON s2.staff_id = p.staff_id
GROUP BY s.store_id;

# 7g
SELECT s.store_id, c.city, c2.country
FROM store s
    LEFT JOIN address a ON s.address_id = a.address_id
    LEFT JOIN city c ON a.city_id = c.city_id
    LEFT JOIN country c2 ON c.country_id = c2.country_id;

# 7h
SELECT c.name, SUM(p.amount) as gross_revenue
FROM payment p
    LEFT JOIN rental r ON r.rental_id = p.rental_id
    LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
    LEFT JOIN film f ON i.film_id = f.film_id
    LEFT JOIN film_category fc ON f.film_id = fc.film_id
    LEFT JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

# 8a
CREATE VIEW top_five_genres AS
    SELECT c.name, SUM(p.amount) as gross_revenue
FROM payment p
    LEFT JOIN rental r ON r.rental_id = p.rental_id
    LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
    LEFT JOIN film f ON i.film_id = f.film_id
    LEFT JOIN film_category fc ON f.film_id = fc.film_id
    LEFT JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

# 8b
SELECT * FROM top_five_genres;

# 8c
DROP VIEW top_five_genres;


