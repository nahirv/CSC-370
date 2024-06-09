CREATE DATABASE `CompanyInventory`;
USE `CompanyInventory`;
DROP TABLE Accounts;
CREATE TABLE `Accounts`(
	`item_id` VARCHAR(512),
    `total_revenue` INT,
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
);

SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\accounts_data.csv'
INTO TABLE Accounts
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DESCRIBE Accounts;
SELECT * FROM Accounts;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\admin_data.csv'
INTO TABLE Admin
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM Admin;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\customer_information_data.csv'
INTO TABLE CustomerInformation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM CustomerInformation;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\item_data.csv'
INTO TABLE Item
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM Item;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\sale_information_data.csv'
INTO TABLE SaleInformation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\supplier_data.csv'
INTO TABLE Supplier
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\supplier_order_data.csv'
INTO TABLE SupplierOrder
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\warehouse_data.csv'
INTO TABLE Warehouse
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;