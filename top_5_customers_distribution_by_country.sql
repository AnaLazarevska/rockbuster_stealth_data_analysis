-- This query analyses customer distribution across countries, identifying the countries where the top 5 spending customers from top 10 cities in the top 10 countries reside.

WITH
  -- Identify the top 10 countries with the most customers
  top_10_countries 
  AS (
    SELECT 
      D.country
    FROM customer A
      INNER JOIN address B ON A.address_id = B.address_id
      INNER JOIN city C ON B.city_id = C.city_id
      INNER JOIN country D ON C.country_id = D.country_id
    GROUP BY 
      D.country
    ORDER BY 
      COUNT(A.customer_id) DESC
    LIMIT 10
  ),
  -- Identify the top 10 cities within the top 10 countries based on customer count
  top_10_cities 
  AS (
    SELECT 
      D.city,
      E.country
    FROM payment A
      INNER JOIN customer B ON A.customer_id = B.customer_id
      INNER JOIN address C ON B.address_id = C.address_id
      INNER JOIN city D ON C.city_id = D.city_id
      INNER JOIN country E ON D.country_id = E.country_id
    WHERE country IN (SELECT country FROM top_10_countries)
    GROUP BY 
      D.city, 
      E.country
    ORDER BY 
      COUNT(A.customer_id) DESC
    LIMIT 10
  ),
  -- Calculate total payment for top 5 spending customers in top 10 cities
  total_amount_paid 
  AS (
    SELECT 
      A.customer_id,
      B.first_name,
      B.last_name,
      D.city,
      E.country,
      SUM(A.amount) AS paid
    FROM payment A
      INNER JOIN customer B ON A.customer_id = B.customer_id
      INNER JOIN address C ON B.address_id = C.address_id
      INNER JOIN city D ON C.city_id = D.city_id
      INNER JOIN country E ON D.country_id = E.country_id
    WHERE city IN (SELECT city FROM top_10_cities)
    GROUP BY 
      A.customer_id, 
      B.last_name, 
      B.first_name, 
      D.city, 
      E.country
  ORDER BY 
    paid DESC
  LIMIT 5
  )
SELECT 
  A.country,
  COUNT(DISTINCT D.customer_id) AS all_customer_count,
  COUNT(DISTINCT E.customer_id) AS top_customer_count
FROM country A
  INNER JOIN city B ON A.country_id = B.country_id
  INNER JOIN address C ON B.city_id = C.city_id
  INNER JOIN customer D ON C.address_id = D.address_id
  LEFT JOIN total_amount_paid E ON A.country = E.country
GROUP BY 
  A.country
ORDER BY 
  top_customer_count DESC,
  A.country;
