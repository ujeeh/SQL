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

-- count sales per day from the sales table
select sale_date, count(*) from Sales
group by sale_date
order by sale_date asc;

-- retrieve product name aand unit price from the product with the highest unit price
select product_name, unit_price from Products
order by unit_price desc
limit 1;

-- retrieve the sale id, product id and total price for sales with quantity sold greater than 4
select sale_id, product_id, total_price from Sales
where quantity_sold > 4;

-- retrieve the product name and unit price from the products table ordering the results by unit price in descending order
select product_name, unit_price from Products
order by unit_price desc;

-- retrieve the total price of all sales, rounding the values to two decimal places
select round(sum(total_price), 2) total_sales from Sales;

-- calculate the average total_price of sales in Sales table
select avg(total_price) average_total_price from Sales;

-- retrieve the sale id and date formatting the sales date as YYYY-MM-DD
select sale_id, date_format(sale_date, '%Y-%d-%m') formatted_date from sales;

-- calculate the total revenue generated from sale of electronic products
select sum(sales.total_price) total_revenue from sales
join products on sales.product_id = products.product_id
where products.category = 'Electronics';

-- retrieve the product name and unit price from the products table filtering the unit price to show only values betwee 20 and 600
select products.product_name, products.unit_price from products
where unit_price between 20 and 600;

-- retrieve the product name and category from products table, in ascending order of category
select products.product_name, products.category from products
order by category asc;

-- Intermediate level Exercises
-- calculate total quantity sold of electronic products
select sum(sales.quantity_sold) total_quantity_sold from sales
join products on sales.product_id = products.product_id
where products.category = 'Electronics';

-- retreive the product name and total price, calculating total price as quantity sold multiplied by unit price
select products.product_name, sales.quantity_sold * products.unit_price as total_price from sales
join products on sales.product_id = products.product_id;

-- identify the most frequently sold product from sales table
select products.product_name, count(*) sales_count from sales
join products on sales.product_id = products.product_id
group by product_name
order by sales_count desc
limit 1;

-- find products not sold from products table
select * from products
where product_id not in (select distinct product_id from sales);

-- calculate the total revenue generated from sales for each category
select products.category, sum(sales.total_price) total_revenue from products
join sales on sales.product_id = products.product_id
group by category;

-- find the product category with the highest average unit price
select category from products
group by category
order by avg(unit_price) desc
limit 1;

-- identify products with total sales exceeding 30
select products.product_name from products
join sales on sales.product_id = products.product_id
group by product_name
having sum(total_price) > 30;

-- count the number of sales made each month
select date_format(sales.sale_date, '%y-%m') as month, count(*) sales_count from sales
group by month;

-- retrieve sales details for products having smart in their name
select sales.sale_id, products.product_name, sales.total_price from sales
join products on sales.product_id = products.product_id
where product_name like '%smart%';

-- determine the average quanity sold for products with unit price greater than 100
select products.product_name, avg(sales.quantity_sold) average_quantity_sold from products
join sales on sales.product_id = products.product_id
where products.unit_price > 100
group by product_name;

-- retrieve the product name and total sales revenue for each product
select products.product_name, sum(sales.total_price) total_revenue from products
join sales on sales.product_id = products.product_id
group by product_name;

-- list all sales with corresponding product name
select sales.sale_id, products.product_name from sales
join products on products.product_id = sales.product_id;

-- retrieve the product name and total revenue for each product
select products.product_name, sum(sales.total_price) total_revenue from products
join sales on sales.product_id = products.product_id
group by product_name
order by total_revenue desc;

-- retrieve product name, total revenue and percentage of total revenue for each product
select products.product_name, sum(sales.total_price) total_revenue, 
round(
(sum(sales.total_price)* 100) / (select sum(total_price) from sales),
2) percentage_of_sales_revenue from products
join sales on sales.product_id = products.product_id
group by product_name
order by percentage_of_sales_revenue desc;

-- rank products based on total sales revenue
select products.product_name, sum(sales.total_price) total_revenue, 
rank () over (order by sum(sales.total_price) desc) revenue_rank from products
join sales on sales.product_id = products.product_id
group by product_name;

-- calculate the running total revenue for each product category
select products.category, products.product_name, sales.sale_date, 
sum(sales.total_price) over (partition by products.category order by sales.sale_date) running_total_revenue
from products
join sales on sales.product_id = products.product_id;

-- categorize sales as high, medium or low based on total price
select sales.sale_id,
case
	when total_price > 200 then 'High'
    when total_price between 100 and 200 then 'Medium'
    else 'Low'
    end as sales_category
from sales;

-- identify sales where the quantity sold is greater than the average quantity sold
select * from sales
where quantity_sold > (select avg(quantity_sold) from sales);

-- extract the month and year from the sale date and count the number of sales for each month
select concat(year(sale_date), '-', lpad(month(sale_date), 2, '0')) as month, count(*) sales_count 
from sales
group by month;

-- calculate the number of days between the current date and sale date for each sale
select sales.sale_id, datediff(now(), sale_date) days_since_sale from sales;

-- identify sales made during weekdays versus weekends
select sales.sale_id,
case
	when dayofweek(sale_date) in (1, 7) then 'Weekend'
    else 'Weekday'
    end as day_type
from sales;