CREATE DATABASE `CompanyInventory`;
USE `CompanyInventory`;
CREATE TABLE `Accounts`(
    `total_revenue` INT,
    `item_id` VARCHAR(512),
    `quantity_sold` INT
); 
CREATE TABLE `SupplierOrder`(
    `order_id` INT,
    `quantity` INT,
    `item_id` VARCHAR(512),
    `unit_price` INT,
    `total_price` INT
);
CREATE TABLE `Admin`(
    `admin_id` INT,
    `admin_role` VARCHAR(64)
);
CREATE TABLE `SaleInformation`(
    `sale_id` INT,
    `status` VARCHAR(64),
    `order_items` VARCHAR(2048),
    `date_sold` DATE,
    `total_amound` INT,
    `shipping_information` VARCHAR(1024)
);
CREATE TABLE `Warehouse`(
    `address` VARCHAR(128),
    `item_id` VARCHAR(512),
    `item_total_quantity` INT,
    `order_history` VARCHAR(2048)
);
CREATE TABLE `CustomerInformation`(
    `customer_id` INT,
    `customer_name` VARCHAR(512),
    `email` VARCHAR(512),
    `address` VARCHAR(128),
    `phone_number` INT
);
CREATE TABLE `Supplier`(
    `supplier_id` INT, 
    `name` VARCHAR(512),
    `money_owed` VARCHAR(512),
    `order_history` VARCHAR(512),
    `address` VARCHAR(128)
);
CREATE TABLE `Item`(
    `item_id` INT,
    `category` VARCHAR(128),
    `item_name` VARCHAR(512),
    `quantity_sold` INT
)

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/accounts_data.csv'
INTO TABLE Accounts
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/admin_data.csv'
INTO TABLE Admin
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/customer_information.csv'
INTO TABLE CustomerInformation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/item_data.csv'
INTO TABLE Item
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/sale_information_data.csv'
INTO TABLE SaleInformation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/supplier_data.csv'
INTO TABLE Supplier
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/supplier_order_data.csv'
INTO TABLE SupplierOrder
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/user/uvic/csc370/CSC-370/database_sample/warehouse_data.csv'
INTO TABLE Warehouse
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
