create table Sales (
sale_id int primary key,
product_id int,
quantity_sold int,
sale_date date,
total_price decimal(10,2)
);

insert into Sales (sale_id, product_id, quantity_sold, sale_date, total_price)
values(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

create table Products(
product_id int primary key,
product_name varchar(100),
category varchar(50),
unit_price decimal(10,2)
);

insert into Products (product_id, product_name, category, unit_price)
values(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

alter table Sales
add foreign key (product_id) references Products (product_id);