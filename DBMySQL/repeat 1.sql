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


-- LEFT JOIN. Show all categories that don't present in the "products" table. SELECT `category`.* - show columns from category table
-- SELECT `category`.* FROM `category`
-- LEFT JOIN `product` ON `product`.`category_id` = `category`.`id`
-- WHERE `product`.`id` IS NULL;


-- INSERT INTO `order` (`user_name`, `phone`, `datetime`) VALUES ("Петр", "888-88-88", "2016-05-28");


-- SELECT * FROM `order`
--  LEFT JOIN `order_products` ON `order`.`id` = `order_products`.`order_id`
--  LEFT JOIN `product` ON `order_products`.`product_id` = `product`.`id` -- ТУТ УЖАЛИТЬ точку с запятой

-- UNION --== Unite both of these JOINs in one output, we can use "AS" for rename outputted columns

-- SELECT * FROM `order`
--  INNER JOIN `order_products` ON `order`.`id` = `order_products`.`order_id`
--  RIGHT JOIN `product` ON `order_products`.`product_id` = `product`.`id`
--  WHERE `order`.`id` is NULL;


-- SELECT count(*) FROM `product`; -- "count" numbers of rows
-- SELECT count(*) FROM `product` WHERE `product`.`price` < 10000;
-- SELECT sum(`product`.`price`) FROM `product`; -- Summarises of all values in `price` column
-- SELECT sum(`product`.`price`) as common_worth, min(`product`.`price`) as min_prise, max(`product`.`price`) as max_prise FROM `product` WHERE `product`.`price` <= 10000; -- MAX and MIN

-- INSERT INTO `order_products` (`order_id`, `product_id`, `count`) VALUES ('2', '2', '1');
-- INSERT INTO `order_products` (`order_id`, `product_id`, `count`) VALUES ('2', '1', '2');


-- SELECT `order`.`id`,`order`.`user_name`, `order_products`.`count`, `product`.`price`, price * `count` as total, sum(price * `count`) as TP FROM `order` -- УМНОЖЕНИЕ ВОЗМОЖНО В КОЛОКНКАХ 
-- INNER JOIN `order_products` ON `order`.`id` = `order_products`.`order_id`
-- INNER JOIN `product` ON `order_products`.`product_id` = `product`.`id`
-- WHERE `order`.`id` = "1";

-- USE repeat_shop; -- == Choose the database/scheme == ---
-- SELECT `order`.`user_name`, `product`.`price` * `count` as total_price FROM `order`
-- INNER JOIN `order_products` ON `order`.`id` = `order_products`.`order_id`
-- INNER JOIN `product` ON `order_products`.`product_id` = `product`.`id`
-- GROUP BY `order`.`user_name`; -- Выводит агрегирующий запрос сумм , но уже не по всем столбцам один ответ суммы, а на две строки для `order`.`user_name`

-- USE repeat_shop;
-- SELECT `order`.`user_name`, max(`product`.`price`), count(*), sum(`count`) FROM `order` -- Агрегирующая функция возвращает максимм по толбцу price среди сгрупированных по `order`.`user_name`. Count считает количество строк (в данном слечае это по 2 различных типа товаров у каждого в корзине). Sum(`count`) поличество товаров по столбцу каунт для каждого юзера
-- INNER JOIN `order_products` ON `order`.`id` = `order_products`.`order_id`
-- INNER JOIN `product` ON `order_products`.`product_id` = `product`.`id`
-- GROUP BY `order`.`user_name`;

-- USE repeat_shop;
--  SELECT `order`.`user_name`, max(`product`.`price`), sum(`count`) FROM `order`
--  INNER JOIN `order_products` ON `order`.`id` = `order_products`.`order_id`
--  INNER JOIN `product` ON `order_products`.`product_id` = `product`.`id`
 -- WHERE `user_name` like 'В%'
--  GROUP BY `order`.`user_name`;

-- USE repeat_shop;
  -- SELECT `order`.`user_name`, max(`product`.`price`), sum(`count`) FROM `order`
  -- INNER JOIN `order_products` ON `order`.`id` = `order_products`.`order_id`
  -- INNER JOIN `product` ON `order_products`.`product_id` = `product`.`id`
  -- GROUP BY `order`.`user_name`
  -- HAVING sum(`count`) >= 4; -- Это WHERE для агрегирующей функции так же можно задать ус=ловие по присвоенному имени столбца через AS 


