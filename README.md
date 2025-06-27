# inventory-log-analysis & Dashboard Project
This project focuses on analyzing inventory logs for monitoring inventory adjustments, stock-outs, product-level trends, and supplier activities. This dashboard empowers stakeholders to identify inefficiencies, reduce stockout rates, and improve inventory management processes.

## Objectives
To gain insights from raw inventory logs and create a dynamic PowerBI dashboard that Highlights:
   - Total Out of stock
   - Manual adjustments
   - Stock movement trend
   - Product Performance

## Dataset Overview
  The dataset includes:
   - InventoryLog
     - 'log_id' Unique identifier for the logs
     - 'product_id' Unique identifier for the product
     - 'timestamp' Raw date and time of the inventory transaction (consisting of Null Values)
     - 'change type'
     - 'quantity changed'
     - 'stock after change'
     - 'log note'
  - Product Review
     - 'review_id'
     - 'product_id'
     - 'customer_id'
     - 'reviewers name'
     - 'rating'
     - 'review title'
     - 'review text'
     - 'review date'
     - 'is_verified_purchase'
     - 'helpfuness_vote'
  - Product
     - 'product_id'
     - 'is_popular_product
     - 'brand name'
     - 'product name'
     - 'category'
     - 'supplier_id'
     - 'description'
     - 'base price'
     - 'currency'
     - 'product attribute'
     - 'unit of measure'
     - 'stock quantity'
     - 'date added'
     - 'last updated date'
     - 'is_active'
  - Suppliers
     - 'suppliers_id'
     - 'suppliers name
     - 'contact person'
     - 'supplier email'
     - 'supplier phone'
     - 'supplier address'
     - 'country'
     - 'supplier registration date'
     - 'preferred supplier'     
    


## ⚙️ Tools & Skills Applied

| Tool                        | Purpose                                   |
|-----------------------------|-------------------------------------------|
| **SQL**                     | Data cleaning, transaformation and initial analysis |
|   **PowerBI** Power Query               | Data type correction, Column renaming, and new calculated columns     |
|   **PowerBI** Data Modeling               | Defined relationships between tables     |
|   **PowerBI** DAX               | Created custom measures (e.g out of stock rate, adjustment count etc)     |


## 🧹 Data Processing Workflow


1. **📂SQL Cleaning & Preprocessing**
   - Removed duplicates
   - Standardize date and time formats
   - Segregated date parts ( 'Year', 'Month' 'Day' 'AM/PM')
   - Identified null values and cleaned inconsistencies
   - Standardize change type and derived stock after change
   - Categorized numerical ratings into human-readable labels
   - Normalize text case for consistency in product_name and category
   - Calculated `Total Inventory Changes per Product`, `Manual Adjustments per Product`, and `Stockouts per Product`,`Inventory Changes by Date`,`Time-Based Inventory Patterns` 

All data transformation steps were written in SQL and are available here:

👉 [data_cleaning_and_analysis.sql]E_com inventoryLog.sql

  

3. **Loading into Power BI**
   - Imported cleaned SQL views or queries
   - Created DAX measures like:
     - `Stockout Rate (%)`
     - `Total Manual Adjustments`
     - `Daily Stock-Out Count`

---

## 🔍 Key Visuals

| Visual                          | Description |
|----------------------------------|-------------|
| **Total Out of Stock**           | Card showing all stock-out events detected |
| **Manual Adjustments Tracker**   | By product and supplier |
| **Out-of-Stock Trends**          | Line chart with YoY breakdown |
| **Top Products by Stock-Outs**   | Products with most stock-out events |
| **Geographic Heatmap**           | Change events by country |

---
## 📊 Dashboard Overview

Built for warehouse and supply chain teams to:

- Identify high-risk products with recurring stock-outs
- Monitor manual adjustment trends
- Analyze change events by supplier, country, and brand
- Understand year-on-year stock-out trends

(<img width="638" alt="Screenshot 2025-06-27 111849" src="https://github.com/user-attachments/assets/84e69621-2416-4f48-9b17-594810b9de89" />
)


## 🧠 Business Questions Answered

- What products are most frequently out of stock?
- Which suppliers trigger the most manual adjustments?
- Are stock-outs increasing year over year?
- Which categories or countries require deeper audit?

---

## 📁 Repository Structure



