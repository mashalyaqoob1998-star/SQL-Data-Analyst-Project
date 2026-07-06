select * from [BlinkIT Grocery Data]
Select COUNT (*) from [BlinkIT Grocery Data]

update [BlinkIT Grocery Data]
SET Item_Fat_Content=
case
WHEN Item_Fat_Content in ('fat','LF') then 'Low Fat'
when Item_Fat_Content= 'reg' then 'Regular'
else Item_Fat_Content
end

select distinct(Item_Fat_Content) from [BlinkIT Grocery Data]

--KPI
-- The overall revenue generated from all items sold.

SELECT
CAST (SUM ( TOTAL_SALES)/1000000 AS DECIMAL (10,2)) AS Total_sales_Millions
FROM [BlinkIT Grocery Data]

--The average revenue per sale.

select
round (avg(TOTAL_SALES),2) as Average_Revenue
from [BlinkIT Grocery Data]

--The total count of different items sold.
select distinct
item_type,
Count (total_sales) as count_sold
from [BlinkIT Grocery Data]
group by item_type

--total number of items
select count (*) as no_of_items from [BlinkIT Grocery Data]

--The average customer rating for items sold. 

select
round(Avg(Rating),2) as Avg_Rating
from [BlinkIT Grocery Data]

--1. Total Sales by Fat Content
--Objective: Analyze the impact of fat content on total sales.
--Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.

select
item_fat_content,
round (sum(total_sales)/1000,2) as total_sales_by_Fat_thousands,
round (avg(TOTAL_SALES),2) as Average_Revenue,
count (*) as no_of_items,
round(Avg(Rating),2) as Avg_Rating
from [BlinkIT Grocery Data]
group by item_fat_content
order by total_sales_by_Fat_thousands desc


--Total Sales by Item Type:
--Objective: Identify the performance of different item types in terms of total sales.
--Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with item type.

select
item_type,
round (sum (total_sales) , 2) as total_sales,
round (avg(TOTAL_SALES),2) as Average_Revenue,
count (*) as no_of_items,
round(Avg(Rating),2) as Avg_Rating
from [BlinkIT Grocery Data]
group by item_type
order by total_sales desc

--Fat Content by Outlet for Total Sales:
--Objective: Compare total sales across different outlets segmented by fat content.
--Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.

select
Outlet_location_Type,
item_fat_content,
round (sum (total_sales) , 2) as total_sales,
round (avg(TOTAL_SALES),2) as Average_Revenue,
count (*) as no_of_items,
round(Avg(Rating),2) as Avg_Rating
from [BlinkIT Grocery Data]
group by outlet_location_type,item_fat_content
order by total_sales desc

--second type 
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM [BlinkIT Grocery Data]
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;


--Total Sales by Outlet Establishment:
--Objective: Evaluate how the age or type of outlet establishment influences total sales.
select
Outlet_Establishment_Year,
round (sum (total_sales) , 2) as total_sales,
round (avg(TOTAL_SALES),2) as Average_Revenue,
count (*) as no_of_items,
round(Avg(Rating),2) as Avg_Rating
from [BlinkIT Grocery Data]
group by Outlet_Establishment_Year
order by total_sales desc

--Percentage of Sales by Outlet Size:
--Objective: Analyze the correlation between outlet size and total sales.

SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM [BlinkIT Grocery Data]
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;
--All Metrics by Outlet Type:

SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM [BlinkIT Grocery Data]
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC

--Sales by Outlet Location:
SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM[BlinkIT Grocery Data]
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC









