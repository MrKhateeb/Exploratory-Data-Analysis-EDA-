CREATE TABLE super_store (
    order_priority VARCHAR(50),
    discount NUMERIC(5, 2),
    unit_price NUMERIC(10, 2),
    shipping_cost NUMERIC(10, 2),
    customer_id INT,
    customer_name VARCHAR(100),
    ship_mode VARCHAR(50),
    customer_segment VARCHAR(50),
    product_category VARCHAR(50),
    product_sub_category VARCHAR(50),
    product_container VARCHAR(50),
    product_name VARCHAR(255),
    product_base_margin NUMERIC(5, 2),
    country VARCHAR(50),
    region VARCHAR(50),
    state_or_province VARCHAR(50),
    city VARCHAR(100),
    order_date DATE,
    ship_date DATE,
    profit NUMERIC(10, 4),
    quantity_ordered_new INT,
    sales NUMERIC(10, 2),
    order_id INT,
    order_by_month VARCHAR(50)
);

COPY super_store
FROM 'C:/Users/aquib/Desktop/Analysis_project/modified_super_store.csv'
DELIMITER ','
CSV HEADER;

select * from super_store;

-- 1 Identified the top 10 customers based on total sales.

select customer_name , sum(sales) as TopSale from super_store
group by customer_name
order by TopSale desc
limit 10 ;


-- 2 No. 1 Customer and Their Orders: Analyzed the highest-spending customer and the products they ordered.

select customer_name ,  product_name, sum(sales) as TotalSpend from super_store
group by customer_name, product_name
order by TotalSpend desc
limit 1;


-- 3 Most Profitable Category: Determined which product category generated the most profit.
SELECT * FROM super_store limit 4;

select product_category, sum(profit) as Total_Profit from super_store
group by product_category
order by Total_Profit desc


--4 Most Selling Product Sub-Category: Identified the sub-categories with the highest sales volume.
SELECT * FROM super_store limit 4;

select product_sub_category , sum(sales) as Sales_volume 
from super_store
group by product_sub_category
order by Sales_volume desc


-- 5 Most Selling Products: Analyzed which individual products are sold the most.
SELECT * FROM super_store limit 4;

select product_name ,  sum(sales) as Most_sale 
from super_store
group by product_name
order by Most_sale desc


-- 6  Category Sales by State: Explored which categories sell the most in each state.
SELECT * FROM super_store limit 4;

with Sales_by_State as (
	select state_or_province ,product_category , sum(sales) as Sale_Volume 
	from super_store
	group by state_or_province ,product_category
)
select * from Sales_by_State
order by product_category desc -- Result by CTE ; 


--7 Best Sales Month: Identified the month with the highest sales across the dataset.
SELECT * FROM super_store limit 4;

select order_by_month as Best_month , sum(sales) as Sales from super_store
group by Best_month
order by Sales desc
limit 1


--8 Least Sales Month: Determined the month with the lowest sales.

select order_by_month as least_month, sum(sales) as Sales from super_store
group by least_month
order by Sales asc
limit 1


--9 State with Most Profit: Analyzed which state generated the highest profit.
SELECT * FROM super_store limit 4;

select state_or_province as State_profit , sum(profit) as Profit from super_store
group by State_profit
order by Profit desc
limit 1



--10 State with Least Profit: Identified the state with the lowest profit.

select state_or_province as Least_profit , sum(profit) as Profit from super_store
group by Least_profit
order by Profit asc
limit 1


--11 Sales Values by Category and Sub-Category: Calculated total sales values for each category and sub-category.
select product_category as Category, product_sub_category as SubCategory, sum(sales) as TotalSales
from super_store
group by product_category, product_sub_category
order by TotalSales desc;



--12 Most Profitable Customer Segments: Analyzed which customer segments are the most profitable.
SELECT * FROM super_store limit 4;

select customer_segment , sum(profit) as profit 
from super_store
group by customer_segment
order by profit desc



--13 Most Profitable City in the Most Profitable State: Explored which city within the most profitable state generated the highest profit.
SELECT * FROM super_store limit 4;


with Most_profit_city as(
	select state_or_province , city , sum(profit) as profit
	from super_store
	group by state_or_province , city
)
select * from Most_profit_city 
order by profit desc
limit 1 


--14 Least Profitable City in the Least Profitable State: Identified the least profitable city in the least profitable state.

with least_profit_city as(
	select state_or_province , city , min(profit) as profit
	from super_store
	group by state_or_province , city
)
select * from least_profit_city 
order by profit asc
limit 1


--15 Order Count and Profit by Region: Analyzed the number of orders and profit in each region.
SELECT * FROM super_store limit 4;

select region , sum(quantity_ordered_new) as quantity , sum(profit) as profit 
from super_store
group by region 
order by profit desc , quantity desc


--16 Order Count and Profit by Priority: Explored how order priority affects the number of orders and profitability.
SELECT * FROM super_store limit 4;

select count(*), sum(profit) as profit , order_priority from super_store
group by order_priority
order by profit

'''The issue is that there are two different values for "Critical" — one with a trailing space ("Critical ") 
and the other correctly spelled ("Critical").'''

select order_priority , profit from super_store
where order_priority like 'Critical '  

'''we can clean the data by removing extra spaces in PostgreSQL with this query: '''

select count(*), sum(profit) as profit, trim(order_priority) as order_priority 
from super_store 
group by TRIM(order_priority) 
ORDER BY profit;









































































































