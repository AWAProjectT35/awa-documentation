
CREATE OR REPLACE PROCEDURE create_order (
    order_Id INT, 
    restaurant_Id INT, 
    username VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders(order_id,restaurant_id, user_name, order_status, order_date, total, delivery_address)
    VALUES (
        order_Id,
        restaurant_Id,
        username,
        0,
        current_date,
        0.0,
        (SELECT address FROM users WHERE user_name = username)
    );
    COMMIT;
END; $$;


CREATE OR REPLACE PROCEDURE insert_order_product (
    orderId INT, 
    productId INT, 
    amount INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders_products VALUES (
        orderId,
        productId,
        amount,
        (SELECT price FROM products p
        WHERE p.product_id = productId)
    );
    COMMIT;
END; $$;


CREATE OR REPLACE PROCEDURE update_order_price (
    orderId INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders 
    SET total = (
        SELECT sum(amount * product_price) 
        FROM orders_products p
        WHERE p.order_id = orderId
    )
    WHERE order_id = orderId;
    COMMIT;
END; $$;