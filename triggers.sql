DELIMITER $$

CREATE TRIGGER before_products_insert
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END$$

CREATE TRIGGER
  update_orders_info_after_insert AFTER
INSERT
  ON orders FOR EACH ROW BEGIN

    DECLARE row_count INT;

    DECLARE new_count INT;

    DECLARE new_sum DECIMAL(10, 2);

    DECLARE new_avg DECIMAL(10, 2);

    SELECT 
        COUNT(*)
    INTO row_count FROM
        orders_stats;

    IF row_count > 0 THEN
        SELECT
        order_sum + new.total_amount INTO new_sum
        FROM
        orders_stats;

        SELECT 
            order_count + 1
        INTO new_count FROM
            orders_stats;
        SET
        new_avg = new_sum / new_count;

        UPDATE orders_stats 
        SET 
            order_count = new_count,
            order_sum = new_sum,
            avg_order = new_avg;

    ELSE	
        INSERT INTO
        orders_stats
        VALUES
        (new.total_amount, 1, new.total_amount);

    END IF;

END$$

CREATE TRIGGER before_products_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END$$


CREATE TRIGGER
  update_orders_info_after_update AFTER
UPDATE
  ON orders FOR EACH ROW BEGIN

    DECLARE order_count INT;

    DECLARE new_sum DECIMAL(10, 2);

    DECLARE new_avg DECIMAL(10, 2);

    SELECT
        COUNT(*)
    INTO order_count FROM
        orders;

    
    SELECT
    order_sum - old.total_amount + new.total_amount INTO new_sum
    FROM
    orders_stats;
    SET
    new_avg = new_sum / order_count;
    UPDATE orders_stats
    SET 
        order_sum = new_sum,
        avg_order = new_avg;

END$$


DELIMITER ;
