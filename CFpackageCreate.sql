CREATE OR REPLACE PACKAGE cf_bigpurchases_pkg IS
 FUNCTION cf_pkglargepurchase 
  (x IN cf_cartitem.cartid%TYPE)
   RETURN NUMBER;
 PROCEDURE cf_pkgdatecheck
  (proc_id IN cf_cart.cartid%TYPE,
   proc_date IN cf_cart.createdate%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY cf_bigpurchases_pkg IS
 FUNCTION cf_pkglargepurchase 
  (x IN cf_cartitem.cartid%TYPE)
   RETURN NUMBER
  IS
    output NUMBER(5,2);
BEGIN
    SELECT COUNT(itemid)
    INTO output
    FROM cf_cartitem
    WHERE cartid = x AND price > 100.00;
    RETURN output;
 END cf_pkglargepurchase;
PROCEDURE cf_pkgdatecheck
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
            DBMS_OUTPUT.PUT_LINE('Cart ' || proc_id || ' was created '|| TRUNC(MONTHS_BETWEEN(proc_date, temp_date), 1) || ' months before ' || proc_date);
        ELSIF temp_date = proc_date THEN
            DBMS_OUTPUT.PUT_LINE('Cart created on ' || proc_date);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Cart ' || proc_id || ' was created '|| TRUNC(MONTHS_BETWEEN(temp_date, proc_date), 1) || ' months after ' || proc_date);
        END IF;
 END cf_pkgdatecheck;
END;
/

DECLARE
    output NUMBER;
    input NUMBER := 1;
BEGIN
    output := cf_bigpurchases_pkg.cf_pkglargepurchase(input);
    DBMS_OUTPUT.PUT_LINE('Cart ' || input || ' made ' || output || ' large purchases');
    cf_bigpurchases_pkg.cf_pkgdatecheck(1, SYSDATE);
END;
