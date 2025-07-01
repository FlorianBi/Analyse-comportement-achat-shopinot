/*---Quelles sont les heures et jours de la semaine les plus actifs ? ---*/
/*Base de données ne collectait pas l'heure donc nous allons identifier le jour uniquement*/

with all_sell_by_day AS(
    SELECT YEAR(order_date) AS years
    		, MONTH(order_date) AS months
            , DAYNAME(order_date) AS jour_commande
            , COUNT(order_id) AS nbre_commande
    FROM orders
    GROUP BY YEAR(order_date), MONTH(order_date), jour_commande 

)

SELECT years
		, months
        , jour_commande
        , MAX(nbre_commande) AS Maxi_commande
FROM all_sell_by_day
GROUP BY years, months 