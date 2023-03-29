--these fulfill requirements 1 through 5
CREATE OR REPLACE TRIGGER cf_insertproduct_trg
   AFTER INSERT ON cf_products
   FOR EACH ROW
DECLARE
    temp_id NUMBER(2);
    min_price EXCEPTION;
    CURSOR cf_newproduct_cur IS
        SELECT productid, price, description
        FROM cf_products
        WHERE productid > 5;
BEGIN
    FOR product_cur IN cf_newproduct_cur LOOP
        IF product_cur.description = NULL THEN
            UPDATE cf_products
            SET description = 'This is a placeholder description. If you see this, then someone wasn''t careful when entering a product into this database!'
            WHERE productid = product_cur.productid;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Description Validated!');
        END IF;
        IF product_cur.price = NULL THEN
            UPDATE cf_products
            SET price = 0.00
            WHERE productid = product_cur.productid;
        ELSIF product_cur.price < 15.00 THEN
            temp_id := product_cur.productid;
            RAISE min_price;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Price Validated!');
        END IF;
    END LOOP;
    EXCEPTION
        WHEN min_price THEN
            UPDATE cf_products
            SET price = 0.00
            WHERE productid = temp_id;
END;
/

CREATE OR REPLACE TRIGGER cf_updateshopper_trg
   AFTER UPDATE OF state ON cf_shoppers
   FOR EACH ROW
DECLARE
    CURSOR cf_newshopper_cur IS
        SELECT shopperid, state
        FROM cf_shoppers;
BEGIN
    FOR shopper_cur IN cf_newshopper_cur LOOP
       CASE
            WHEN shopper_cur.state = 'VA' OR shopper_cur.state = 'NC' OR shopper_cur.state = 'SC' THEN
                UPDATE cf_orders
                SET taxstatus = 1
                WHERE shopperid = shopper_cur.shopperid;
       END CASE;
    END LOOP;
    EXCEPTION
        WHEN CASE_NOT_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Tax Status Unchanged!');
END;
/