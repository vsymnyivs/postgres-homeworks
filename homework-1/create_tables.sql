-- SQL-команды для создания таблиц
create table orders
(
	order_id int primary key,
	customer_id varchar(100) references customers(customer_id),
	employee_id int references employees(employee_id),
	order_date DATE not null,
	ship_city varchar(100) not null
)

create table customers
(
	customer_id varchar(5) primary key,
	company_name varchar(100) not null,
	contact_name varchar(100) not null
)

create table employees
(
	employee_id int primary key,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	title varchar(100) not null,
	birth_date date not null,
	notes_user text
)
