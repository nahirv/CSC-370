-- CREATE DATABASE `CompanyInventory`;
USE `CompanyInventory`;
 
DROP TABLE `Admin`;
 
 CREATE TABLE `Admin`(
    `admin_id` INT PRIMARY KEY,
     `employee_name` VARCHAR(64),
    `role` VARCHAR(64)
);
DROP TABLE `Admin`;
INSERT INTO `Admin`(`admin_id`,`employee_name`,`role`) 
VALUES (1,"Ishan","Manager"),(2,"Nahir","Accountant"),(3,"Arjun","Sales"), (4,"Olivia","Shelf Stocker");
SELECT*FROM Admin;

CREATE USER Ishan;
CREATE USER Nahir;
CREATE USER Arjun;
CREATE USER Olivia;

GRANT ALL ON `Admin` TO Ishan WITH GRANT OPTION;
GRANT ALL ON `customerinformation` TO Ishan WITH GRANT OPTION;
GRANT ALL ON `item` TO Ishan WITH GRANT OPTION;
GRANT ALL ON `saleinformation` TO Ishan WITH GRANT OPTION;
GRANT ALL ON `supplier` TO Ishan WITH GRANT OPTION;
GRANT ALL ON `supplierorder` TO Ishan WITH GRANT OPTION;
GRANT ALL ON `warehouse` TO Ishan WITH GRANT OPTION;
GRANT ALL ON `accounts` TO Ishan WITH GRANT OPTION;

GRANT SELECT,INSERT,UPDATE,DELETE ON `accounts` TO Nahir WITH GRANT OPTION;
GRANT SELECT, INSERT, DELETE, UPDATE ON `warehouse` TO Olivia;
GRANT SELECT, INSERT, DELETE, UPDATE ON `saleinformation` TO Arjun;
GRANT SELECT, INSERT, DELETE, UPDATE ON `item` TO Arjun;
GRANT SELECT, INSERT, DELETE, UPDATE ON `customerinformation` TO Arjun;

SHOW GRANTS FOR Ishan;
SHOW GRANTS FOR Arjun;
SHOW GRANTS FOR Nahir;
SHOW GRANTS FOR Olivia;
