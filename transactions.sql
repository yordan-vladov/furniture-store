START TRANSACTION;

INSERT INTO customers (name, email, phone) VALUES ('Alice', 'alice@example.com', '123-456-7890');

SET @customer_id = LAST_INSERT_ID();


INSERT INTO orders (customer_id, order_date, total_amount) VALUES (@customer_id, CURDATE(), 100.00);

SELECT LAST_INSERT_ID() INTO @order_id;

INSERT INTO order_items (order_id, product_id, quantity) VALUES (@order_id, 1, 2);

COMMIT;
