--Requirements 3, 16, and 17 are contained in the following CREATE TABLE statements.
--The list of DROP TABLE commands immediately following this comment serves as a list of all tables included in the database
--Note that CF_AVAILABLE is not included in the ERD, because it is created on the fly from an existing table, CF_PRODUCTS
DROP TABLE cf_catalog CASCADE CONSTRAINTS;
DROP TABLE cf_products CASCADE CONSTRAINTS;
DROP TABLE cf_shoppers CASCADE CONSTRAINTS;
DROP TABLE cf_cart CASCADE CONSTRAINTS;
DROP TABLE cf_cartitem CASCADE CONSTRAINTS;
DROP TABLE cf_options CASCADE CONSTRAINTS;
DROP TABLE cf_taxinfo CASCADE CONSTRAINTS;
DROP TABLE cf_orders CASCADE CONSTRAINTS;
DROP TABLE cf_available CASCADE CONSTRAINTS;

CREATE TABLE cf_catalog (
	productName VARCHAR2(50),
    company VARCHAR2(50),
	price NUMBER(6,2),
	releaseDate DATE,
	pitch VARCHAR2(100),
	CONSTRAINT cf_productName PRIMARY KEY(productName));
INSERT INTO cf_catalog
   VALUES('Blendtron 3X6', 'Blendcorp® Inc.', 499.99, '15-OCT-18', 'Never worry about a blender not being strong enough again! 3 Tiers of slashing power!');
INSERT INTO cf_catalog
   VALUES('Steak au Poivre: Ready-to-Eat', 'Cultured-Man®', 14.49, '09-JUN-15', 'In a hurry, but don''t want to eat like it? Try Cultured-man®''s 15-minute Steak au Poivre!');
INSERT INTO cf_catalog
   VALUES('Homestyle Sausage Roller', 'Tesco®', 59.99, '30-APR-21', 'Bring the 7/11 magic right to your home! Roll hot dogs, sausages, and more on your countertop!');
INSERT INTO cf_catalog
   VALUES('4-Piece Kitchen Knife Set', 'Guai-Lo®', 219.99, '21-SEP-23', '[Coming Soon!] A price that won''t bust the bank, but knives that''ll bust anything!');
INSERT INTO cf_catalog
   VALUES('Entire North Sea Halibut', '[Unavailable]', 0.00, '1-JAN-00', '[This product is no longer available. We apologize for the inconvenience.]');
   
CREATE TABLE cf_products (
	productID NUMBER(2),
	productName VARCHAR2(50),
    company VARCHAR2(50),
	price NUMBER(6,2),
	optionStatus NUMBER(1) NOT NULL,
	description VARCHAR2(500),
	CONSTRAINT cf_productID PRIMARY KEY(productID),
    CONSTRAINT cf_catalog_productName_p FOREIGN KEY (productName)
        REFERENCES cf_catalog (productName));
