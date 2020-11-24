use shop;
-- == SELECT == --
-- вывести все категории товаров
-- SELECT * FROM category;

-- == WHERE == --
-- вывести категорию товаров с идентификатором, равным 3
-- SELECT * FROM category WHERE id = 3;

-- вывести категории товаров, у которых скидка не равна 0
-- SELECT * FROM category WHERE NOT discount = 0;
-- SELECT * FROM category WHERE discount <> 0;

-- вывести категории товаров, у которых скидка больше 5
-- SELECT * FROM category WHERE discount > 5;

-- вывести категории товаров, у которых скидка больше 5 и меньше 15
-- SELECT * FROM category WHERE (discount>5) AND (discount<15);

-- вывести категории товаров, у которых скидка меньше 5 или больше или равен 10
-- SELECT * FROM category WHERE (discount<5) OR (discount>=10);

-- вывести категории товаров, у которых скидка не меньше 5
-- SELECT * FROM category WHERE NOT (discount<5);

-- вывести категории товаров, у которых есть псевдоним
-- SELECT * FROM category WHERE alias_name IS NOT NULL;

-- вывести категории товаров, у которых нет псевдонима
-- SELECT * FROM category WHERE alias_name IS NULL;

-- вывести названия всех категорий товаров
-- SELECT name FROM category;

-- вывести названия и скидки всех товаров
-- SELECT name, discount FROM category;
-- SELECT discount, name FROM category;

-- вывести все скидки
-- SELECT discount FROM category;

-- ==DISTINCT== --
-- вывести все уникальные (убрать дубликаты, повторяющиеся) значения скидок
-- SELECT DISTINCT discount FROM category;

-- == ORDER BY == --
-- вывести все категории товаров, и отсортировать их по размеру скидки
-- SELECT * FROM category ORDER BY discount ASC;

-- == ORDER BY == --
-- вывести все категории товаров, и отсортировать их по размеру скидки в обратном порядке
-- SELECT * FROM category ORDER BY discount DESC;

-- вывести все категории товаров с ненулевой скидкой, и отсортировать их по размеру скидки в обратном порядке
-- SELECT * FROM category WHERE discount <> 0 ORDER BY discount DESC;

-- == LIMIT == --
-- вывести первые 2 категории товара
-- SELECT * FROM category LIMIT 2;

-- вывести первые 2 категории товара со скдикой не равной нулю
--  SELECT * FROM category WHERE discount <> 0 LIMIT 2;

-- Получить название бренда с идентефикатором 3 из таблиы brand
-- SELECT * FROM brand WHERE id=3;

-- Получить первые 2 типа товара из таблицы product_type
-- SELECT * FROM product_type LIMIT 2;

-- Получить все категории товаров со скидкой < 10% , и отсоритровать их по названю
-- SELECT * FROM category WHERE discount < 10 ORDER BY name;

-- Поменять название "Шляпы" на "Головные уборы" в таблице category
-- UPDATE category SET name = 'Головные уборы' WHERE id = 5;

-- Изменить все скидки 0 на 3
-- UPDATE category SET discount = 3 WHERE id = 2 OR id = 5 ;
-- UPDATE category SET discount = 3 WHERE id IN ( 2, 5 );

-- удалить строку из таблицы
-- DELETE FROM category WHERE id = 5;


-- С помощью команды UPDATE  заполнить alias_name для всех категорий
-- UPDATE category SET alias_name = 'Women''s wear' WHERE id = 1;
-- UPDATE category SET alias_name = 'Men''s wear' WHERE id = 2;
-- UPDATE category SET alias_name = 'Women''s shoes' WHERE id = 3;
-- UPDATE category SET alias_name = 'Men''s shoes' WHERE id = 4;


-- Добавить новый бренд "Тетя Клава Company"
-- INSERT INTO brand (id, name) VALUES (4, 'Тетя Клава Company');

-- Удалить бренд "Тетя Клава Company"
-- DELETE FROM brand WHERE id = 4;
-- SELECT * FROM category;


-- == INNER JOIN == --
-- пересечение между таблицами по заданному равенству столбцов --
-- SELECT * FROM product INNER JOIN category ON category_id = category.id;
-- SELECT product.id, product.price, category.name FROM product INNER JOIN category ON product.category_id = category.id;
-- SELECT product.id, category.name, product.price FROM product INNER JOIN category ON product.category_id = category.id;

-- SELECT product.id, category.name, product.price, category.discount FROM product
	-- INNER JOIN category ON product.category_id = category.id
	-- WHERE product.price < 15000 AND category.discount > 3 ORDER BY product.price DESC;
    
-- SELECT * FROM product
	-- INNER JOIN category ON product.id = category.id
	-- INNER JOIN brand ON product.brand_id = brand.id
    -- INNER JOIN product_type ON product.product_type_id = product_type.id;

-- SELECT product.id, brand.name, product_type.name, category.name, product.price, category.discount FROM product
	-- INNER JOIN category ON product.category_id = category.id
    -- INNER JOIN brand ON product.brand_id = brand.id
    -- INNER JOIN product_type ON product.product_type_id = product_type.id
    -- WHERE product.price < 15000 AND category.discount > 3 ORDER BY price DESC;
    
