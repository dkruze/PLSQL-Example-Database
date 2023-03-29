--Note that a sequence exists for each table that has an ID for every row
DROP SEQUENCE new_orderID;
DROP SEQUENCE new_shopperID;
DROP SEQUENCE new_cartID;
DROP SEQUENCE new_productID;
DROP SEQUENCE new_optionID;
DROP SEQUENCE new_itemID;

CREATE SEQUENCE new_orderID
start with 1
increment by 1
minvalue 1
maxvalue 99
cycle;

CREATE SEQUENCE new_shopperID
start with 7
increment by 1
minvalue 7
maxvalue 99
cycle;

CREATE SEQUENCE new_cartID
start with 9
increment by 1
minvalue 8
maxvalue 99
cycle;

CREATE SEQUENCE new_productID
start with 6
increment by 1
minvalue 6
maxvalue 99
cycle;

CREATE SEQUENCE new_optionID
start with 13
increment by 1
minvalue 13
maxvalue 99
cycle;

CREATE SEQUENCE new_itemID
start with 19
increment by 1
minvalue 19
maxvalue 99
cycle;

COMMIT;
