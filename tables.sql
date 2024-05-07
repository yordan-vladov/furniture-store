DROP DATABASE IF EXISTS furniture_store;
CREATE DATABASE furniture_store;
USE furniture_store;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE product_categories (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE warranty (
    product_id INT PRIMARY KEY,
    warranty_start_date DATE,
    warranty_end_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE orders_stats(
order_sum DECIMAL(10,2),
order_count INT,
avg_order DECIMAL(10,2)
);

-- Inserting data into customers table
INSERT INTO customers (name, email, phone) VALUES
('John Doe', 'john@example.com', '123-456-7890'),
('Jane Smith', 'jane@example.com', '987-654-3210'),
('Michael Johnson', 'michael@example.com', '555-555-5555');

-- Inserting data into products table
INSERT INTO products (name, description, price) VALUES
('Sofa', 'Comfortable sofa with reclining seats', 999.00),
('Dining Table', 'Solid wood dining table', 499.00),
('Bed', 'Queen-sized bed with storage drawers', 799.00);

-- Inserting data into orders table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-05-06', 999.00),
(2, '2024-05-06', 1498.00),
(3, '2024-05-07', 799.00);

-- Inserting data into order_items table
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 1, 2),
(2, 2, 1),
(3, 3, 1);

-- Inserting data into categories table
INSERT INTO categories (name) VALUES
('Living'),
('Dining'),
('Bedroom');

-- Inserting data into product_categories table
INSERT INTO product_categories (product_id, category_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserting data into warranty table
INSERT INTO warranty (product_id, warranty_start_date, warranty_end_date) VALUES
(1, '2024-05-06', '2025-05-06'),
(2, '2024-05-06', '2025-05-06'),
(3, '2024-05-07', '2025-05-07');

INSERT INTO orders_stats SELECT
  SUM(total_amount) AS order_sum,
  COUNT(total_amount) AS order_count,
  AVG(total_amount) AS avg_order
FROM
  orders;
