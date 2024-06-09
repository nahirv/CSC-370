-- Creates the Database with the name CompanyInventorydb
CREATE DATABASE CompanyInventorydb;

-- Use the database created
USE CompanyInventorydb;

-- Creating a table with the name Item
CREATE TABLE Item(
    item_id INT,
    category VARCHAR(512),
    quantity_sold INT,
    item_name VARCHAR(512)
);

-- Creating a table with the name Accounts
CREATE TABLE Accounts(
    total_revenue INT,
    account_id INT,
); 

-- Creating a table with the name SupplierOrder
CREATE TABLE SupplierOrder(
    order_id INT,
    quantity INT,
    unit_price INT,
    total_price INT
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

-- Creating a table with the name Supplier
CREATE TABLE Supplier(
    supplier_id INT,
    item_name VARCHAR(512), 
    name VARCHAR(512),
    money_owed VARCHAR(512),
    order_history VARCHAR(512)
);

