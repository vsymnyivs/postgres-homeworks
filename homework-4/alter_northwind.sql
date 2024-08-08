-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_products_price CHECK (unit_price > 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0, 1))

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
--Первый вариант
CREATE TABLE discontinued_products (product_name varchar NOT NULL, discontinued int);
INSERT INTO discontinued_products SELECT product_name, discontinued FROM products WHERE discontinued=1
--Второй вариант
SELECT product_name, discontinued INTO discontinued_top FROM products WHERE discontinued = 1
--Третий вариант
SELECT * INTO discontinued_pr FROM products WHERE discontinued = 1

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products,
ADD  CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE;
