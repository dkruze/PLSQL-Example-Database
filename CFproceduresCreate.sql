CREATE OR REPLACE NONEDITIONABLE PROCEDURE cf_datecheck
    (proc_id IN cf_cart.cartid%TYPE,
     proc_date IN cf_cart.createdate%TYPE)
IS
    temp_date DATE;
BEGIN
    SELECT createdate
    INTO temp_date
    FROM cf_cart
    WHERE cartid = proc_id;
        IF temp_date < proc_date THEN
            DBMS_OUTPUT.PUT_LINE('Cart ' || proc_id || ' created '|| TRUNC(MONTHS_BETWEEN(proc_date, temp_date), 1) || ' months before ' || proc_date);
        ELSIF temp_date = proc_date THEN
            DBMS_OUTPUT.PUT_LINE('Cart created on ' || proc_date);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Cart ' || proc_id || ' created '|| TRUNC(MONTHS_BETWEEN(temp_date, proc_date), 1) || ' months after ' || proc_date);
        END IF;
END;
/

CREATE OR REPLACE NONEDITIONABLE PROCEDURE cf_catalogquery
    (proc_price IN NUMBER)
IS
    CURSOR cf_catalog_cur IS
        SELECT productname, price
        FROM cf_catalog;
BEGIN
    FOR product_cur IN cf_catalog_cur LOOP
        IF product_cur.price > proc_price THEN
            DBMS_OUTPUT.PUT_LINE(product_cur.productname || ', priced at ' || product_cur.price);
        ELSE
            CONTINUE;
        END IF;
    END LOOP;
END;
/

BEGIN
    cf_datecheck(1, SYSDATE);
    cf_catalogquery(100.00);
END;
/