INSERT INTO cf_products
  VALUES(1, 'Blendtron 3X6', 'Blendcorp® Inc.', 499.99, 1, 'This 3-tiered blender NEW from industry-standard brand Blendcorp® allows quick and easy blending for ANY blending need! 
  Rated up to 2000ft/lbs of force by the ATF and FAA, the paperwork is worth it when you figure out that YOU can blend ANYTHING from daiquiris to puree to gravel in seconds! 
  Even cleaning it is easy, owing to the segmenting, 3-tiered design allowing YOU to desconstruct and service the blender at will.');
INSERT INTO cf_products
  VALUES(2, 'Steak au Poivre: Ready-to-Eat', 'Cultured-Man®', 14.49, 0, 'We''ve all been there: you want to have world-class food, but you''ve got a working-class schedule. 
  Thankfully, Cultured-Man''s® got the solution! The new Steak au Poivre Ready-to-Eat is NOW officially on the menu! 
  The favored steak dinner-for-two among the French masters is now only a button press away, with this microwave-safe meal being ready in ONLY 15 minutes! 
  Don''t resign yourself to frozen pizza or burritos anymore; travel all the way to Paris from the comfort of your couch!');
INSERT INTO cf_products
  VALUES(3, 'Homestyle Sausage Roller', 'Tesco®', 59.99, 0, 'Have you ever wanted to bring that 7/11-feeling straight into YOUR kitchen? Want no longer: buy! 
  Tesco® is finally rolling out a home version of the rollers they use for hot dogs and sausage rolls, and at a low price to boot! 
  You can put practically anything on here and treat it JUST like a rotisserie...but BETTER, because it''s just like they''ve got at Tesco''s®! 
  Supports up to 10 simultaneous sausages at once, heats up to 450F.');
INSERT INTO cf_products
  VALUES(4, '4-Piece Kitchen Knife Set', 'Guai-Lo®', 219.99, 1, 'Here''s a set of real, Chinese knives built for EVERYBODY...REALLY! 
  Whether you''re a beginner or a resturanteur, these knives are versatile, lightweight, and effective enough to stay sharp for MONTHS! 
  Folded over 1000 times for maximum sharpness, these knives stay just as well maintained as you do, and reward ALL skill levels for their practice and consistency with mind-boggling cutting power!');
INSERT INTO cf_products
  VALUES(5, 'Entire North Sea Halibut', '[Unavailable]', 169.99, 1, 'This product is no longer available in your country.
  We apologize for the inconvenience, and recommend any number of our other products.
  We are working hard to get this back in stock.');

CREATE TABLE cf_taxinfo (
	state VARCHAR2(2),
	taxStatus NUMBER(1),
	CONSTRAINT cf_state PRIMARY KEY (state));
INSERT INTO cf_taxinfo 
  VALUES('VA', 1);
INSERT INTO cf_taxinfo
  VALUES('NC', 1);
INSERT INTO cf_taxinfo
  VALUES('SC', 1);
INSERT INTO cf_taxinfo
  VALUES('IN', 0);
INSERT INTO cf_taxinfo
  VALUES('NY', 0);
INSERT INTO cf_taxinfo
  VALUES('CA', 0);
  
CREATE TABLE cf_shoppers (
    shopperID NUMBER(2),
    name VARCHAR2(50),
    email VARCHAR2(50),
    phone NUMBER(10),
    state VARCHAR2(2),
    CONSTRAINT cf_shopperID PRIMARY KEY (shopperID),
    CONSTRAINT cf_taxinfo_state_s FOREIGN KEY (state)
        REFERENCES cf_taxinfo (state));
INSERT INTO cf_shoppers
  VALUES(1, 'Heihachi Mishima', 'heihachikun@gmail.com', 3178370798, 'IN');
INSERT INTO cf_shoppers
  VALUES(2, 'Kirk Hammer', 'vileblood@sbcglobal.net', 6460867298, 'NY');
INSERT INTO cf_shoppers
  VALUES(3, 'Max Cope', 'maxcopium@gmail.com', 7039234895, 'VA');
INSERT INTO cf_shoppers
  VALUES(4, 'Kazuya Mishima', 'ewgfdaddy@gmail.com', 3177118898, 'IN');
INSERT INTO cf_shoppers
  VALUES(5, 'Rueben Lidster', 'sauerrkraut@yahoo.com', 2092084401, 'CA');
INSERT INTO cf_shoppers
  VALUES(6, 'Richard Tower', 'dicketower@hotmail.com', 9102915853, 'NC');
                     
CREATE TABLE cf_cart (
	cartID NUMBER(2),
	shopperID NUMBER(2),
	createDate DATE,
	quantity NUMBER(3),
	CONSTRAINT cf_cartID PRIMARY KEY(cartID),
    CONSTRAINT cf_shoppers_shopperID_c FOREIGN KEY (shopperID)
        REFERENCES cf_shoppers (shopperID));
INSERT INTO cf_cart
    VALUES (1, 1, '20-OCT-22', 2);
INSERT INTO cf_cart
    VALUES (2, 1, '29-OCT-22', 2);
INSERT INTO cf_cart
    VALUES (3, 2, '28-OCT-22', 1);
INSERT INTO cf_cart
    VALUES (4, 3, '17-OCT-22', 3);
INSERT INTO cf_cart
    VALUES (5, 4, '30-OCT-22', 4);
INSERT INTO cf_cart
    VALUES (6, 4, '03-NOV-22', 1);
INSERT INTO cf_cart
    VALUES (7, 5, '30-SEP-22', 2);
INSERT INTO cf_cart
    VALUES (8, 6, '05-OCT-01', 3);
            
CREATE TABLE cf_cartitem (
	itemID NUMBER(2),
	productID NUMBER(2),
	cartID NUMBER(2),
    price NUMBER(6,2),
    optionStatus NUMBER(1) NOT NULL,
    optionID NUMBER(2),
	CONSTRAINT cf_itemID PRIMARY KEY (itemID),
    CONSTRAINT cf_products_productID_ci FOREIGN KEY(productID)
        REFERENCES cf_products(productID), 
    CONSTRAINT cf_cart_cartID_ci FOREIGN KEY(cartID)
        REFERENCES cf_cart(cartID));
INSERT INTO cf_cartitem
  VALUES(1, 1, 1, 499.99, 1, 3);
INSERT INTO cf_cartitem
  VALUES(2, 1, 1, 499.99, 1, 4);
INSERT INTO cf_cartitem
  VALUES(3, 4, 2, 219.99, 1, 9);
INSERT INTO cf_cartitem
  VALUES(4, 4, 2, 219.99, 1, 10);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(5, 2, 3, 14.49, 0);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(6, 2, 4, 14.49, 0);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(7, 2, 4, 14.49, 0);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(8, 2, 4, 14.49, 0);
INSERT INTO cf_cartitem
  VALUES(9, 1, 5, 499.99, 1, 2);
INSERT INTO cf_cartitem
  VALUES(10, 1, 5, 499.99, 1, 6);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(11, 3, 5, 59.99, 0);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(12, 3, 5, 59.99, 0);
INSERT INTO cf_cartitem
  VALUES(13, 5, 6, 169.99, 1, 12);
INSERT INTO cf_cartitem
  VALUES(14, 1, 7, 499.99, 1, 5);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(15, 3, 7, 59.99, 0);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(16, 2, 8, 14.49, 0);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(17, 2, 8, 14.49, 0);
INSERT INTO cf_cartitem (itemID, productID, cartID, price, optionStatus)
  VALUES(18, 2, 8, 14.49, 0);

CREATE TABLE cf_options (
	optionID NUMBER(2),
	productID NUMBER(2),
    color VARCHAR2(10),
    attachments VARCHAR2(250),
	CONSTRAINT cf_optionID PRIMARY KEY(optionID),
    CONSTRAINT cf_products_productID_op FOREIGN KEY (productID)
        REFERENCES cf_products (productID));
INSERT INTO cf_options
  VALUES(1, 1, 'White', 'No attachments!');
INSERT INTO cf_options
  VALUES(2, 1, 'White', 'Detachable 4th Tier, FAA Certificate of Air Serviceability');
INSERT INTO cf_options
  VALUES(3, 1, 'Black', 'No attachments!');
INSERT INTO cf_options
  VALUES(4, 1, 'Black', 'Detachable 4th Tier, FAA Certificate of Air Serviceability');
INSERT INTO cf_options
  VALUES(5, 1, 'Red', 'No attachments!');
INSERT INTO cf_options
  VALUES(6, 1, 'Red', 'Detachable 4th Tier, FAA Certificate of Air Serviceability');
INSERT INTO cf_options
  VALUES(7, 4, 'Mahogany', '20-Year Sharpness Warranty');
INSERT INTO cf_options
  VALUES(8, 4, 'Cherry', '20-Year Sharpness Warranty');
INSERT INTO cf_options
  VALUES(9, 4, 'Enamel', 'No attachments!');
INSERT INTO cf_options
  VALUES(10, 4, 'Steel', 'No attachments!');
INSERT INTO cf_options
  VALUES(11, 5, 'N/A', 'Shipped dead');
INSERT INTO cf_options
  VALUES(12, 5, 'N/A', 'Shipped alive');
  
CREATE TABLE cf_available AS
SELECT company, productName, price, pitch
FROM cf_catalog
WHERE releaseDate < SYSDATE AND price > 0.0;

ALTER TABLE cf_available ADD
CONSTRAINT cf_company PRIMARY KEY(company);

CREATE TABLE cf_orders (
	orderID NUMBER(2),
	cartID NUMBER(2),
	shopperID NUMBER(2),
	createDate DATE,
    quantity NUMBER(3),
	taxStatus NUMBER(1) DEFAULT 0,
	name VARCHAR2(50),
	phone NUMBER(10),
	email VARCHAR2(50),
	promo VARCHAR2(10),
	subtotal NUMBER(7,2),
	confirmStatus NUMBER(1),
	orderDate date DEFAULT SYSDATE,
    CONSTRAINT cf_orderID PRIMARY KEY(orderID),
    CONSTRAINT cf_cart_cartID_or FOREIGN KEY (cartID)
        REFERENCES cf_cart(cartID),
    CONSTRAINT cf_shoppers_shopperID_or FOREIGN KEY (shopperID)
        REFERENCES cf_shoppers(shopperID));

COMMIT;
