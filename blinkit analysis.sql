select *from blinkit_data;

-- Basic Analysis Questions (Fundamentals)
-- 1.	Total Sales: What is the total revenue from all sales?
select round(sum(Sales),2) as `Total Revenue` from blinkit_data;

-- 2.	Total Items Sold: How many unique items are there?-- 
select count(Distinct `Item Identifier`) as `Total Items Sold` from blinkit_data;

-- 3.	Sales by Item Type: What is the total sales revenue for each item type?
select `Item Type`,round(sum(Sales),2) as `Total Sales` 
from blinkit_data 
group by `Item Type` 
order by `Total Sales` desc;

-- 4.	Average Rating of Products: What is the overall average rating of all items?
select round(Avg(Rating),1) as `Average Rating` from blinkit_data;

-- 5.	Average Sales per Item Type
select `Item Type`,round(avg(Sales),2) as Average
from blinkit_data 
group by `Item Type`
order by Average desc;

-- Intermediate Analysis Questions (Trends & Comparisons)
-- 1.	Sales Trend by Year: How do total sales vary by the establishment year of the outlet?
select `Outlet Establishment Year`,round(sum(Sales),2) as `Total Sales` 
from blinkit_data 
group by `Outlet Establishment Year`;

-- 2.	Sales by Location Type: Which outlet location type (Tier 1, Tier 2, Tier 3) generates the most sales?
select `Outlet Location Type`,round(sum(Sales),2) as `Most Sales`  
from blinkit_data 
group by `Outlet Location Type` 
order by `Most Sales` desc limit 1;

-- 3.	Top 5 Highest Selling Items: Which individual items have the highest sales?
select `Item Type`,round(sum(`Sales`),2) as `Highest Sales`  
from blinkit_data 
group by `Item Type` 
order by `Highest Sales` desc limit 5;

-- 4.	Sales by Outlet Size: Does outlet size (Small, Medium, High) affect sales performance?
select `Outlet Size`,round(sum(Sales),2) as `Sales Performance` 
from blinkit_data 
group by `Outlet Size` 
order by `Sales Performance` desc ; 
-- 5.	Effect of Shelf Visibility on Sales Across Different Locations
select `Outlet Location Type`,round(avg(`Item Visibility`),2) as visibility ,round(sum(Sales),2) as sales
from blinkit_data 
group by `Outlet Location Type`
order by sales desc;

-- Advanced Analysis Questions (Deep Insights & Predictions)
-- 1.	Which Outlet Type Generates the Most Revenue?
select `Outlet Type`,round(sum(Sales),2) as `Most Revenue` 
from blinkit_data 
group by `Outlet Type` 
order by `Most Revenue` desc limit 1;

-- 2.	Finding the Most Profitable Item Type per Outlet Type
select `Item Type`,`Outlet Type`,round(sum(Sales),2) as `Most Profitable Item` 
from blinkit_data 
group by `Item Type`,`Outlet Type`
order by `Most Profitable Item` desc limit 10;

-- 3.	Correlation Between Visibility and Sales: Do items with higher visibility have higher sales?
select 
case when `Item Visibility` <0.05 then 'Low Visibility'
when `Item Visibility` between 0.05 and 0.15 then 'Medium Visibility' 
else 'High  Visibility' end as 'Visibility',round(sum(Sales),2) as `sales per Visibility`
from blinkit_data 
group by `Visibility`
order by `sales per visibility` desc; 

-- 4.	Which Item Fat Content Category Sells the Most?
select `Item Fat Content`,round(sum(Sales),2) as `Most Sales`
from blinkit_data 
group by `Item Fat Content`
order by `Most Sales` desc limit 1;

-- 5.	Finding the Most Consistent High-Rating Outlets
select avg(Rating) as Ratings,`Outlet Identifier`
from blinkit_data 
group by `Outlet Identifier`
order by Ratings desc limit 10; 

-- 6.	Percentage of sales by outlet size
select `Outlet Size`,round((sum(sales)/(select sum(sales) from blinkit_data))*100,2) as Percentage from blinkit_data 
group by `Outlet Size` 
order by Percentage desc;

-- 7.	Predicting Sales Trends
select `Outlet Establishment Year` , round(sum(Sales),4) as sales 
from blinkit_data
group by `Outlet Establishment Year`
order by sales desc;

-- 8.	Outlets performance Based on Sales Performance
select `Outlet Identifier`, round(sum(Sales),2) as Sales,
case 
when round(sum(Sales),2) > 500000 then "High Performer"
when round(sum(Sales),2) between 250000 and 500000 then "Medium Performer"
else "Low Performer"
end as `Outlet Performance`
from blinkit_data 
group by `Outlet Identifier`
order by Sales desc;