-- SELECT product.id, brand.name, product_type.name, category.name, product.price, category.discount FROM product
	-- INNER JOIN category ON product.category_id = category.id
    -- INNER JOIN brand ON product.brand_id = brand.id
    -- INNER JOIN product_type ON product.product_type_id = product_type.id
    -- WHERE product_type.name = 'Футболка' ORDER BY product.price DESC;

-- SELECT product.id as article, brand.name as brand_name, product_type.name as product_type,
	   -- category.name as category, product.price as price, category.discount as discount FROM product
       -- INNER JOIN category ON product.category_id = category.id
       -- INNER JOIN brand ON product.brand_id = brand.id
       -- INNER JOIN product_type ON product.product_type_id = product_type.id
       -- WHERE product_type.name = 'Футболка';
       
       
-- == LEFT JOIN == --
-- Попадают все значения из FROM , если нет равных пересечений, тогда солбцы заполняться NULL, по этому признаку можно будет отфильтровать в дальнейшем
-- SELECT category.* FROM category
	-- LEFT JOIN product ON category.id = product. category_id
    -- WHERE product.id IS NULL;
    
-- SELECT product_type.* FROM product_type
	-- LEFT JOIN product ON product_type.id = product.product_type_id
    -- WHERE product.id IS NULL;

-- вывести информацию обо всех товарах, которые не попали ни в один из заказов    
-- SELECT product.id as article, brand.name as brand_name, product_type.name as product_type,
	--   category.name as category, product.price as price, category.discount as discount FROM product
	-- LEFT JOIN category ON product.category_id = category.id
    -- LEFT JOIN brand ON product.brand_id = brand.id
    -- LEFT JOIN product_type ON product.product_type_id = product_type.id
    -- LEFT JOIN order_products ON product.id = order_products.product_id
    -- WHERE order_products.order_id IS NULL;
    
-- == FULL OUTER JOIN ее в MySQL нет, вместо нее UNION== --
-- SELECT * FROM product_type WHere id = 1
-- UNION
-- SELECT * FROM product_type WHere id = 2;

-- Объединяем заказы для с продуктами, заказы без продутков и продукты без заказов
-- SELECT * FROM shop.order
	-- LEFT JOIN order_products ON order_products.order_id = shop.order.id
    -- LEFT JOIN product ON order_products.product_id = product.id
    
   --  union
    
-- SELECT * FROM shop.order
	-- INNER JOIN order_products ON order_products.order_id = shop.order.id
    -- RIGHT JOIN product ON order_products.product_id = product.id
    -- WHERE shop.order.id IS NULL;
-- -


-- == MIN , MAX , SUMM , COUNT == --
-- SELECT min(price) as max_price, max(price) as 'min price', sum(price) as 'summ of all prices' FROM product;
--  можно умножать одни столбцы на другие после SELECT
-- SELECT shop.order.*, category.name, category.discount, order_products.count, product.price, price*order_products.count as total_price
-- FROM shop.order
	-- LEFT JOIN order_products ON shop.order.id = order_products.order_id
    -- LEFT JOIN product ON order_products.product_id = product.id
    -- LEFT JOIN category ON product.category_id = category.id
    -- WHERE shop.order.user_name = 'Василий';
    
    
-- == GROUP BY == -- 
-- групирует строи, сумирование прописывается зарание в SELECT, потом группировка скрывает строки (которые были участниками в суммировании)
-- SELECT shop.order.user_name, category.name, category.discount, order_products.count, 
-- product.price, sum(price*order_products.count) as total_price
-- FROM shop.order
	-- LEFT JOIN order_products ON shop.order.id = order_products.order_id
    -- LEFT JOIN product ON order_products.product_id = product.id
    -- LEFT JOIN category ON product.category_id = category.id
    -- GROUP BY shop.order.user_name;    
    
    
-- SELECT shop.order.user_name, max(price), sum(order_products.count) FROM shop.order
	-- INNER JOIN order_products ON shop.order.id = order_products.order_id
    -- INNER JOIN product ON order_products.product_id = product.id
    -- GROUP BY shop.order.user_name;


-- == LIKE == --
-- LIKE смотрит на схожесть части строки , знак % - любое количество символов

-- == HAVING == --
-- ограниччитель типа WHERE для появившихся групировкой функций/значений , можно укахзвать имена столбцов, которые изменили чарез as после SELECT
-- SELECT shop.order.user_name, max(price), sum(order_products.count) FROM shop.order
	-- INNER JOIN order_products ON shop.order.id = order_products.order_id
    -- INNER JOIN product ON order_products.product_id = product.id
       -- WHERE shop.order.user_name LIKE '%и%'
    -- GROUP BY shop.order.user_name
    -- HAVING sum(order_products.count) >= 3; 
    
    
-- INSERT INTO user_bank_account (id, money, user_name) VALUES (1, 100, 'Дмитрий');
-- INSERT INTO user_bank_account (id, money, user_name) VALUES (2, 200, 'Евгений');

-- == TRANSACTION == -- 
-- TRANSACTION выполняться либо все команды между START и COMMIT, либо не одной
START TRANSACTION;
	UPDATE user_bank_account SET money = money - 100 WHERE id = 1;
	UPDATE user_bank_account SET money = money + 100 WHERE id = 2;
COMMIT;

SELECT * FROM user_bank_account;
    
    