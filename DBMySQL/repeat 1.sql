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

USE repeat_shop; -- == Choose the database/scheme == ---

SELECT*FROM category;
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



