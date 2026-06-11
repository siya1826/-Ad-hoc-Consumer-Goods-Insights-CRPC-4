# Consumer-Goods-Ad-hoc-Insights

## About Company :
Atliq Hardware is a leading computer hardware manufacturer based in India, with a strong global presence across 26 countries. The company specializes in three major product divisions: Peripherals & Accessories, PC, Networking & Storage.

With a diverse customer base of 74 clients—including prominent names like Neptune, Sage, Leader, and Vijay Sales—Atliq Hardware serves markets worldwide.

Recently, the management identified a need for deeper, faster insights into sales and performance data to support agile, data-informed decision-making. This has led to the initiation of a data analytics project aimed at transforming raw sales data into actionable intelligence through SQL analysis and visualization.

---

## Company Product Structure, Platform & Market Channel :

---

## Dataset View :

* Fiscal year for AtliQ Hardware :- 1st September to 31st August
* Sales data is available for fiscal year 2020-2021

---

## Ad-hoc Requests & its Solutions :

### 1.Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

  ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

---

* AtliQ Exclusive operates its business in 8 markets of Asia Pacific Region
* AtliQ Exclusive is a Brick & Mortar store means it is a physical store directly sold their products    from the store 
* AtliQ has highest store in APAC followed by EU(6), NA(2), LATAM has zero physical stores   

### 2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,
* unique_products_2020
* unique_products_2021
* percentage_chg

   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* In FY 2020, we had a total of 245 products, but in FY 2021 our count increased by 36.33% to 334 products.
* It’s a good sign that we are continuously innovating and introducing new products to the market.

---

### 3.Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains 2 fields,
* segment
* product_count
   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* We have a wide range of products under segments : Notebook, Accessories, Peripherals with an average of 110 products per segment
* While Desktop,Storage,Networking are lagging with an average of 23 products per segment
* Product development team needs to give attention on products that require redesigning as per modern standards
* Innovations will keep AtliQ Hardware ahead in this competitive market

---

### 4.Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields,
* segment
* product_count_2020
* product_count_2021
* difference

   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* With the introduction of 34 new products, Accessories segment has the highest increase in number of products
* Notebook and Peripherals each has an increment of 16 products
* Product team has done good job in Desktop segment by increasing count 2020(7) < 2021(22)
* Networking segment is at bottom with only 3 new products in 2021

---

### 5.Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,
* product_code
* product
* manufacturing_cost

  ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

---

### 6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields,
* customer_code
* customer
* average_discount_percentage

   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* Flipkart has received highest 30.83% pre-invoice discount
* Amazon has low pre invoice discount 29.33%

---

### 7.Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . This analysis helps to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns:
* Month
* Year
* Gross sales Amount

   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* Highest sales were recorderd in November-2020 (20.5M) & lowest sales in March-2020(0.38M). 
* From March-August in 2020 sales are low because of the pandemic all the stores are closed. 
* Lockdowns increased demand for laptops and other home electronics, due to work from home.

---

### 8.In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity,
* Quarter
* total_sold_quantity

   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* Q1 (September-November) has highest sales (7.01M)
* Q3 (March-May) sales dropped because of pandemic
* Q4(June-August) sales are increasing

---

### 9.Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,
* channel
* gross_sales_mln
* percentage

   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* Retailer brings the maximum sales to the company 1024.17M (73.2%)
* Channel Direct generates 406.69M (15.5%) sales
* Distributor contributes least only 297.18M (11.3%)

---

### 10.Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these fields,
* division
* product_code
* product
* total_sold_quantity
* rank_order

   ```sql
   SELECT distinct market
   FROM dim_customer
   WHERE customer="Atliq Exclusive" AND region="APAC";
  ```

* N&S : Top selling product is AQ Pen Drive 2 IN 1 with a total of 7,01,373 quantities sold, followed by two variants of AQ Pen Drive DRC with 6,88,003 and 6,76,245 quantity.
* P&A : AQ Gamers Ms is top selling product with a total of 4,28,498 quantities sold, followed by two variants of AQ Maxima Ms
* PC : AQ Digit is top selling product with a total of 17,434 quantities
