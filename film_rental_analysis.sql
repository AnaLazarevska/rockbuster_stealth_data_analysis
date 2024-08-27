-- This query analyses film rentals, calculating revenue and displaying rental duration by film title and rental id.

SELECT 				
	D.title, 			
	B.rental_id,			
	F.name AS genre, 			
	B.return_date::DATE - B.rental_date::DATE AS days_rented_out,			
	COALESCE(SUM(A.amount), 0) AS revenue			
FROM film D				
	INNER JOIN film_category E ON D.film_id = E.film_id			
	INNER JOIN category F ON E.category_id = F.category_id			
	LEFT JOIN inventory C ON D.film_id = C.film_id			
	LEFT JOIN rental B ON C.inventory_id = B.inventory_id			
	LEFT JOIN payment A ON A.rental_id = B.rental_id			
GROUP BY 
  D.title, 
  B.rental_id, 
  F.name, 
  B.return_date, 
  B.rental_date				
ORDER BY 
  title, 
  rental_id;				
