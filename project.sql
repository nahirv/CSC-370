CREATE DATABASE CompanyInventory;
USE CompanyInventory;
-- Creating the Tables
-- Item (Base Class)
CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    category VARCHAR(512) NOT NULL,
    item_name VARCHAR(512) NOT NULL,
    quantity_sold INT DEFAULT 0 CHECK (quantity_sold >= 0)
);

-- Accounts (Subclass)
CREATE TABLE Accounts(
    item_id INT PRIMARY KEY,
    sale_unit_price INT NOT NULL CHECK (sale_unit_price >= 0),
    quantity_sold INT NOT NULL CHECK (quantity_sold >= 0),
    total_revenue INT NOT NULL CHECK (total_revenue >= 0),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- Warehouse (Subclass)
CREATE TABLE Warehouse(
    address VARCHAR(128) PRIMARY KEY,
    item_id INT NOT NULL,
    item_total_quantity INT NOT NULL CHECK (item_total_quantity >= 0),
    order_history VARCHAR(2048),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- Supplier Information (Base Class)
CREATE TABLE SupplierInformation(
    address VARCHAR(512) PRIMARY KEY,
    name VARCHAR(512) NOT NULL,
    money_owed VARCHAR(512) NOT NULL,
    order_history VARCHAR(512)
);

-- Supplier Order (Subclass)
CREATE TABLE SupplierOrder(
    order_id INT PRIMARY KEY,
    address VARCHAR(512) NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    unit_price INT NOT NULL CHECK (unit_price >= 0),
    total_price INT NOT NULL CHECK (total_price >= 0),
    order_date DATE NOT NULL,
    FOREIGN KEY (address) REFERENCES SupplierInformation(address),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- Admin
CREATE TABLE Admin(
    admin_id INT PRIMARY KEY,
    admin_role VARCHAR(64) NOT NULL
);

-- Customer Information (missing in original code)
CREATE TABLE CustomerInformation(
    customer_id INT PRIMARY KEY,
    address VARCHAR(512) NOT NULL,
    email_id VARCHAR(128) NOT NULL,
    phone_number INT DEFAULT NULL,
    order_history VARCHAR(512)
);

-- Sale Information
CREATE TABLE SaleInformation(
    sale_id INT PRIMARY KEY,
    status VARCHAR(64) NOT NULL,
    customer_id INT NOT NULL,
    sale_items VARCHAR(2048),
    date_sold DATE NOT NULL,
    total_amount INT NOT NULL CHECK (total_amount >= 0),
    tracking_id VARCHAR(64),
    shipping_company VARCHAR(128),
    FOREIGN KEY (customer_id) REFERENCES CustomerInformation(customer_id)
);

-- Customer Names (Weak Entity Set)
CREATE TABLE CustomerNames (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(64) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CustomerInformation(customer_id)
);

-- Data Propagation
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\item_data.csv' 
INTO TABLE Item 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\accounts_data.csv' 
INTO TABLE Accounts 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\admin_data.csv' 
INTO TABLE Admin 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\customer_information_data.csv' 
INTO TABLE CustomerInformation 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\customer_names_data.csv' 
INTO TABLE CustomerNames 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\sale_information_data.csv' 
INTO TABLE SaleInformation 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\database_sample_data\\supplier_data.csv' 
INTO TABLE SupplierInformation 
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

-- Total Revenue and Quantity Sold per Item
-- CREATE VIEW TotalRevenue_and_QuantitySold AS
-- SELECT 
--     i.item_id,
--     i.item_name,
--     SUM(a.total_revenue) AS total_revenue,
--     SUM(a.quantity_sold) AS total_quantity_sold
-- FROM 
--     Accounts a
-- JOIN 
--     Item i ON a.item_id = i.item_id
-- GROUP BY 
--     i.item_id, i.item_name;


-- Aggregation Queries

-- Total Orders and Revenue per Supplier
CREATE VIEW SupplierSummary AS
SELECT s.address,
    s.name,
    COUNT(so.order_id) AS total_orders,
    SUM(so.total_price) AS total_revenue
FROM SupplierOrder so
    JOIN SupplierInformation s ON so.address = s.address
GROUP BY s.address,
    s.name;
SELECT *
FROM SupplierSummary;
-- Total Sales and Average Sales Amount per Month
CREATE VIEW SalesPerMonth AS
SELECT YEAR(si.date_sold) AS year,
    MONTH(si.date_sold) AS month,
    COUNT(si.sale_id) AS total_sales,
    SUM(si.total_amount) AS total_revenue,
    AVG(si.total_amount) AS average_sale_amount
FROM SaleInformation si
GROUP BY YEAR(si.date_sold),
    MONTH(si.date_sold);
-- Total Quantity of Each Item in the Warehouse
-- CREATE VIEW SalesPerMonth AS
-- SELECT 
--     w.item_id,
--     i.item_name,
--     SUM(w.item_total_quantity) AS total_quantity
-- FROM 
--     Warehouse w
-- JOIN 
--     Item i ON w.item_id = i.item_id
-- GROUP BY 
--     w.item_id, i.item_name;
-- Number of Customers and Total Purchases per Address
CREATE VIEW CustomerPurchases AS
SELECT c.customer_id,
    c.address,
    COUNT(si.sale_id) AS number_of_sales,
    SUM(si.total_amount) AS total_purchases
FROM CustomerInformation c
    JOIN SaleInformation si ON c.customer_id = si.customer_id
GROUP BY c.customer_id, c.address;

-- Create a view to extract month and year from the sale date and calculate total sales per item per month
CREATE VIEW MonthlyItemSales AS
SELECT
    DATE_FORMAT(date_sold, '%Y-%m') AS sale_month,
    sale_items AS item,
    SUM(total_amount) AS total_sales
FROM SaleInformation
GROUP BY DATE_FORMAT(date_sold, '%Y-%m'), sale_items;

-- Find the highest-selling item per month
SELECT sale_month, item, total_sales
FROM MonthlyItemSales
WHERE (sale_month, total_sales) IN (
    SELECT sale_month, MAX(total_sales)
    FROM MonthlyItemSales
    GROUP BY sale_month
);


-- Trigger to update quantity_sold in Item table
CREATE TRIGGER update_quantity_sold
AFTER
INSERT ON Accounts FOR EACH ROW BEGIN
UPDATE Item
SET quantity_sold = quantity_sold + NEW.quantity_sold
WHERE item_id = NEW.item_id;
END;
