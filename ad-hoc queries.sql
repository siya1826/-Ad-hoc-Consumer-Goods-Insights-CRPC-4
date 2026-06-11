--- 1.Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.
SELECT distinct market
FROM dim_customer
WHERE customer="Atliq Exclusive" AND region="APAC";


--- 2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,
WITH product_counts_yearly AS (
       SELECT fiscal_year,
              COUNT( DISTINCT product_code) AS unique_products
       FROM fact_sales_monthly
       WHERE fiscal_year IN (2020, 2021)
       GROUP BY fiscal_year
)

SELECT
      MAX( CASE WHEN fiscal_year = 2020 THEN unique_products END) AS unique_products_2020,
      MAX( CASE WHEN fiscal_year = 2021 THEN unique_products END) AS unique_products_2021,
      ROUND (
            (
            ( MAX( CASE WHEN fiscal_year = 2021 THEN unique_products END) 
              -
              MAX( CASE WHEN fiscal_year = 2020 THEN unique_products END)
              )  * 100 /
              MAX( CASE WHEN fiscal_year = 2020 THEN unique_products END) 
              ),2)
	 AS percentage_chg
     FROM product_counts_yearly


  
--- 3.Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains 2 fields,
SELECT segment, 
	   COUNT(DISTINCT product_code) AS product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;


--- 4.Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields,
WITH segment_count AS(
      SELECT 
            p.segment,
            s.fiscal_year,
            COUNT(DISTINCT s.product_code) AS product_count
	  FROM fact_sales_monthly s
      JOIN dim_product p
      ON s.product_code = p.product_code
      WHERE s.fiscal_year IN (2020,2021)
      GROUP BY p.segment, s.fiscal_year
) SELECT 
      segment,
      MAX(CASE WHEN fiscal_year = 2020 THEN product_count END) as product_count_2020,
	  MAX(CASE WHEN fiscal_year = 2021 THEN product_count END) as product_count_2021,
      ( 
      MAX(CASE WHEN fiscal_year = 2021 THEN product_count END)
      -
       MAX(CASE WHEN fiscal_year = 2020 THEN product_count END) 
       ) AS difference
 FROM segment_count
 GROUP BY segment
 ORDER BY difference DESC;


--- 5.Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,
SELECT m.product_code, p.product,m.manufacturing_cost
FROM fact_manufacturing_cost m 
JOIN dim_product p
ON m.product_code = p.product_code
WHERE manufacturing_cost = (SELECT 
                              MAX(manufacturing_cost) 
                              FROM fact_manufacturing_cost)
              OR 
	  m.manufacturing_cost = (SELECT 
                              MIN(manufacturing_cost) 
                              FROM fact_manufacturing_cost);


--- 6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields,
SELECT 
	   d.customer_code,
       c.customer,
       round(AVG(d.pre_invoice_discount_pct),2) AS AVG_discount_percentage
FROM fact_pre_invoice_deductions d
JOIN dim_customer c
ON d.customer_code = c.customer_code
WHERE d.fiscal_year = 2021 AND c.market = "India"
GROUP BY d.customer_code, c.customer
ORDER BY AVG_discount_percentage DESC
LIMIT 5;


--- 7.Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . This analysis helps to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns:
SELECT 
       MONTHNAME(date) AS month_name,
       YEAR(date) AS year_, 
       CONCAT(ROUND(SUM(a.sold_quantity * b.gross_price)/1000000,2),'M') AS gross_sales 
FROM fact_sales_monthly AS a
INNER JOIN fact_gross_price AS b
ON b.product_code = a.product_code
AND b.fiscal_year = a.fiscal_year
INNER JOIN dim_customer AS c
ON c.customer_code = a.customer_code
WHERE c.customer = 'Atliq Exclusive'
GROUP BY month_name, year_
ORDER BY year_;


--- 8.In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity,
SELECT 
    CASE
        WHEN MONTH(date) IN (9,10,11)
        THEN 'Q1'

        WHEN MONTH(date) IN (12,1,2)
        THEN 'Q2'

        WHEN MONTH(date) IN (3,4,5)
        THEN 'Q3'

        ELSE 'Q4'

    END AS Quarter_,
    sum(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY Quarter_
ORDER BY total_sold_quantity
LIMIT 1;


--- 9.Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,
WITH channel_sales AS (
    SELECT 
        c.channel,
        SUM(s.sold_quantity * g.gross_price) AS gross_sales
    FROM fact_sales_monthly s
    JOIN fact_gross_price g
          ON s.product_code = g.product_code
          AND s.fiscal_year = g.fiscal_year
    JOIN dim_customer c
          ON s.customer_code = c.customer_code
    WHERE s.fiscal_year = 2021
    GROUP BY c.channel
)

SELECT 
    channel,
     ROUND(gross_sales / 1000000, 2) AS gross_sales_mln,
    ROUND((gross_sales * 100.0) / (SELECT SUM(gross_sales)
	             FROM channel_sales), 2 ) AS percentage
FROM channel_sales
ORDER BY gross_sales DESC;  


--- 10.Get the Top 3 products in each division that have a high
WITH product_sales AS (
    SELECT 
        p.division,
        s.product_code,
        p.product,
        SUM(s.sold_quantity) AS total_sold_quantity
    FROM fact_sales_monthly s
    JOIN dim_product p
           ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY 
        p.division,
        s.product_code,
        p.product
),

ranked_products AS (
    SELECT 
        division,
        product_code,
        product,
        total_sold_quantity,
        RANK() OVER (
            PARTITION BY division
            ORDER BY total_sold_quantity DESC
        ) AS rank_order
    FROM product_sales
)

SELECT *
FROM ranked_products
WHERE rank_order <= 3;
