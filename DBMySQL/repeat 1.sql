-- == 1st rule of the 1st normal form == --
-- == All elements within cells must be atomic (indivisible) == --

-- == 2nd rule of the 1st normal form == --
-- == All lines must be different == --


-- == 2nd normal form == --
-- == Any table field that is not part of the primary key functionally depends entirely on the primary key  == --


-- == 3rd normal form == --
-- == The table meets the requirements fo 1st and 2nd normal forms and any non-key attribute is functionally == --
-- == fully dependent on the primary key == -- 

-- == Create new schema == --
-- CREATE SCHEMA repeat_shop DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

-- == Create new table "repeat_shop" == --
-- CREATE TABLE repeat_shop.category (
-- id INT NOT NULL,
-- `name` VARCHAR(128) NOT NULL,
-- discount TINYINT NOT NULL,
-- PRIMARY KEY (id));

-- == Added new column "alias_name" == --
-- ALTER TABLE repeat_shop.category ADD COLUMN alias_name VARCHAR(128) NULL AFTER discount;


-- ==
-- show databases;
-- use название базы данных/схемы
-- show tables;
-- describe название таблицы; (показывает колонки и их атребуты) тоже самое, что и show columns from название таблицы;
-- ставим шифт тильда, если имя таблицы/схемы схожее с оператором/командой/запросом в sql
-- ==

-- == Change column name from `type` to `name` == --
-- ALTER TABLE repeat_shop.product_type CHANGE COLUMN `type` `name` VARCHAR(128) NOT NULL;

-- == Iput data into the table (`id`, `name`, `discount`) - название колонок. После VALUES по порядку перечисленным перед VALUES колонок - внесение данных
-- INSERT INTO repeat_shop.category (`id`, `name`, `discount`) VALUES (2, "Мужская одежда", 0);

