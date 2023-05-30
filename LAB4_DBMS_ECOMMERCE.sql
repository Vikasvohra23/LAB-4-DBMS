CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

CREATE TABLE SUPPLIER (
SUPP_ID INT PRIMARY KEY AUTO_INCREMENT,
SUPP_NAME VARCHAR(50) NOT NULL,
SUPP_CITY VARCHAR(50) NOT NULL,
SUPP_PHONE VARCHAR(50) NOT NULL
);
DESCRIBE SUPPLIER;

CREATE TABLE CUSTOMER(
CUS_ID INT PRIMARY KEY AUTO_INCREMENT,
CUS_NAME VARCHAR(50) NOT NULL,
CUS_CITY VARCHAR(50) NOT NULL,
CUS_PHONE VARCHAR(50) NOT NULL,
CUS_GENDER  ENUM('M','F') NOT NULL
);
DESCRIBE CUSTOMER;

CREATE TABLE CATEGORY(
CAT_ID INT PRIMARY KEY AUTO_INCREMENT,
CAT_NAME VARCHAR(50) NOT NULL
);
DESCRIBE CATEGORY;

CREATE TABLE PRODUCT(
  PRO_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
  PRO_NAME VARCHAR(20) NOT NULL, 
  PRO_DESC VARCHAR(60), 
    CAT_ID INT UNSIGNED, 
    FOREIGN KEY(CAT_ID) REFERENCES CATEGORY(CAT_ID)
);
DESCRIBE PRODUCT;

CREATE TABLE SUPPLIER_PRICING(
PRICING_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
PROD_ID INT UNSIGNED, FOREIGN KEY(SUPP_ID) REFERENCES SUPPLIER(SUPP_ID),
SUPP_PRICE INT DEFAULT 0
);
DESCRIBE SUPPLIER_PRICING;

CREATE TABLE ORDERS_TABLE(
ORDER_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
AMOUNT INT UNSIGNED NOT NULL,
CUS_ID INT UNSIGNED, FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER (CUS_ID)
);
DESCRIBE ORDERS_TABLE;

CREATE TABLE RATING(
RAT_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
ORD_ID INT UNSIGNED, FOREIGN KEY (ORDER_ID) REFERENCES ORDERS_TABLE (ORDER_ID),
RAT_RATSTARTS INT NOT NULL 
);
 
 INSERT INTO SUPPLIER 
 (SUPP_ID, SUPP_NAME, SUPP_CITY, SUPP_PHONE)
 
 VALUES 
 (1,'Rajesh Retails','Delhi','1234567890'),
 (2,'Appario Ltd.','Mumbai','2589631470'),
 (3,'Knome products','Banglore','9785462315'),
 (4,'Bansal Retails','Kochi','8975463285'),
 (5,'Mittal Ltd.','Lucknow','7898456532');

INSERT INTO CUSTOMER
(CUS_ID, CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) 

VALUES 
(1,'AAKASH','9999999999','DELHI','M'),
(2,'AMAN','9785463215','NOIDA','M'),
(3,'NEHA','9999999999','MUMBAI','F'),
(4,'MEGHA','9994562399','KOLKATA','F'),
(5,'PULKIT','7895999999','LUCKNOW','M');

INSERT INTO CATEGORY
(CAT_ID, CAT_NAME)

 VALUES 
 (1,'BOOKS'),
 (2,'GAMES'),
 (3,'GROCERIES'),
 (4,'ELECTRONICS'),
 (5,'Clothes');

INSERT INTO PRODUCT
(PROD_ID, PROD_NAME, PROD_DESC, CAT_ID)

 VALUES 
 (14,'GTA V','Windows 7 and above with i5 processor and 8GB RAM',2),
 (15,'TSHIRT','SIZE-L with Black, Blue and White variations',5),
 (16,'ROG LAPTOP	','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4),
 (17,'OATS','Highly Nutritious from Nestle',3),(18,'HARRY POTTER','Best Collection of all time by J.K Rowling',1),
 (19,'MILK','1L Toned Milk',3),
 (20,'Boat Earphones','1.5Meter long Dolby Atmos',4),
 (21,'Jeans','Stretchable Denim Jeans with various sizes and color',5),
 (22,'Project IGI','compatible with windows 7 and above',2),
 (23,'Hoodie','Black GUCCI for 13 yrs and above',5),
 (24,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1),
 (25,'Train Your Brain','By Shireen Stephen',1);

INSERT INTO SUPPLIER_PRICING
 VALUES 
 (11,14,2,1500),
 (12,16,5,30000),(13,18,1,3000),
 (14,15,3,2500),(15,17,1,1000);

INSERT INTO ORDERS
 VALUES 
 (101,1500,'2021-10-06',2,11),
 (102,1000,'2021-10-12',3,15),
 (103,30000,'2021-09-16',5,12),
 (104,1500,'2021-10-05',1,11),
 (105,3000,'2021-08-16',4,13),
 (106,1450,'2021-08-18',1,14),
 (107,789,'2021-09-01',3,12),
 (108,780,'2021-09-07',5,11),
 (109,3000,'2021-01-10',5,13),
 (110,2500,'2021-09-10',2,14),
 (111,1000,'2021-09-15',4,15),
 (112,789,'2021-09-16',4,12),
 (113,31000,'2021-09-16',1,13),
 (114,1000,'2021-09-16',3,15),
 (115,3000,'2021-09-16',5,13),
 (116,99,'2021-09-17',2,14);

INSERT INTO RATING
VALUES 
(1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(6,106,3),
(7,107,4),
(8,108,4),
(9,109,3),
(10,110,5),
(11,111,3),
(12,112,4),
(13,113,2),
(14,114,1),
(16,116,0);

SELECT cust_gender, COUNT(DISTINCT customer.cust_id) as TotalCustomers
FROM customer
JOIN orders ON customer.cust_id = orders.cust_id
WHERE orders.ORD_AMOUNT >= 3000
GROUP BY cust_gender;

select cust_name, cust_city, o.ORD_AMOUNT, o.pricing_id, s.PRO_ID, p.PRO_NAME, p.PRO_DESC
   from customer inner join orders as o 
     on customer.cust_id=o.CUST_ID 
     inner join supplier_pricing as s
       on o.PRICING_ID = s.PRICING_ID
     inner join product as p
       on s.PRO_ID=p.PRO_ID
     and customer.cust_id=2;

select s.supp_name, count(p.PRO_NAME) as num_of_products from supplier as s inner join supplier_pricing as sp on s.SUPP_ID=sp.SUPP_ID
        inner join product as p on sp.PRO_ID=p.PRO_ID
        group by s.SUPP_NAME
        having num_of_products > 1;

select c.cust_name, o.ord_amount, o.ord_date, p.pro_name, p.PRO_DESC  from orders as o inner join supplier_pricing as sp 
         on o.PRICING_ID=sp.PRICING_ID
     inner join product as p on sp.pro_id=p.PRO_ID   
     inner join customer as c
       on o.CUST_ID=c.cust_id
    where o.ORD_DATE > "2021-09-01";
    
    select customer.cus_name,customer.cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A' ;






