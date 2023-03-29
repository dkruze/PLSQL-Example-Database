CREATE OR REPLACE FUNCTION cf_largepurchase
    (x IN cf_cartitem.itemid%TYPE)
    RETURN NUMBER
IS
    output NUMBER(5,2);
BEGIN
    SELECT COUNT(itemid)
    INTO output
    FROM cf_cartitem
    WHERE itemid = x AND price > 100.00;
    RETURN output;
END;
/
CREATE OR REPLACE FUNCTION cf_optionsummary
    (x IN cf_options.productid%TYPE,
     y IN cf_options.color%TYPE)
    RETURN NUMBER
IS
    output NUMBER(5,2);
    outputDefault NUMBER(3,2) := 0.00;
BEGIN
    SELECT COUNT(optionid)
    INTO output
    FROM cf_options
    WHERE productid = x AND color = y;
    RETURN output;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN outputDefault;
END;
/

--Queries for testing the functions
SELECT DISTINCT shopperid, cf_largepurchase(shopperid) AS "Major purchases per given customer"
FROM cf_shoppers
WHERE shopperid = 4;
/
SELECT DISTINCT cf_optionsummary(1, 'White') AS "Options of given color"
FROM cf_options;
