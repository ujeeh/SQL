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

-- make the product id in the sales table the foreign key linked to the products table
alter table Sales
add foreign key (product_id) references Products (product_id);

select * from Sales;

select * from Products;

-- retrieve the product name and unit price from products table
select product_name, unit_price from Products;

-- retrieve the sale id and sale date from sales table
select sale_id, sale_date from Sales;

-- filter the sales table to show sales with total price greater than 100
select * from Sales
where total_price > 100;

-- filter the products table to show products only in the Electronics category
select * from products
where category = 'Electronics';

-- retrieve the sale id and total price for sales made on january 3, 2024 from the sales table
select sale_id, total_price from Sales
where sale_date = '2024-01-03';

-- retreive the product id and product name from product table with unit price greater than 100
select product_id, product_name from Products
where unit_price > 100;

-- calculate the total revenue generated from all sales in Sales
select sum(total_price) total_revenue from Sales;

-- calculate the average unit price of products in the products table
select avg(unit_price) avg_unit_price from Products;

-- calculate the total quantity sold from the sales table
select sum(quantity_sold) total_quantity_sold from Sales;