CREATE INDEX idx_customers_email ON customers (email);

CREATE INDEX idx_orders_date_amount ON orders (order_date, total_amount);

CREATE INDEX idx_products_name_prefix ON products (name(20));
