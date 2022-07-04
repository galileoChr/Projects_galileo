#createCategoryTable.sql
#Table structure for table my_Category

DROP TABLE IF EXISTS my_Category;
CREATE TABLE my_Category
(
  catCode VARCHAR(3) NOT NULL,
  catName VARCHAR(12) NOT NULL,
      PRIMARY KEY (catCode)
);
