SELECT *
FROM cf_cart;

SELECT UPPER(productName) AS "Product Name", LENGTH(description) AS "Complexity Score", CEIL(price) AS "Actual Price"
FROM cf_products
WHERE productID <> 5;

SELECT REPLACE(description, 'Blendcorp', 'BlendSmart')
FROM cf_products
WHERE productID = 1;

SELECT MIN(price) AS "Cheapest Purchase", MAX(price) AS "Fanciest Purchase", AVG(price) AS "Average Spending", SUM(price) AS "Total Revenue"
FROM cf_cartitem;

SELECT cartID AS "Cart ID", TRUNC(MONTHS_BETWEEN(SYSDATE, createDate), 1) AS "Months Since Creation", EXTRACT(MONTH FROM createDate) AS "MONTH of Creation", EXTRACT(DAY FROM createDate) AS "Day of Creation"
FROM cf_cart;

SELECT COUNT(ci.itemID) AS "Items Ordered", c.shopperID AS "Shopper ID", s.name AS "Shopper"
FROM ((cf_cartitem ci 
INNER JOIN cf_cart c ON ci.cartID = c.cartID)
INNER JOIN cf_shoppers s ON c.shopperID = s.shopperID)
GROUP BY s.name, c.shopperID, ci.cartID
ORDER BY COUNT(ci.itemID);

SELECT COUNT(c.cartID) AS "Open Carts", c.shopperID AS "Shopper ID", s.name AS "Shopper"
FROM cf_cart c
INNER JOIN cf_shoppers s ON c.shopperID = s.shopperID
GROUP BY s.name, c.shopperID
HAVING COUNT(c.cartID) > 1;

SELECT COUNT(o.optionID) AS "Available Options", o.productID AS "Product ID", p.productName AS "Product Name"
FROM cf_options o INNER JOIN cf_products p ON o.productID = p.productID
HAVING COUNT(optionID) > (SELECT COUNT(optionID) FROM cf_options WHERE productID = 5)
GROUP BY o.productID, p.productName
ORDER BY COUNT(optionID);
