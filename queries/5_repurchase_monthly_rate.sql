DROP TEMPORARY TABLE IF EXISTS temp_all_customers_monthly;
DROP TEMPORARY TABLE IF EXISTS temp_all_customers_rebuy;

CREATE TEMPORARY TABLE temp_all_customers_monthly AS
	SELECT 
    	YEAR(order_date) AS years
    	,MONTH(order_date) AS months
        ,COUNT(DISTINCT customer_id) AS nombre_client_mensuel
    FROM orders
    GROUP BY years, months;

CREATE TEMPORARY TABLE temp_all_customers_rebuy AS
with all_customers AS (
    /*recuperer les clients ayant plus dun achat par mois*/
        SELECT YEAR(order_date) AS years
    			, MONTH(order_date) AS months
    			, customer_id
    			, COUNT(order_id) AS client_achat_sup
   
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
)
SELECT * FROM all_customers_rebuy;


SELECT 
    temp_all_customers_rebuy.years AS annee
    ,temp_all_customers_rebuy.months AS mois
    ,temp_all_customers_monthly.nombre_client_mensuel AS nombre_client_mensuel
    ,temp_all_customers_rebuy.nombre_client_reachat AS nombre_client_reachat
    ,ROUND((
        temp_all_customers_rebuy.nombre_client_reachat
        /temp_all_customers_monthly.nombre_client_mensuel
    )*100 , 2) AS Taux_reachat_mensuel
FROM temp_all_customers_rebuy
INNER JOIN temp_all_customers_monthly
ON temp_all_customers_rebuy.months=temp_all_customers_monthly.months
GROUP BY annee, mois;