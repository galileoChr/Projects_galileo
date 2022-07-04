# loadCategories.sql
LOAD DATA LOCAL INFILE 'Categories.csv' INTO TABLE as_Category FIELDS TERMINATED BY ',';
