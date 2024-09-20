create database session03;
use session03;

CREATE TABLE product(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	created DATE
);

CREATE TABLE color (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
status BIT(1) DEFAULT 1
);

CREATE TABLE size (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
status BIT(1) DEFAULT 1
);

CREATE TABLE product_detail (
id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT,
color_id INT,
size_id INT,
price DOUBLE CHECK(price > 0),
stock INT CHECK(stock >= 0),
status BIT(1) DEFAULT 1,
FOREIGN KEY(product_id) REFERENCES product(id),
FOREIGN KEY(color_id) REFERENCES color(id),
FOREIGN KEY(size_id) REFERENCES size(id)
);

INSERT INTO color (name,status) values ('red',true),('green',true),('blue',true);

INSERT INTO size (name,status) values ('S',true),('M',true),('L',true),('XL',true),('XXL',true);

INSERT INTO product (name,created) values ('Quàn dài','2024-09-20'),('Áo dài','2024-09-20'),('Mũ cối','2024-09-20');

INSERT INTO product_detail (product_id,color_id,size_id,price,stock,status) values 
(1,1,1,1200,5,true),
(2,1,1,1500,2,true),
(1,2,3,500,3,true),
(1,2,3,1600,3,false),
(3,1,4,1200,5,true),
(3,3,5,1200,6,true);

SELECT pd.*,p.name from product_detail as pd join product as p on pd.product_id = p.id where product_id = 1;



-- count(), sum() , len(), avg(), min(), max(),...

