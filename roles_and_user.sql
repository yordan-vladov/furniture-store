CREATE ROLE store_admin;
GRANT ALL PRIVILEGES ON furniture_store.* TO store_admin;

CREATE ROLE customer_support;
GRANT SELECT ON TABLE orders TO customer_support;

CREATE ROLE customer;
GRANT SELECT (name, description, price) ON products TO customer;

CREATE USER admin_user IDENTIFIED BY 'password';
GRANT store_admin TO admin_user;

CREATE USER cs_user IDENTIFIED BY 'password';
GRANT customer_support TO cs_user;

CREATE USER customer_user IDENTIFIED BY 'password';
GRANT customer TO customer_user;