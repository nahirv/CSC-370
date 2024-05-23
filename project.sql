CREATE DATABASE `CompanyInventory`;
CREATE TABLE `Item`(
    `item_id` INT,
    `item_name` VARCHAR(512),
    `category` VARCHAR(128),
    `quantity_sold` INT
);
CREATE TABLE `Accounts`(
    `total_revenue` INT,
    `item_name` VARCHAR(512),
    `quantity_sold` INT
); 
CREATE TABLE `SupplierOrder`(
    `order_id` INT,
    `quantity` INT,
    `item_name` VARCHAR(512)
    `unit_price` INT
    `total_price` INT
);
CREATE TABLE `Admin`(
    `admin_role` VARCHAR(64),
    `admin_id` INT
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
    `item_name` VARCHAR(512),
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
    `item_name` VARCHAR(512), 
    `name` VARCHAR(512),
    `money_owed` VARCHAR(512),
    `order_history` VARCHAR(512)
);