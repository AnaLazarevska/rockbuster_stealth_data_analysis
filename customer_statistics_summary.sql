-- This query calculates various statistics about the customer table, including active and inactive customers, store distribution, and customer creation dates.

WITH 					
	-- Calculate the number of active customers for each customer id 
	active_customers (customer_id, active_customers)						
	AS (
		SELECT 					
			customer_id,				
			COUNT(customer_id) AS active_customers				
		FROM customer					
		WHERE active = 1					
		GROUP BY 
			customer_id					
	),					
	-- Calculate the number of inactive customers for each customer id inactive_customers (customer_id, inactive_customers)						
	AS (						
		SELECT 					
			customer_id,				
			COUNT(customer_id) AS inactive_customers				
		FROM customer					
		WHERE active = 0					
		GROUP BY 
			customer_id					
		),			
	-- Calculate the number of customers associated with store 1 for each customer id 
	customers_store_1 (customer_id, store_id)						
	AS (						
		SELECT 					
			customer_id,				
			COUNT(store_id) AS customers_store_1				
		FROM customer					
		WHERE store_id = 1					
		GROUP BY 
      			customer_id					
	),						
	-- Calculate the number of customers associated with store 2 for each customer id
	customers_store_2 (customer_id, store_id)						
	AS (						
		SELECT 					
			customer_id,				
			COUNT(store_id) AS customers_store_2				
		FROM customer					
		WHERE store_id = 2					
		GROUP BY 
      			customer_id					
	)						
SELECT 							
	COUNT(B.customer_id) AS active_customers,						
	COUNT(C.customer_id) AS inactive_customers,						
	MIN(A.store_id) AS min_store_id,						
	MAX(A.store_id) AS max_store_id,						
	MIN(A.create_date) AS min_create_date,						
	MAX(A.create_date) AS max_create_date,						
	COUNT(D.store_id) AS customers_store_1,						
	COUNT(E.store_id) AS customers_store_2						
FROM customer A							
	LEFT JOIN active_customers B ON A.customer_id = B.customer_id						
	LEFT JOIN inactive_customers C ON A.customer_id = C.customer_id						
	LEFT JOIN customers_store_1 D ON A.customer_id = D.customer_id						
	LEFT JOIN customers_store_2 E ON A.customer_id = E.customer_id						
GROUP BY 
	B.active_customers, 
	C.inactive_customers;			
