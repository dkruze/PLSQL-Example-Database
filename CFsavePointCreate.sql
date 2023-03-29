--Note that upon running this script, no data will show up in CF_ORDERS, because it is rolled back
--Proof of this script's execution will be in the script output
SAVEPOINT kazuya_order_save;

DECLARE
    kazuya_order cf_orders%ROWTYPE;
BEGIN
INSERT INTO cf_orders (orderID)
    VALUES(99);

UPDATE cf_orders
    SET cartID = 5,
	shopperID = 4,
	createDate = '30-OCT-22',
    quantity = 4,
	taxStatus = 0,
	name = 'Kazuya Mishima',
	phone = 3177118898,
	email = 'ewgfdaddy@gmail.com',
	promo = 'FIRESALE',
	subtotal = 1120.00,
	confirmStatus = 0,
	orderDate = SYSDATE
    WHERE orderID = 99;

SELECT *
INTO kazuya_order
FROM cf_orders
WHERE confirmStatus = 1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK TO SAVEPOINT kazuya_order_save;
        DBMS_OUTPUT.PUT_LINE('Rollback performed, order not ready!');
END;
