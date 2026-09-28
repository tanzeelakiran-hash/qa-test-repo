-- Complex CTEs and Joins
-- Demonstrates Common Table Expressions with multiple joins

WITH customer_orders AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        COUNT(o.order_id) as total_orders,
        SUM(o.order_amount) as total_spent
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
    GROUP BY c.customer_id, c.customer_name
),
product_categories AS (
    SELECT 
        p.product_id,
        p.product_name,
        c.category_name,
        p.unit_price
    FROM products p
    INNER JOIN categories c ON p.category_id = c.category_id
),
order_details_enriched AS (
    SELECT 
        od.order_id,
        od.product_id,
        od.quantity,
        od.unit_price,
        pc.product_name,
        pc.category_name,
        (od.quantity * od.unit_price) as line_total
    FROM order_details od
    INNER JOIN product_categories pc ON od.product_id = pc.product_id
)
SELECT 
    co.customer_name,
    co.total_orders,
    co.total_spent,
    ode.category_name,
    SUM(ode.line_total) as category_total
FROM customer_orders co
INNER JOIN orders o ON co.customer_id = o.customer_id
INNER JOIN order_details_enriched ode ON o.order_id = ode.order_id
GROUP BY co.customer_name, co.total_orders, co.total_spent, ode.category_name
ORDER BY co.total_spent DESC;