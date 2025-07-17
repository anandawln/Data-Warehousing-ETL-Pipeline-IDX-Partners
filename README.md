# Client-Focused Data Warehouse and ETL Workflow with Talend & T-SQL Procedures

<div align="center">
<img width = "80%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/talend%20etl.drawio.png">
</div>

## 🏗️ Data Warehouse & ETL Project: ID/X Partners Banking Client

This project delivers an end-to-end **Data Warehouse and ETL pipeline** for a banking client of **ID/X Partners**, integrating data from multiple disparate sources using **Talend Open Studio** and **Microsoft SQL Server**. It also includes dynamic **Stored Procedures** to support on-demand reporting and analysis.

---

## 🚀 Project Objectives

- Consolidate fragmented data sources (Excel, CSV, and SQL Server databases) into a centralized **Data Warehouse (DWH)**.
- Ensure accurate, deduplicated transaction data for reporting.
- Automate data extraction and transformation using **Talend ETL jobs**.
- Create robust **stored procedures** to provide real-time business insights.

---

## 🗂️ Data Sources

- `transaction_excel` — Excel file
- `transaction_csv` — CSV file
- `transaction_db` — SQL Server table
- `account`, `customer`, `branch`, `city`, `state` — SQL Server tables

---

## 🧱 Data Warehouse Schema
### Create a Data Warehouse & Restore Sample Database
- The first step is to restore the `sample.bak` database into the SQL Server and then create a database for the data warehouse with the name `DWH`.

<div align="center">
<img width = "30%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/DWH.png">
</div>

### Dimensions
- `DimAccount`
- `DimCustomer`  
  Fields include: `CustomerID`, `CustomerName`, `Address`, `CityName`, `StateName`, `Age`, `Gender`, `Email`  
  ✨ Note: All string fields are capitalized (except `CustomerID`, `Age`, and `Email`) using **PascalCase** conventions.
- `DimBranch`

<div align="center">
<img width = "50%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/erd_dwh.png">
</div>

### Fact

- `FactTransaction`  
  Consolidates rows from `transaction_excel`, `transaction_csv`, and `transaction_db`.  
  ✅ Ensures **no duplicates** are inserted.

---

## ⚙️ ETL Implementation
### Built using Talend Open Studio
- Extracts and transforms raw data into dimension tables.
- Combines multi-source transaction records into the Fact table.
- Applies logic to transform and standardize data formats.
- Uses deduplication components (`tUniqRow`) to maintain integrity.
  
### Create a Connection between Talend Studio and SQL Server
- Create database connections in metadata for `sample` and `DWH` databases
<div align="center">
<img width = "50%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/connect_talend.png">
</div>

- Below is the display if successfully connected to the SQL Server database. Make sure to create a job design for each table in the DWH database.

<div align="center">
<img width = "50%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/data_job.png">
</div>

- Before doing the DimCustomer job, we need to configure the tMap component first.
<div align="center">
<img width = "70%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/konfig_cust.png">
</div>

- Here is the Job ETL view to move data to the DimCustomer table
<div align="center">
<img width = "50%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/dimcustomer.png">
</div>

- The next step is to do an ETL Job for DimAccount and DimBranch, below is evidence that the job was successfully executed
<p align="center">
  <img src="https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/dimacc.png" width="45%"/>
  <img src="https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/dimbranch.png" width="45%"/>
</p>

- Before doing a job for FactTransaction, we must configure metadata for excel and csv files.
<p align="center">
  <img src="https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/konf_csv.png"width="48%"/>
  <img src="https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/konf_excel.png" width="45%"/>
</p>

- Make sure the settings are as below, where the data type needs to be considered and all columns are entered
<p align="center">
  <img src="https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/meta_csv.png" width="30%"/>
  <img src="https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/meta_excel.png" width="45%"/>
</p>

- Here is the FactTransaction ETL Job
<div align="center">
<img width = "50%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/facttransaction.png">
</div>

---

## 🧠 Stored Procedures

### 1. `DailyTransaction`
Returns total transactions and amounts by date.  
**Parameters**: `start_date`, `end_date`  
**Output**: `Date`, `TotalTransactions`, `TotalAmount`

- The following is a query to form Store Procedure DailyTransactions
<div align="center">
<img width = "70%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/pro_daily.png">
</div>

### 2. `BalancePerCustomer`
Calculates current balance for a selected customer.  
**Logic**:
- `Deposit` increases balance
- Other transaction types decrease it
- Filters only **active accounts**
**Parameter**: `name` (Customer name)  
**Output**: `CustomerName`, `AccountType`, `Balance`, `CurrentBalance`

- The following is a query to form Store Procedure BalancePerCustomer
<div align="center">
<img width = "70%" src = "https://github.com/anandawln/IDX-Partners-Data-Engineer/blob/main/assets/pro_balance.png">
</div>

---

## 💼 Tech Stack

- **Talend Open Studio**
- **Microsoft SQL Server**
- **T-SQL (Stored Procedures)**
- **Excel & CSV Processing**

---



