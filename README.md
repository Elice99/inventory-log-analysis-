
# 📦 Inventory Stock Analysis (SQL + Power BI)

This project demonstrates an end-to-end data analytics pipeline—from raw data cleaning in SQL to interactive business insights via Power BI. The goal is to track inventory adjustments, stockouts, and supplier performance for improved stock management.


## 🧰 Tools Used

- **SQL Server**: Data cleaning, transformation, and analysis
- **Power BI**: Data modeling and interactive dashboarding
- **GitHub**: Version control and project documentation


## 📌 Project Objective

To transform raw warehouse inventory logs and product reviews into clean, usable datasets using SQL and generate actionable insights with Power BI visualizations. This enables decision-makers to monitor product stock levels, identify manual adjustment patterns, and assess supplier reliability.


## 🗃️ Dataset Overview

### 🔹 Raw Tables
- `inventory_logs`: Contains timestamped records of inventory changes
- `products`: Metadata including product name, brand, category, supplier
- `product_reviews`: Customer ratings for products
- `suppliers`: Supplier details (name, contact, country)

### 🔸 Key Issues Identified
- Inconsistent timestamp formats
- Duplicate records in `inventory_logs` and `product_reviews`
- Non-standardized categorical fields (`stock_status`, `change_type`)
- Null values in key columns


## 🧹 Data Cleaning & SQL Transformation

Key cleaning and transformation steps are documented in:
👉 [`sql_scripts/data_cleaning_and_analysis.sql`](./sql_scripts/ecom_inventory.sql)

### ✅ Highlights

- Removed duplicates using `ROW_NUMBER()` and CTEs
- Created SQL **Views** (not tables) to preserve raw data
- Extracted date, time, year, and AM/PM info from timestamps
- Categorized stock status (`In stock` and `Out of stock`)
- Labeled product ratings (`Very Poor` → `Excellent`)
- Standardized lowercase formatting for product and category names

### 📂 Views Created

| View Name           | Description                                      |
|---------------------|--------------------------------------------------|
| `v_inventorylogz`    | Cleaned inventory log with timestamp breakdown   |
| `v_product_review`   | Product reviews with rating labels               |
| `v_product`          | Product metadata with normalized names/categories|
| `v_suppliers`        | Supplier directory with country/location info    |


## 📊 Analysis Performed in SQL

Sample queries include:

```sql
--manual adjustments per product--
SELECT [product_id], count(*) as total_manual_adj
FROM v_inventorylogz
WHERE [change_type] = 'inventory_adjustment_manual'
GROUP BY [product_id]
ORDER BY total_manual_adj desc

-- stockouts per product--
SELECT [product_id], count(*) as total_stockout
FROM v_inventorylogz
WHERE [stock_after_change] <= 0
GROUP BY product_id
ORDER BY total_stockout desc
````

For full SQL logic, see:
📄 [`sql_scripts/data_cleaning_and_analysis.sql`](./sql_scripts/ecom_inventory.sql)


## 📈 Power BI Dashboard

![Dashboard Screenshot](./powerbi/savvyEcomdashboard.png)

### 📌 Visualizations Include:

* **Bar Charts**: Top products by manual adjustments
* **Line Charts**: Stockout trend over years
* **Map**: Inventory change events by country
* **Card Visuals**: Stockout rate, total manual adjustments
* **Slicers**: Month, Year, Product, Supplier

### 🧮 Sample DAX Measures

```DAX
stockout rate(%) = 
VAR TotalLog = COUNTROWS('vw_inventory_log')
VAR OutofStocks = CALCULATE(COUNTROWS('vw_inventory_log'),'vw_inventory_log'[stock_after_changes] = "Out of stock")
RETURN
DIVIDE(OutofStocks, TotalLog)*100
```


## 📊 Key Business Insights

| Metric                      | Top Performer or Issue Area                | Actionable Insight                                     |
| --------------------------- | ------------------------------------------ | ------------------------------------------------------ |
| Most Adjusted Product       | `anderson-Wagnar-Organizer 13828264`       | Review supplier or stocking policy                     |
| Top Supplier by Adjustments | `James Garcia II.` (373 manual changes)    | Investigate delivery errors or forecast mismatches     |
| Year with Stockout Spike    | 2025 (20+ stockouts)                       | Suggests growing demand or poor replenishment strategy |
| Top Product by Out of stock | galvan-schneider-watch-score210            | Increase Inventory Reorder Levels                      |


## 📁 Project Structure

Inventory-Stock-Analysis-SQL-PowerBI/
├── sql_scripts/

│   └── data_cleaning_and_analysis.sql

├── powerbi/

│   └── dashboard_screenshot.png

├── README.md



## 👨‍💻 Author

# Elisha Bassey 

**Data Analyst | SQL | Power BI | Data Visualization**  

📫 Email: [basseyelisha99@gmail.com](mailto:basseyelisha99@gmail.com)  
🔗 LinkedIn: [linkedin.com/in/elisha-bassey](https://www.linkedin.com/in/elisha-bassey)  
🌐 Portfolio: [elice99.github.io/Portfolio](https://elice99.github.io/Portfolio)

