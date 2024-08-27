-- This query retrieves payment information for rentals, including customer details and location.

SELECT 			
	F.rental_id,		
	A.amount, 		
	B.customer_id,		
	B.first_name,		
	B.last_name,		
	B.active,		
	D.city,		
	E.country		
FROM payment A			
	INNER JOIN rental F ON A.rental_id = F.rental_id		
	INNER JOIN customer B ON A.customer_id = B.customer_id		
	INNER JOIN address C ON B.address_id = C.address_id		
	INNER JOIN city D ON C.city_id = D.city_id		
	INNER JOIN country E ON D.country_id = E.country_id		
ORDER BY 
  	last_name;
