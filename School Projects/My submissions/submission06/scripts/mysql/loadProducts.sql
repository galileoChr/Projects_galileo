# loadProducts.sql

DELETE FROM my_Product;
LOAD DATA LOCAL INFILE 'Products.csv' INTO TABLE my_Product FIELDS TERMINATED BY ',';
