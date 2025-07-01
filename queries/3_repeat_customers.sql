/*---Combien de clients commandent plus d’une fois par mois.---*/

with all_customers AS (
    	/*recuperer les clients ayant plus dun achat par mois*/
        SELECT YEAR(order_date) AS years
    			,MONTH(order_date) AS months
    			, customer_id
    			, COUNT(order_id) AS client_achat_sup
        FROM orders
        GROUP BY YEAR(order_date)
    			, MONTH(order_date)
    			, customer_id
        HAVING COUNT(order_id) > 1
    )
    
SELECT years, months, COUNT(client_achat_sup) AS nombre_client_mensuel
FROM all_customers
GROUP BY years, months;