DROP TABLE cf_available CASCADE CONSTRAINTS;

CREATE TABLE cf_available AS
SELECT company, productName, price, pitch
FROM cf_catalog
WHERE releaseDate < SYSDATE AND price > 0.0;

ALTER TABLE cf_available ADD
CONSTRAINT cf_company PRIMARY KEY(company);

COMMIT;