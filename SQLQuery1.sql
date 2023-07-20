select *
from pizza_sales

--Total Revenue
select SUM(total_price) as Total_Revenue
from pizza_sales

--Average order value = Avg amount spent per order
select SUM(total_price)/COUNT(distinct order_id) as Average_Order_value
from pizza_sales

--Total pizza sold
select SUM(quantity) as Total_Pizza_Sold
from pizza_sales

--Total orders placed
select COUNT(distinct order_id) as Total_Orders_Placed
from pizza_sales

--Average Pizzas per order = Total no. of pizzas/Total orders
select cast(SUM(quantity) as decimal(10,2))/cast(COUNT(distinct order_id) as decimal(10,2)) as Avg_Pizzas_per_Order
from pizza_sales

--Daily trend for total orders
select DATENAME(dw,order_date) as Order_Day, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME(dw,order_date)

select DATENAME(MONTH,order_date) as Order_Day, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME(MONTH,order_date)

--Hourly trend
select DATEPART(hour, order_time) as Order_Hour, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATEPART(hour, order_time)
order by DATEPART(hour, order_time)

--Sales percentage per pizza category
select pizza_category, sum(total_price) as Total_Sales, SUM(total_price)*100/(select SUM(total_price) from pizza_sales where MONTH(order_date)=1) as PricePrcnt_per_Category
from pizza_sales
where MONTH(order_date)=1 --For Jan month
group by pizza_category

select pizza_category, sum(total_price) as Total_Sales, SUM(total_price)*100/(select SUM(total_price) from pizza_sales) as PricePrcnt_per_Category
from pizza_sales
group by pizza_category
order by PricePrcnt_per_Category

--Sales percentage per pizza size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Sales, cast(SUM(total_price)*100/(select SUM(total_price) from pizza_sales) as decimal(10,2)) as PricePrcnt_per_Category
from pizza_sales
group by pizza_size
order by PricePrcnt_per_Category desc

--Total pizzas sold by pizza category
select pizza_category, SUM(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_category

--Top 5 best selling pizza names
select top 5 pizza_name, SUM(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_name
order by SUM(quantity) desc

--Top 5 worst selling pizza names
select top 5 pizza_name, SUM(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_name
order by SUM(quantity) 