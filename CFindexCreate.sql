---These indices only refer to the data in each corresponding table that is most likeley to be searched
--Note that while this makes some queries faster, it does make others longer depending on whether the data in the index has been updated or not
DROP INDEX shopper_info;
DROP INDEX product_info;
DROP INDEX cartitem_info;
DROP INDEX order_info;

CREATE INDEX shopper_info
ON cf_shoppers (name, shopperid);

CREATE INDEX product_info
ON cf_products (productname, productid);

CREATE INDEX cartitem_info
ON cf_cartitem (itemid, productid, cartid, optionid);

CREATE INDEX order_info
ON cf_orders (orderid, cartid, shopperID, name, confirmstatus);

COMMIT;
