CREATE DATABASE `CompanyInventory`;
USE `CompanyInventory`;

-- Creating the Tables
CREATE TABLE `Accounts`(
	`item_id` INT PRIMARY KEY,
    `total_revenue` INT,
    `quantity_sold` INT
); 
CREATE TABLE `SupplierOrder`(
    `order_id` INT PRIMARY KEY, 
    `quantity` INT,
    `item_id` INT, 
    `unit_price` INT,
    `total_price` INT
);
CREATE TABLE `Admin`(
    `admin_id` INT PRIMARY KEY,
    `admin_role` VARCHAR(64)
);
CREATE TABLE `SaleInformation`(
    `sale_id` INT PRIMARY KEY,
    `status` VARCHAR(64),
    `order_items` VARCHAR(2048),
    `date_sold` DATE,
    `total_amount` INT,
    `shipping_information` VARCHAR(1024)
);
CREATE TABLE `Warehouse`(
    `address` VARCHAR(128) PRIMARY KEY,
    `item_id` INT, 
    `item_total_quantity` INT,
    `order_history` VARCHAR(2048)
);
CREATE TABLE `CustomerInformation`(
    `customer_id` INT PRIMARY KEY, 
    `customer_name` VARCHAR(512),
    `email` VARCHAR(512),
    `address` VARCHAR(128),
    `phone_number` INT
);
CREATE TABLE `Supplier`(
    `supplier_id` INT PRIMARY KEY, 
    `name` VARCHAR(512),
    `money_owed` VARCHAR(512),
    `order_history` VARCHAR(512),
    `address` VARCHAR(128)
);
CREATE TABLE `Item`(
    `item_id` INT PRIMARY KEY, 
    `category` VARCHAR(128),
    `item_name` VARCHAR(512),
    `quantity_sold` INT
);

-- Adding Foreign Keys for Accounts, Supplier and Warehouse
ALTER TABLE `Accounts`
ADD CONSTRAINT `fk_accounts_item_id`
FOREIGN KEY (`item_id`) REFERENCES `Item`(`item_id`);
ALTER TABLE `SupplierOrder`
ADD CONSTRAINT `fk_supplier+order_item_id`
FOREIGN KEY (`item_id`) REFERENCES `Item`(`item_id`);
ALTER TABLE `Warehouse`
ADD CONSTRAINT `fk_warehouse_item_id`
FOREIGN KEY (`item_id`) REFERENCES `Item`(`item_id`);

-- Data Propogation
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

-- Aggregation Queries

-- Total Revenue and Quantity Sold per Item
SELECT 
    i.item_id,
    i.item_name,
    SUM(a.total_revenue) AS total_revenue,
    SUM(a.quantity_sold) AS total_quantity_sold
FROM 
    Accounts a
JOIN 
    Item i ON a.item_id = i.item_id
GROUP BY 
    i.item_id, i.item_name;

-- Total Orders and Revenue per Supplier
SELECT 
    s.supplier_id,
    s.name,
    COUNT(so.order_id) AS total_orders,
    SUM(so.total_price) AS total_revenue
FROM 
    SupplierOrder so
JOIN 
    Supplier s ON so.supplier_id = s.supplier_id
GROUP BY 
    s.supplier_id, s.name;

-- Total Sales and Average Sales Amount per Month
SELECT 
    YEAR(si.date_sold) AS year,
    MONTH(si.date_sold) AS month,
    COUNT(si.sale_id) AS total_sales,
    SUM(si.total_amount) AS total_revenue,
    AVG(si.total_amount) AS average_sale_amount
FROM 
    SaleInformation si
GROUP BY 
    YEAR(si.date_sold), MONTH(si.date_sold);

-- Total Quantity of Each Item in the Warehouse
SELECT 
    w.item_id,
    i.item_name,
    SUM(w.item_total_quantity) AS total_quantity
FROM 
    Warehouse w
JOIN 
    Item i ON w.item_id = i.item_id
GROUP BY 
    w.item_id, i.item_name;

-- Number of Customers and Total Purchases per Address
SELECT 
    c.address,
    COUNT(c.customer_id) AS number_of_customers,
    SUM(si.total_amount) AS total_purchases
FROM 
    CustomerInformation c
JOIN 
    SaleInformation si ON c.customer_id = si.customer_id
GROUP BY 
    c.address;
