-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select customers.company_name AS customer, CONCAT(first_name, ' ', last_name) as employee
from orders
inner join employees using(employee_id)
inner join customers using(customer_id)
inner join shippers on shippers.shipper_id=orders.ship_via
where customers.city='London' and employees.city='London' and shippers.company_name='United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select products.product_name, units_in_stock, contact_name, phone
from products
inner join suppliers using(supplier_id)
inner join categories using(category_id)
where discontinued=0 and category_name in ('Dairy Products', 'Condiments') and units_in_stock< 25
order by 2 ASC

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name from orders
full join customers using(customer_id)
where order_date is null
order by company_name

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
