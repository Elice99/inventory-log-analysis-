--Replace NULL Values --
SELECT *
FROM [dbo].[inventory_logs];

--Removing duplicate inventory

WITH duplicates AS ( 
	SELECT *, ROW_NUMBER() OVER(PARTITION BY [log_id] 
	ORDER BY [product_id]) AS RN
	FROM [dbo].[inventory_logs]
)
DELETE FROM duplicates WHERE RN > 1;

/*I Decided to use VIEW so as not to temper with my original dataset,
and i pick out the columns i think is important for our analysis*/
CREATE VIEW v_inventorylogz AS 
SELECT [log_id],[product_id],
CAST([timestamp] AS DATE) AS log_date,
CAST([timestamp] AS TIME) AS log_time,
YEAR([timestamp]) AS Log_Year,
lower([change_type]) AS Change_type,
[quantity_changed],
[stock_after_change],
		CASE
		WHEN [stock_after_change] < 0 THEN 'Nagative stock'
		WHEN [stock_after_change] = 0 THEN 'Out of stock'
		WHEN [stock_after_change] > 0 THEN 'In stock'
		ELSE 'Unkown'
	END AS stock_after_changes,
	CASE
		WHEN [timestamp] IS NULL THEN 'No Date Recorded'
		ELSE FORMAT([timestamp],'MMM')
	END AS Short_month,
	CASE
		WHEN [timestamp] IS NULL THEN 'No Day Recorded'
		ELSE FORMAT([timestamp],'ddd')
	END AS Day_of_week,
	CASE
		WHEN [timestamp] IS NULL THEN 'No Time Recorded'
		ELSE FORMAT([timestamp],'tt')
	END AS AM_PM
FROM [dbo].[inventory_logs]

--Removing duplicate Product_review--
WITH duplicates AS ( 
	SELECT *, ROW_NUMBER() OVER(PARTITION BY [review_id] 
	ORDER BY [product_id]) AS RN
	FROM [dbo].[product_reviews]
)
DELETE FROM duplicates WHERE RN > 1;

-- Lable ratings into category--
CREATE VIEW v_product_review AS
SELECT [review_id],[product_id],[rating],
	CASE
        WHEN [rating] < 2.0 THEN 'Very Poor'
        WHEN [rating] < 2.5 THEN 'Poor'
		WHEN [rating] < 3.0 THEN 'Fair'
        WHEN [rating] < 3.5 THEN 'Average'
        WHEN [rating] < 4.5 THEN 'Good'
		WHEN [rating] > 4.5 THEN 'Excellent'
        ELSE 'Not Rated'
    END AS ratings
FROM [dbo].[product_reviews];


CREATE VIEW v_product AS
--Standardize the Change_type column--
SELECT [product_id],[supplier_id],[brand_name],LOWER([product_name]) AS Product_name, LOWER([category]) AS Category
FROM [dbo].[products];

CREATE VIEW v_suppliers AS
SELECT
	[supplier_id],[supplier_name],[contact_person],[country]
	FROM [dbo].[suppliers];


	
				--ANALYSIS--

	-- total inventory changes per product--
select [product_id], count(*) as total_Changes
from v_inventorylogz
group by [product_id]
order by total_Changes desc

	--manual adjustments per product--
select [product_id], count(*) as total_manual_adj
from v_inventorylogz
where [change_type] = 'inventory_adjustment_manual'
group by [product_id]
order by total_manual_adj desc

	-- stockouts per product--
select [product_id], count(*) as total_stockout
from v_inventorylogz
where [stock_after_change] <= 0
group by product_id
order by total_stockout desc

	-- inventory change by date-- 
select cast(log_date as date) as change_date, count(*) as log_daily_chng
from v_inventorylogz
group by cast(log_date as date)
order by change_date;

	-- time-based pattern--
select datepart ( hour, log_time) as change_time, count(*) as log_hourly_chng
from v_inventorylogz
group by datepart(hour, log_time)
order by change_time;

select *
from [dbo].[inventory_logs]

