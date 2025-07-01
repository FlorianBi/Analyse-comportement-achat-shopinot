/*---Quel est le taux de réachat annuel ? ---*/

with all_customers AS (
    /*recuperer les clients ayant plus dun achat par mois*/
        SELECT YEAR(order_date) AS years
    			,MONTH(order_date) AS months
    			, customer_id
    			, COUNT(DISTINCT customer_id) AS client_achat_sup
   
        FROM orders
        GROUP BY YEAR(order_date)
    			, MONTH(order_date)
    			, customer_id
        HAVING COUNT(order_id) > 1
), 
all_customers_rebuy AS (
    SELECT years, months, COUNT(client_achat_sup) AS nombre_client_reachat
    FROM all_customers
    GROUP BY years, months
), 
/*Selectionne tous les achats sans exception*/ 
all_customers_monthly AS (
    SELECT COUNT(order_id) AS nombre_client_mensuel
    		,YEAR(order_date) AS years
    		,MONTH(order_date) AS months
    FROM orders
    GROUP BY years, months
), 
count_all_customers_rebuy AS (
    SELECT years, SUM(nombre_client_reachat) AS count_rebuy
    FROM all_customers_rebuy
), 
count_all_customers_monthly AS (
    SELECT SUM(nombre_client_mensuel) AS count_monthly
    FROM all_customers_monthly
)

SELECT years FROM all_customers_monthly;

SELECT years, count_rebuy/count_monthly*100 AS Taux_reachat_annuel
FROM count_all_customers_monthly
JOIN count_all_customers_rebuy
ON 1=1;

