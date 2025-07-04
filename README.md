
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
👉 [`sql_scripts/data_cleaning_and_analysis.sql`](./sql_scripts/data_cleaning_and_analysis.sql)

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
-- Top products by manual inventory adjustments
SELECT product_id, COUNT(*) AS total_manual_adj
FROM v_inventorylogz
WHERE change_type = 'inventory_adjustment_manual'
GROUP BY product_id
ORDER BY total_manual_adj DESC;

-- Stockouts per product
SELECT product_id, COUNT(*) AS total_stockout
FROM v_inventorylogz
WHERE stock_after_change <= 0
GROUP BY product_id
ORDER BY total_stockout DESC;
````

For full SQL logic, see:
📄 [`sql_scripts/data_cleaning_and_analysis.sql`](./sql_scripts/data_cleaning_and_analysis.sql)


## 📈 Power BI Dashboard

![Dashboard Screenshot](./powerbi/dashboard_screenshot.png)

### 📌 Visualizations Include:

* **Bar Charts**: Top products by manual adjustments
* **Line Charts**: Stockout trend over years
* **Map**: Inventory change events by country
* **Card Visuals**: Stockout rate, total manual adjustments
* **Slicers**: Month, Year, Product, Supplier

### 🧮 Sample DAX Measures

```DAX
StockoutRate = 
DIVIDE(
    COUNTROWS(FILTER(v_inventorylogz, v_inventorylogz[stock_after_change] <= 0)),
    COUNTROWS(v_inventorylogz)
)
```


## 📊 Key Business Insights

| Metric                      | Top Performer or Issue Area     | Actionable Insight                                     |
| --------------------------- | ------------------------------- | ------------------------------------------------------ |
| Most Adjusted Product       | `anderson-filing-cabinet`       | Review supplier or stocking policy                     |
| Top Supplier by Adjustments | `James G.` (373 manual changes) | Investigate delivery errors or forecast mismatches     |
| Year with Stockout Spike    | 2025 (20+ stockouts)            | Suggests growing demand or poor replenishment strategy |
| Peak Inventory Change Hour  | Between 6 PM – 10 PM            | Warehouse operations may need to shift resource timing |


## 📁 Project Structure

Inventory-Stock-Analysis-SQL-PowerBI/
├── sql_scripts/

│   └── data_cleaning_and_analysis.sql

├── powerbi/

│   └── dashboard_screenshot.png

├── README.md



## 👨‍💻 Author

**Elisha Bassey**

Data Analyst | SQL | Power BI | Data Transformation

📫 [LinkedIn](#) | [Portfolio](#) | [Email](#)


