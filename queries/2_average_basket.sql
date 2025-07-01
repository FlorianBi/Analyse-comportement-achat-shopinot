/*---Quel est le panier moyen par client ? Pour évaluer la valeur moyenne d’un client.---*/

/*Version simple */

SELECT 
    last_name AS Nom
    , first_name AS Prenom 
    , COUNT(order_id) AS nb_commandes
    , ROUND(AVG(total_amount), 2) AS Panier_moyen 
FROM orders
INNER JOIN customer
ON customer.customer_id = orders.customer_id
GROUP BY orders.customer_id



/*Version optimisé : Quel est le panier moyen pour client spécifique en fonction de lannée choisie  ?
*/
SELECT last_name AS Nom,first_name AS Prenom ,  AVG(total_amount) AS Panier_moyen 
FROM orders
INNER JOIN customer
ON customer.customer_id = orders.customer_id
WHERE customer.customer_id = 1500 AND YEAR(order_date) = 2024
GROUP BY orders.customer_id ;