-- == Show table data (table name is "category)"
-- SELECT*FROM category;

-- == Change data in the columns. Set data in column `name` where `id` = 3
-- UPDATE repeat_shop.category SET `name` = "Женская обувь" WHERE id = 3;

-- == Setting auto increment in table (автоматически добавляет +1 к ключу при внесении новой строки). Изменяем колонку ни чего не изменяя , но добавляя атрибут авто инкремента
-- ALTER TABLE repeat_shop.category CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT;


-- == WHERE choose what parameter will determine the row == --
-- SELECT*FROM category WHERE id = 3;  
-- SELECT * FROM category WHERE (discount > 5) AND (discount < 15);
-- SELECT * FROM category WHERE (discount < 5) OR (discount >=10);
-- SELECT * FROM category WHERE id IN ( 2 , 5 ); -- Substitution for OR operator
-- SELECT * FROM category WHERE NOT discount < 5;
-- == Способ выражений WHERE с NULL == --
-- SELECT*FROM category WHERE alias_name IS NOT NULL;
-- SELECT*FROM category WHERE alias_name IS NULL;

-- == Choose needed column `name` == --
-- SELECT `name` FROM category;
-- SELECT `name`,`discount` FROM category;
-- == DISTINCT убирает дубликаты значений == --
-- SELECT DISTINCT `discount` FROM category;

-- == Sorting table `category` by ascending `discount` column
-- SELECT*FROM category ORDER BY `discount`;

-- == Sorting table `category` by descending `discount` column
-- SELECT*FROM `category` ORDER BY `discount` DESC;

-- First, we exclude rows where `discount` == 0 , and then sort them in descending order of the `discount` column
-- ORDER BY must follow after conditions of WHERE 
-- SELECT*FROM `category` WHERE `discount` <> 0 ORDER BY `discount` DESC;

-- == LIMIT limits the number of shown rows
-- SELECT*FROM `category` LIMIT 2;
-- SELECT*FROM `category` WHERE `discount` <> 0 LIMIT 2;



-- SELECT*FROM category;
-- INSERT INTO repeat_shop.category (`id`, `name`, `discount`) VALUES (5, "Шляпы", 0);

-- == UPDATE updating a cell value with WHERE operator
-- UPDATE category SET name = "Головные уборы" WHERE id = 5;
-- UPDATE category SET discount = 3 WHERE id = 2 OR id = 5;

-- == DELETE data from row with WHERE operator  
-- DELETE FROM category WHERE id  = 5;
-- UPDATE category SET alias_name = "mens clothes" WHERE id = 2;
-- UPDATE category SET alias_name = "Men's shoes" WHERE id = 4;

-- == Setting up the foreign key between `product` table `brand_id` column and `brand` table `id` column/ Name of the key is `fk_brand_product`
-- ALTER TABLE `repeat_shop`.`product` ADD CONSTRAINT `fk_brand_product` FOREIGN KEY (`brand_id`) REFERENCES `repeat_shop`.`brand` (`id`) 
-- ON DELETE NO ACTION -- actions then delete cell. If it would be CASCADE the deletion of the id from the `brand` table will result in a deletion rows with this brand is in the associated table `product`
-- ON UPDATE NO ACTION; -- actions then update cell


-- == DIAGRAAMMA / SHEME  click on "Database" - "Reverce Engineer" - chhode your srerver - choose ypor batabase / cheme

-- ALTER TABLE `repeat_shop`.`product` ADD CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `repeat_shop`.`category` (`id`)
-- ON DELETE NO ACTION
-- ON UPDATE NO ACTION;

-- == Made `order` table == --
-- CREATE TABLE `repeat_shop`.`order` (
-- `id` INT NOT NULL AUTO_INCREMENT,
-- `user_name` VARCHAR(128) NOT NULL,
-- `phone` VARCHAR(32) NOT NULL,
-- `datetime` DATETIME NOT NULL,
-- PRIMARY KEY (`id`));

-- == Filling out the `order` table with INSERT INTO command
-- INSERT INTO `repeat_shop`.`order` (user_name, phone, datetime) VALUES ('Василий', '555-55-55', '2016-05-09 14^20');



-- == Made `order_products` table for cart (otherwise, table "order" couldn't be a "normal" type of a table)
-- CREATE TABLE `repeat_shop`.`order_products` (
-- `order_id` INT NOT NULL,
-- `product_id` INT NOT NULL,
-- `count` INT NOT NULL,
-- PRIMARY KEY (`order_id`, `product_id`));

-- == Removing "NOT NULL" attribute from `count` column
-- ALTER TABLE `repeat_shop`.`order_products` 
-- CHANGE COLUMN `count` `count` INT NULL ;

-- == Adding products into the order (cart) == --
-- INSERT INTO order_products (order_id, product_id, count) VALUES (1, 1, 1);
-- INSERT INTO order_products (order_id, product_id, count) VALUES (1, 2, 3);

-- == Добавляем составной внешний ключ
-- ALTER TABLE `repeat_shop`.`order_products` ADD INDEX `fk_order_products_idx` (`product_id` ASC);

-- ALTER TABLE `repeat_shop`.`order_products` ADD CONSTRAINT `fk_order_products_order` FOREIGN KEY (`order_id`) REFERENCES `repeat_shop`.`order` (`id`) 
-- ON DELETE NO ACTION 
-- ON UPDATE NO ACTION; 

-- ALTER TABLE `repeat_shop`.`order_products` ADD CONSTRAINT `fk_order_products_product` FOREIGN KEY (`product_id`) REFERENCES `repeat_shop`.`product` (`id`)
-- ON DELETE NO ACTION
-- ON UPDATE NO ACTION;
-- == ---



-- == Change "NULL" to "NOT NULL" attribute from `count` column
-- ALTER TABLE  `repeat_shop`.`order_products` 
-- CHANGE COLUMN `count` `count` INT NOT NULL;

-- DESCRIBE `repeat_shop`.`order_products`;


-- == INNER JOIN add table `category` to the `product` table where column `product`.`category_id` equals `category`.`id`
-- SELECT*FROM `product` INNER JOIN `category` ON `product`.`category_id` = `category`.`id`;

-- Show only `product`.`id`, `price`, `name` columns
-- SELECT `product`.`id`, `price`, `name` FROM `product` INNER JOIN `category` ON `product`.`category_id` = `category`.`id`;

-- SELECT `product`.`id`, `price`, `name` FROM `product` INNER JOIN `category` ON `product`.`category_id` = `category`.`id`
-- WHERE price <= 8999; -- Use WHERE to filter an acquired results

-- == Множественное объединение 

-- SELECT `product`.`id`, `brand`.`name`, `product_type`.`name`, `category`.`name`, `product`.`price` FROM `product`
-- INNER JOIN `category` ON `product`.`category_id` = `category`.`id`
-- INNER JOIN `brand` ON `product`.`brand_id` = `brand`.`id`
-- INNER JOIN `product_type` ON `product`.`product_type_id` = `product_type`.`id`
-- WHERE `product_type`.`name` = "Футболка";


-- SELECT * FROM `product` INNER JOIN `category` ON `product`.`category_id` = `category`.`id`;

-- == `brand`.`name` as brand_name the "name" column from "brand" table will appear as "brand_name" in query result
-- SELECT `product`.`id`, `brand`.`name` as brand_name, `product_type`.`name`, `category`.`name`, `product`.`price` FROM `product`
-- INNER JOIN `category` ON `product`.`category_id` = `category`.`id`
-- INNER JOIN `brand` ON `product`.`brand_id` = `brand`.`id`
-- INNER JOIN `product_type` ON `product`.`product_type_id` = `product_type`.`id`;

USE repeat_shop; -- == Choose the database/scheme == ---
-- LEFT JOIN. Show all categories that don't present in the "products" table. SELECT `category`.* - show columns from category table
SELECT `category`.* FROM `category`
LEFT JOIN `product` ON `product`.`category_id` = `category`.`id`
WHERE `product`.`id` IS NULL;





