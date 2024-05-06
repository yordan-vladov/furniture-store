CREATE VIEW products_with_categories AS
SELECT p.product_id, p.name AS product_name, p.description, p.price, c.name AS category
FROM products p
JOIN product_categories pc ON p.product_id = pc.product_id
JOIN categories c ON pc.category_id = c.category_id;

CREATE VIEW customer_orders AS
SELECT c.customer_id, c.name AS customer_name, c.email, c.phone, o.order_id, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

CREATE VIEW high_priced_products AS
SELECT *
FROM products
WHERE price > 1000;
