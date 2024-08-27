-- This query retrieves customer information including their active status, name, city, and country.

SELECT				
	A.customer_id, 			
	A.active,			
	A.first_name,			
	A.last_name,			
	C.city_id,			
	C.city,			
	D.country_id,			
	D.country			
FROM customer A				
	INNER JOIN address B ON A.address_id = B.address_id			
	INNER JOIN city C ON B.city_id = C.city_id			
	INNER JOIN country D ON C.country_id = D.country_id			
ORDER BY 
  country, 
  city, 
  last_name, 
  first_name;				
