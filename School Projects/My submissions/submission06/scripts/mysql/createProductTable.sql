#createProductTable.sql
#Table structure for table my_Product

DROP TABLE IF EXISTS my_Product;
CREATE TABLE my_Product
(
  product_id INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(40) NOT NULL,
  catCode VARCHAR(3) NOT NULL,
  price DOUBLE(6,2) NOT NULL,
  quantity INT(2) NOT NULL,
  image_file VARCHAR(30) NOT NULL
);

