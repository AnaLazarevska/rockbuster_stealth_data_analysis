-- This query calculates the number of inventory copies in each store.

WITH 				
  -- Calculate the number of inventory copies in store 1
	copies_store_1 (store_id, inventory_1)			
	AS (			
		SELECT 		
			store_id,	
			COUNT(inventory_id) AS inventory_1 	
		FROM inventory		
		WHERE store_id = 1		
		GROUP BY 
      store_id		
	),			
  -- Calculate the number of inventory copies in store 2
	copies_store_2 (store_id, inventory_2)			
	AS (			
		SELECT 		
			store_id,	
			COUNT(inventory_id) AS inventory_2 	
		FROM inventory		
		WHERE store_id = 2		
		GROUP BY 
      store_id		
	)			
SELECT 				
	COUNT(B.inventory_1) AS inventory_store_1, 			
	COUNT(C.inventory_2) AS inventory_store_2			
FROM inventory A				
LEFT JOIN copies_store_1 B ON A.store_id = B.store_id				
LEFT JOIN copies_store_2 C ON A.store_id = C.store_id				
