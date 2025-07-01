---Quels sont les produits les plus vendus chaque mois ?---
/**/
with all_products AS(
        SELECT 
            order_id
            , product_name
            , COUNT(quantity) as count_quantity 
        FROM order_item 
        INNER JOIN products
        ON order_item.product_id = products.product_id
    	GROUP BY product_name
), 
products_final AS (   
    SELECT 
        YEAR(order_date ) AS years
        , MONTH( order_date ) as months
        , product_name
        , count_quantity
    FROM orders
    INNER JOIN all_products
    ON orders.order_id = all_products.order_id
    GROUP BY product_name, YEAR(order_date ), MONTH( order_date ) 
    
)
    
SELECT 
    years
    , months
    , product_name
    , MAX(count_quantity) as quantity
FROM products_final
GROUP BY years, months
ORDER BY years, months
