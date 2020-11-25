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




