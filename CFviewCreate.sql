--Requirements 4 and 13 are contained in the following DELETE, CREATE VIEW, and UPDATE statements
--Note that every time this script is run, no new data will be added to CF_ORDERS because the existing data is deleted before being replaced
--Only the view PENDING_ORDERS is affected for requirement 13
DROP VIEW available_products;
DROP VIEW mishima_family;
DROP VIEW product_options;
DROP VIEW pending_orders;
DELETE FROM cf_orders WHERE name = 'Kazumi Mishima' AND confirmStatus = 0;

CREATE VIEW available_products AS
    SELECT productID AS "Product ID", productName AS Product, optionStatus AS "Has Options", description AS "Summary"
    FROM cf_products
    WHERE productID <> 5;

CREATE VIEW mishima_family AS
    SELECT shopperID AS ID, name AS "Customer Name", email AS "Email Address", phone AS "Phone Number"
    FROM cf_shoppers
    WHERE shopperID = 1 OR shopperID = 4;

CREATE VIEW product_options AS
    SELECT op.optionID AS ID, p.productName AS Product, op.color AS Color, op.attachments AS "Add-ons"
    FROM cf_options op INNER JOIN cf_products p
        USING(productID);
        
CREATE VIEW pending_orders AS
    SELECT orderID AS ID, name AS "Customer Name", createDate AS "Finalize Date", quantity AS "Items Ordered", subtotal AS "Subtotal"
    FROM cf_orders
    WHERE confirmStatus = 1;
INSERT INTO pending_orders
    VALUES(1, 'Kazumi Mishima', SYSDATE, 3, 45.00);
UPDATE cf_orders
    SET confirmStatus = 1
    WHERE orderID = 1;
    
COMMIT;