USE `repeat_shop`;
	-- SELECT `name` FROM `category`;
	-- INSERT INTO `category` (name, discount, alias_name) VALUES ("Мужская верхняя одежда", 5, "AAA");
	-- SELECT DISTINCT `discount` FROM `category`;
	-- SELECT * FROM `category` ORDER BY `discount`DESC;
	-- SELECT * FROM `category`WHERE `discount` <> 5 ORDER BY `discount`;
    -- SELECT * FROM `category`WHERE `discount` <> 5 ORDER BY `discount` DESC LIMIT 2;
    
-- CREATE TABLE `repeat_shop`.`user_bank_accoun` (
--  	`id` INT NOT NULL AUTO_INCREMENT,
--     	`money` DECIMAL(10, 2) NOT NULL,
--     	`user_name` VARCHAR(45) NOT NULL,
--     PRIMARY KEY (`id`));

-- INSERT INTO `repeat_shop`.`user_bank_accoun` (`money`, `user_name`) VALUES (100, 'Дмитрий');
-- INSERT INTO `repeat_shop`.`user_bank_accoun` (`money`, `user_name`) VALUES (200, 'Евгений');

-- UPDATE `repeat_shop`.`user_bank_accoun` SET money = money - 100 WHERE id = 1;
-- UPDATE `repeat_shop`.`user_bank_accoun` SET money = money + 100 WHERE id = 2;
-- SELECT * FROM `repeat_shop`.`user_bank_accoun`;

-- UPDATE `repeat_shop`.`user_bank_accoun` SET money = money + 100 WHERE id = 1;
-- UPDATE `repeat_shop`.`user_bank_accoun` SET money = money - 100 WHERE id = 2;
-- SELECT * FROM `repeat_shop`.`user_bank_accoun`;

-- START TRANSACTION;
	-- UPDATE `repeat_shop`.`user_bank_accoun` SET money = money - 100 WHERE id = 1;
    -- UPDATE `repeat_shop`.`user_bank_accoun` SET money = money + 100 WHERE id = 2;
-- COMMIT;
-- SELECT * FROM `repeat_shop`.`user_bank_accoun`;

-- CREATE SCHEMA `sport`; -- Greating the database

-- CREATE TABLE `sport`.`competition` (
	-- `competition_id` INT NOT NULL AUTO_INCREMENT,
    -- `competition_name` VARCHAR(45) NOT NULL,
    -- `word_record` VARCHAR(45) NOT NULL,
    -- `set_date` date,
-- PRIMARY KEY (`competition_id`));
    
-- CREATE TABLE `sport`.`result` (
	-- `competition_id` INT NOT NULL,
    -- `sportsman_id` INT NOT NULL,
    -- `result` INT NOT NULL,
    -- `city` VARCHAR(45),
    -- `hold_date` DATE NOT NULL,
-- PRIMARY KEY(`competition_id`, `sportsman_id`));

-- CREATE TABLE `sport`.`sportsman` (
	-- `sportsman_id` INT NOT NULL AUTO_INCREMENT,
    -- `sportsman_name` VARCHAR(45) NOT NULL,
    -- `rank` VARCHAR(45) NOT NULL,
    -- `year_of_birth` INT NOT NULL,
    -- `personal_record` VARCHAR(45) NOT NULL,
    -- `country` VARCHAR(45) NOT NULL,
-- PRIMARY KEY(`sportsman_id`));


-- ALTER TABLE `sport`.`sportsman`
	-- CHANGE COLUMN `rank` `rank` INT NOT NULL;
-- INSERT INTO `sport`.`competition` (`competition_name`, `word_record`, `set_date`) VALUES ("Swim", "NO", '01.01.2000');
-- UPDATE `sport`.`competition` SET `set_date` = '2005-02-15' WHERE competition_id = 3;
-- UPDATE `sport`.`competition` SET `set_date` = '2003-05-15' WHERE competition_id = 4;
-- UPDATE `sport`.`competition` SET competition_name = "Football" WHERE competition_id = 4;
-- UPDATE `sport`.`competition` SET competition_name = "Jump" WHERE competition_id = 3;
-- INSERT INTO `sport`.`competition` (`competition_name`, `word_record`, `set_date`) VALUES ("Run", "YES", '2007-07-30');
-- INSERT INTO `sport`.`sportsman` (`sportsman_name`, `rank`, `year_of_birth`, `personal_record`, `country`) VALUES ("John", 5, 1980, "Swim 100m in 20 sec", "USA");
-- INSERT INTO `sport`.`sportsman` (`sportsman_name`, `rank`, `year_of_birth`, `personal_record`, `country`) VALUES ("Clara", 2, 1998, "Run 100m in 50 sec", "England");
-- INSERT INTO `sport`.`sportsman` (`sportsman_name`, `rank`, `year_of_birth`, `personal_record`, `country`) VALUES ("Bob", 1, 1995, "Made 10 goals in on match", "France");
-- INSERT INTO `sport`.`sportsman` (`sportsman_name`, `rank`, `year_of_birth`, `personal_record`, `country`) VALUES ("Tot", 3, 1995, "Nice guy)", "Italy");
-- INSERT INTO `sport`.`sportsman` (`sportsman_name`, `rank`, `year_of_birth`, `personal_record`, `country`) VALUES ("Bill", 3, 1990, "Did some thing in sport", "Spain");
-- INSERT INTO `sport`.`result` (`competition_id`, `sportsman_id`, `result`, `city`, `hold_date`) VALUES (1, 2, 50, "London", '2012-05-04');
-- INSERT INTO `sport`.`result` (`competition_id`, `sportsman_id`, `result`, `city`, `hold_date`) VALUES (2, 1, 20, "Washington", '2015-07-20');
-- INSERT INTO `sport`.`result` (`competition_id`, `sportsman_id`, `result`, `city`, `hold_date`) VALUES (3, 4, 15, "Rome", '2014-03-25');
-- INSERT INTO `sport`.`result` (`competition_id`, `sportsman_id`, `result`, `city`, `hold_date`) VALUES (4, 3, 10, "Paris", '2015-07-20');
-- INSERT INTO `sport`.`result` (`competition_id`, `sportsman_id`, `result`, `city`, `hold_date`) VALUES (5, 5, 12, "Madrid", '2017-09-15');


-- SELECT * FROM `sport`.`result`;
-- SELECT `competition_id` as id, `competition_name` as name FROM `sport`.`competition`;

-- == Setting up the foreign key between `product` table `brand_id` column and `brand` table `id` column/ Name of the key is `fk_brand_product`
-- ALTER TABLE `repeat_shop`.`product` ADD CONSTRAINT `fk_brand_product` FOREIGN KEY (`brand_id`) REFERENCES `repeat_shop`.`brand` (`id`) 
-- ON DELETE NO ACTION -- actions then delete cell. If it would be CASCADE the deletion of the id from the `brand` table will result in a deletion rows with this brand is in the associated table `product`
-- ON UPDATE NO ACTION; -- actions then update cell

USE `sport`;
-- ALTER TABLE `competition` ADD CONSTRAINT `fk_competiton_result` FOREIGN KEY (`competition_id`) REFERENCES `result` (`competition_id`)
	-- ON DELETE NO ACTION
    -- ON UPDATE NO ACTION;
-- ALTER TABLE `sportsman` ADD CONSTRAINT `fk_sportsman_result` FOREIGN KEY (`sportsman_id`) REFERENCES `sport`.`result` (`sportsman_id`)
	-- ON DELETE NO ACTION
    -- ON UPDATE NO ACTION;
-- SELECT `sportsman`.*, `result`.`competition_id`, `result`.`result` ,`result`.`city` ,`result`.`hold_date`, `competition`.`competition_name` , `competition`.`word_record` , `competition`.`set_date` FROM `sportsman`
	-- INNER JOIN `result` ON `sportsman`.`sportsman_id` = `result`.`sportsman_id`
    -- INNER JOIN `competition` ON `result`.`competition_id` = `competition`.`competition_id`;
    
-- SELECT * FROM `competition`
	-- INNER JOIN `result` ON `competition`.`competition_id` = `result`.`competition_id`
    -- INNER JOIN `sportsman` ON `result`.`sportsman_id` = `sportsman`.`sportsman_id`;

-- SELECT `sportsman`.`sportsman_name` FROM `sportsman` WHERE `year_of_birth` <> 1995;

-- SELECT * FROM `competition`
	-- INNER JOIN `result` ON `competition`.`competition_id` = `result`.`competition_id`
    -- WHERE `competition`.`set_date` IN ('2001-01-20', '2007-07-30'); 

SELECT * FROM `competition`
	INNER JOIN `result` ON `competition`.`competition_id` = `result`.`competition_id`
    WHERE (`result`.`city` = "London" OR `result`.`city` = "Paris") AND `result`.`result` = 10;







    
    