#createOrderItemTable.sql
#Table structure for table my_OrderItem

DROP TABLE IF EXISTS my_OrderItem;
CREATE TABLE my_OrderItem
(
  order_item_id INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  order_item_name VARCHAR(40) NOT NULL,
  order_item_status VARCHAR(2) NOT NULL,
  order_id INT(4) NOT NULL,
  product_id INT(4) NOT NULL,
  quantity INT(4) NOT NULL,
  price DOUBLE(6,2) NOT NULL
);
