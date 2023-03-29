--Requirements 14 and 15 are contained in the following anonymous block
--Note that when running this script, "Evil Item 1" and "Evil Item 2" will not appear in the specified tables, because they are immediately deleted
--Also note that when run, shopper 6 will be Rueben Lidster and shopper 5 will be Richard Tower
DECLARE
    temp_name VARCHAR2(50);
BEGIN
INSERT INTO cf_catalog
   VALUES('Evil Item 1', 'Evilcorp Inc', 999.99, '13-JAN-00', 'Evil items must be deleted! Contact a CF Administrator Immediately!');
INSERT INTO cf_catalog
   VALUES('Evil Item 2', 'Evilcorp Inc', 999.99, '13-JAN-00', 'Evil items must be deleted! Contact a CF Administrator Immediately!');
INSERT INTO cf_products
  VALUES(98, 'Evil Item 1', 'Evilcorp Inc', 999.99, 0, 'This product is EVIL and should be deleted at once!');
INSERT INTO cf_products
  VALUES(99, 'Evil Item 2', 'Evilcorp Inc', 999.99, 0, 'This product is EVIL and should be deleted at once!');

DELETE FROM cf_products  
WHERE productID = 98 OR productID = 99 OR company = 'Evilcorp Inc';

DELETE FROM cf_catalog
WHERE releaseDate = '13-JAN-00' OR company = 'Evilcorp Inc';

SELECT name 
INTO temp_name 
FROM cf_shoppers 
WHERE shopperID = 6;

UPDATE cf_shoppers
    SET name = (SELECT name FROM cf_shoppers WHERE shopperID = 5)
    WHERE shopperID = 6;
UPDATE cf_shoppers
    SET name = temp_name
    WHERE shopperID = 5;
END;
