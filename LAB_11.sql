USE 
	sakila;

#Write a query to display for each store its store ID, city, and country.

CREATE TEMPORARY TABLE
	store_country
SELECT
	s.store_id, c.city, co.country, a.address_id
FROM
	store s
JOIN
	address a
USING
	(address_id)
JOIN
	city c
USING
	(city_id)
JOIN 
	country co
USING
	(country_id);
    
SELECT 
	store_id, city, country
FROM 
	store_country;

#Write a query to display how much business, in dollars, each store brought in.

CREATE TEMPORARY TABLE
	store_business1
SELECT
	s.store_id,st.staff_id,sum(p.amount) as amount
FROM
	store s
JOIN
	staff st
USING
	(store_id)
JOIN
	payment p
USING
	(staff_id)
GROUP BY
	s.store_id, st.staff_id;
    
SELECT
	store_id, amount
FROM
	store_business1;
    
CREATE TEMPORARY TABLE
	customer_business
SELECT
	s.store_id,c.customer_id, p.amount
FROM
	store s
JOIN
	customer c
USING
	(store_id)
JOIN
	payment p
USING
	(customer_id);
    
SELECT 
	store_id, sum(amount)
FROM 
	customer_business
GROUP BY
	store_id;


#What is the average running time of films by category?

CREATE TEMPORARY TABLE
	film_cat_avg_len3
SELECT
	f.film_id, fc.category_id, c.name, avg(f.length) as length
FROM
	film f
JOIN
	film_category fc
USING
	(film_id)
JOIN
	category c
USING
	(category_id)
GROUP BY 
	c.name;
    
SELECT
	name, round(length)
FROM 
	film_cat_avg_len3;

#Which film categories are longest?

SELECT
	name, round(length) as length_avg
FROM 
	film_cat_avg_len3
ORDER BY
	length DESC;

#Display the most frequently rented movies in descending order.

CREATE TEMPORARY TABLE
	film_rental1
SELECT
	f.film_id, f.title, i.inventory_id, r.rental_id as num_of_rentals
FROM
	film f
JOIN
	inventory i
USING
	(film_id)
JOIN
	rental r
USING
	(inventory_id);

SELECT
	title, count(num_of_rentals) as rentals
FROM 
	film_rental1
GROUP BY
	title
ORDER BY
	rentals DESC;


#List the top five genres in gross revenue in descending order.

CREATE TEMPORARY TABLE
	category_rev
SELECT
	c.name, fc.category_id, i.inventory_id, r.rental_id, p.amount
FROM
	category c 
JOIN
	film_category fc
USING
	(category_id)
JOIN
	inventory i
USING
	(film_id)
JOIN
	rental r
USING
	(inventory_id)
JOIN
	payment p
USING
	(rental_id);
    
SELECT
	name, sum(amount) as amount
FROM
	category_rev
GROUP BY
	name
ORDER BY
	amount DESC
LIMIT
	5;

#Is "Academy Dinosaur" available for rent from Store 1?

CREATE TEMPORARY TABLE
	dinosaur
SELECT
	f.title, i.film_id, s.store_id,inventory_id
FROM
	film f
JOIN
	inventory i
USING
	(film_id)
JOIN rental r
using (inventory_id)    
JOIN
	store s
USING
	(store_id);
    
SELECT
	title, store_id, inventory_id
FROM 
	dinosaur
WHERE 
	title = "Academy dinosaur"
GROUP BY
	store_id, inventory_id
HAVING
	store_id = 1;
    

    


