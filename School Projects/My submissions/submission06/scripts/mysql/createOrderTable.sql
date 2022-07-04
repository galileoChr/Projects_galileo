#createOrderTable.sql
#Table structure for table my_Order

DROP TABLE IF EXISTS my_Order;
CREATE TABLE my_Order
(
  order_id INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  customer_id INT(4) NOT NULL,
  order_status VARCHAR(2) NOT NULL,
  date_time DATETIME NOT NULL
);

