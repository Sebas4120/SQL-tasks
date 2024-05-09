Use sakila;

-- Write a query to show the first 8 movie names and their released year in the film table.
SELECT title,release_year
From film
Order by release_year
Limit 8;

-- Write a query showing the first 7 'R' rated movies in the film table
SELECT title,release_year,rating
From film
Where rating="R"
Limit 7;

-- Do we have any actors or actresses with the name of Penelope on the actor's table? 
SELECT first_name,last_name
From actor
Where first_name like "Penelope";




-- Show all the actors with the name of Penelope (Q3), but show them sorted 
-- in alphabetical order based on their last names. (Show first and last name 
-- in one column as ‘Full name’)
SELECT 
	concat(first_name," ",last_name) As "Full name"
From actor
Where first_name like "Penelope"
Order by last_name;

-- Do we have any actors or actresses with the first name 
-- of Penelope and the last name of 'Cruz' on the actor's 
-- table? Show her in the result window. 
SELECT 
	concat(first_name," ",last_name) As "Full name"
From actor
Where first_name like "Penelope" and last_name like "Cruz"
Order by last_name;

-- Report all the actor's names starting with "Gi" in the actor’s table
SELECT 
	concat(first_name," ",last_name) As "Full name"
From actor
Where first_name REGEXP "^Gi"
Order by last_name;

-- In the payment table, we need to show the payment
-- Id of all the payment amounts greater than (or equal to) 
-- 8 and less than or equal to 8.99. (Use Between)

Select payment_id,amount
From payment
Where amount between 8 and 8.99;



-- Show all the 46-minute movies with a value in their language id. 
Select language_id,length
From film
Where length=46;

-- Show all the Canadian cities. (Find the country code in the country table and use it in your query).  
Select city_id,city,country_id
From city
Where country_id=20;

Select city
From city
Where country_id = (Select country_id From country Where country = 'Canada');