CREATE OR REPLACE TYPE product_prototype AS OBJECT 
(productname VARCHAR2(50), 
 company VARCHAR2(50),
 cost NUMBER(5,2),
 price NUMBER(5,2), 
 customization NUMBER(1),
 testdate DATE,
 releasedate DATE
); 
/

DECLARE
    fishFiletoMatic product_prototype;
BEGIN
    fishFiletoMatic := product_prototype('Fish-Filet-o-Matic', 'Fishsauce LLC.', 100.00, 175.00, 1, SYSDATE, '15-APR-2024');
END;
/