

--1. SALES PERFORMANCE

USE Indian_Ecommerce_Analytics;

-- Overall Sales KPIs
SELECT COUNT(DISTINCT order_id) AS orders,SUM(final_amount) AS revenue,AVG(final_amount) AS AOV
FROM orders;

-- Monthly Revenue
SELECT FORMAT(order_date,'yyyy-MM') AS month,COUNT(*) AS orders,SUM(final_amount) AS revenue
FROM orders
GROUP BY FORMAT(order_date,'yyyy-MM')
ORDER BY month;

-- Yearly Revenue & Growth
WITH Y AS (SELECT YEAR(order_date) AS year,SUM(final_amount) AS revenue FROM orders GROUP BY YEAR(order_date))
SELECT year,revenue,ROUND((revenue-LAG(revenue) OVER(ORDER BY year))*100.0/NULLIF(LAG(revenue) OVER(ORDER BY year),0),2) AS growth_pct
FROM Y ORDER BY year;

-- State-wise Revenue
SELECT delivery_state,COUNT(*) AS orders,SUM(final_amount) AS revenue
FROM orders GROUP BY delivery_state ORDER BY revenue DESC;

-- Order Status
SELECT order_status,COUNT(*) AS orders,SUM(final_amount) AS revenue
FROM orders GROUP BY order_status;
--------------------------------------------------------------------------------------------------------------------------------------

--2. PRODUCT PERFORMANCE 

-- Top 10 Products by Revenue
SELECT TOP 10 p.product_id,p.product_name,SUM(oi.item_revenue) AS revenue
FROM order_items oi JOIN products p ON oi.product_id=p.product_id
GROUP BY p.product_id,p.product_name
ORDER BY revenue DESC;

-- Top 10 Best-Selling Products
SELECT TOP 10 p.product_id,p.product_name,SUM(oi.quantity) AS units_sold
FROM order_items oi JOIN products p ON oi.product_id=p.product_id
GROUP BY p.product_id,p.product_name
ORDER BY units_sold DESC;

-- Category-wise Revenue
SELECT p.category,SUM(oi.item_revenue) AS revenue
FROM order_items oi JOIN products p ON oi.product_id=p.product_id
GROUP BY p.category ORDER BY revenue DESC;

-- Category-wise Profit and Margin
SELECT p.category,SUM(oi.profit) AS total_profit,
ROUND(SUM(oi.profit)*100.0/NULLIF(SUM(oi.item_revenue),0),2) AS profit_margin
FROM order_items oi JOIN products p ON oi.product_id=p.product_id
GROUP BY p.category ORDER BY total_profit DESC;

-- Top 10 Returned Products Performance
SELECT TOP 10 p.product_name,COUNT(r.return_id) AS returns,SUM(r.refund_amount) AS refunds
FROM returns r JOIN products p ON r.product_id=p.product_id
GROUP BY p.product_id,p.product_name
ORDER BY returns DESC;

---------------------------------------------------------------------------------------------------------------------------------------

-- 3. CUSTOMER ANALYSIS 

--  New vs Returning Customers
WITH C AS (SELECT customer_id,COUNT(*) AS orders FROM orders GROUP BY customer_id)
SELECT 
     CASE WHEN orders=1 THEN 'One-time' ELSE 'Repeat' 
     END AS customer_type,
     COUNT(*) AS customers 
FROM C 
GROUP BY CASE WHEN orders=1 THEN 'One-time' ELSE 'Repeat' END;

--  Revenue by Customer Segment
SELECT c.customer_segment,COUNT(DISTINCT o.customer_id) AS customers,
SUM(o.final_amount) AS revenue
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_segment ORDER BY revenue DESC;

--  Top 10 Customers by Revenue
SELECT TOP 10 c.customer_id,c.customer_segment,
COUNT(o.order_id) AS orders,SUM(o.final_amount) AS revenue
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.customer_segment ORDER BY revenue DESC;

--  Repeat Purchase Rate
WITH C AS (SELECT customer_id,COUNT(*) AS orders FROM orders GROUP BY customer_id)
SELECT COUNT(*) AS total_customers,
SUM(CASE WHEN orders>1 THEN 1 ELSE 0 END) AS repeat_customers,
ROUND(SUM(CASE WHEN orders>1 THEN 1.0 ELSE 0 END)*100/COUNT(*),2) AS repeat_rate_pct
FROM C;

--  Customer Status Distribution
SELECT customer_status,COUNT(*) AS customers
FROM customers GROUP BY customer_status ORDER BY customers DESC;

-----------------------------------------------------------------------------------------------------------------

-- 4. OPERATIONS & RETURNS 

-- Overall Return Rate
SELECT COUNT(DISTINCT o.order_id) AS total_orders,
COUNT(DISTINCT r.order_id) AS returned_orders,
ROUND(COUNT(DISTINCT r.order_id)*100.0/COUNT(DISTINCT o.order_id),2) AS return_rate_pct
FROM orders o LEFT JOIN returns r ON o.order_id=r.order_id;

-- Return Reasons
SELECT return_reason,COUNT(*) AS returns,SUM(refund_amount) AS refunds
FROM returns GROUP BY return_reason ORDER BY returns DESC;

-- Average Delivery Time
SELECT ROUND(AVG(delivery_days*1.0),2) AS avg_delivery_days
FROM shipments WHERE actual_delivery_date IS NOT NULL;

-- Delayed Delivery Percentage
SELECT COUNT(*) AS shipments,
SUM(CASE WHEN delayed_flag=1 THEN 1 ELSE 0 END) AS delayed_shipments,
ROUND(SUM(CASE WHEN delayed_flag=1 THEN 1.0 ELSE 0 END)*100/COUNT(*),2) AS delayed_pct
FROM shipments;

-- Delivery Performance by Shipping Method
SELECT shipping_method,COUNT(*) AS shipments,
ROUND(AVG(delivery_days*1.0),2) AS avg_delivery_days,
ROUND(AVG(CASE WHEN delayed_flag=1 THEN 100.0 ELSE 0 END),2) AS delayed_pct
FROM shipments WHERE actual_delivery_date IS NOT NULL
GROUP BY shipping_method ORDER BY avg_delivery_days;    

----------------------------------------------------------------------------------------------------------------------------

-- 5. MARKETING ANALYSIS 

-- Revenue by Marketing Channel
SELECT marketing_channel,COUNT(*) AS orders,
SUM(final_amount) AS revenue
FROM orders GROUP BY marketing_channel ORDER BY revenue DESC;

-- Campaign Performance
SELECT TOP 10 campaign_name,channel,conversions,revenue_generated,campaign_cost,roi
FROM marketing_campaigns ORDER BY roi DESC;

-- Overall Campaign KPIs
SELECT COUNT(*) AS campaigns,
SUM(impressions) AS impressions,
SUM(clicks) AS clicks,
SUM(conversions) AS conversions,
SUM(campaign_cost) AS total_cost,
SUM(revenue_generated) AS total_revenue,
ROUND(SUM(clicks)*100.0/NULLIF(SUM(impressions),0),2) AS ctr_pct
FROM marketing_campaigns;

-------------------------------------------------------------------------------------------------------


