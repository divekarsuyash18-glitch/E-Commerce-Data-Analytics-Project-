

create database Indian_Ecommerce_Analytics;
GO

Use Indian_Ecommerce_Analytics;
GO


SELECT COUNT(*) AS Total_customers
from customers;

select top 10*
from customers

EXEC sp_help 'customers';

--Checking duplicate customers ID's

select customer_id, count(*) as duplicate_count 
from customers
group by customer_id
having count(*) > 1;

--Checking missing values for Customers table -------------------------------------------------------------------------

select 

SUM(case when customer_id IS NULL then 1 else 0 end) as missing_customer_id,
SUM(case when customer_signup_date IS NULL then 1 else 0 end) as missing_customer_signup_dates,
SUM(case when gender IS NULL then 1 else 0 end) as missing_gender_values,
SUM(case when age IS NULL then 1 else 0 end) as missing_age_values,
SUM(case when age_group IS NULL then 1 else 0 end) as missing_agegroup_values,
SUM(case when state IS NULL then 1 else 0 end) as missing_state,
SUM(case when city IS NULL then 1 else 0 end ) as missing_city,
SUM(case when pincode_prefix IS NULL then 1 else 0 end ) as missing_pincodeprefix,
SUM(case when customer_segment IS NULL then 1 else 0 end) as missing_customer_segment,
SUM(case when preferred_device IS NULL then 1 else 0 end ) as missing_preferred_device,
SUM(case when preferred_payment_method IS NULL then 1 else 0 end) as missing_preferred_method_missing,
SUM(CASE WHEN acquisition_channel IS NULL THEN 1 ELSE 0 END) AS missing_acquisition_channel,
SUM(CASE WHEN total_orders IS NULL THEN 1 ELSE 0 END) AS missing_total_orders,
SUM(CASE WHEN total_spend IS NULL THEN 1 ELSE 0 END) AS missing_total_spend,
SUM(CASE WHEN last_order_date IS NULL THEN 1 ELSE 0 END) AS missing_last_order_date,
SUM(CASE WHEN average_order_value IS NULL THEN 1 ELSE 0 END) AS missing_average_order_value,
SUM(CASE WHEN customer_status IS NULL THEN 1 ELSE 0 END) AS missing_customer_status,
SUM(CASE WHEN loyalty_tier IS NULL THEN 1 ELSE 0 END) AS missing_loyalty_tier

from customers;

SELECT
    customer_status,
    COUNT(*) AS customers_without_last_order
FROM customers
WHERE last_order_date IS NULL
GROUP BY customer_status
ORDER BY customers_without_last_order DESC;

-- Checking missing values for Products table --------------------------------------------------------------------
select 

SUM(case when Product_id IS NULL then 1 else 0 end) as missing_product_id,
SUM(case when product_name IS NULL then 1 else 0 end) as missing_productName,
SUM(case when category IS NULL then 1 else 0 end) as missing_category,
SUM(case when subcategory IS NULL then 1 else 0 end) as missing_subcategory,
SUM(case when brand IS NULL then 1 else 0 end) as missing_brand,
SUM(case when price IS NULL then 1 else 0 end) as missing_price,
SUM(case when cost_price IS NULL then 1 else 0 end ) as missing_cost_price,
SUM(case when discount_range IS NULL then 1 else 0 end ) as missing_discount_range,
SUM(case when rating_average IS NULL then 1 else 0 end) as missing_rating_average,
SUM(case when rating_count IS NULL then 1 else 0 end ) as missing_rating_count,
SUM(case when stock_quantity IS NULL then 1 else 0 end) as missing_stock_quantity,
SUM(CASE WHEN product_launch_date IS NULL THEN 1 ELSE 0 END) AS missing_product_launch_date,
SUM(CASE WHEN product_type IS NULL THEN 1 ELSE 0 END) AS missing_product_type,
SUM(CASE WHEN return_rate_baseline IS NULL THEN 1 ELSE 0 END) AS missing_return_rate_baseline

from products;

-- Checking missing values for orders table ---------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN order_time IS NULL THEN 1 ELSE 0 END) AS missing_order_time,
    SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS missing_order_status,
    SUM(CASE WHEN shipping_method IS NULL THEN 1 ELSE 0 END) AS missing_shipping_method,
    SUM(CASE WHEN delivery_city IS NULL THEN 1 ELSE 0 END) AS missing_delivery_city,
    SUM(CASE WHEN delivery_state IS NULL THEN 1 ELSE 0 END) AS missing_delivery_state,
    SUM(CASE WHEN coupon_code IS NULL THEN 1 ELSE 0 END) AS missing_coupon_code,
    SUM(CASE WHEN discount_percentage IS NULL THEN 1 ELSE 0 END) AS missing_discount_percentage,
    SUM(CASE WHEN marketing_channel IS NULL THEN 1 ELSE 0 END) AS missing_marketing_channel,
    SUM(CASE WHEN subtotal IS NULL THEN 1 ELSE 0 END) AS missing_subtotal,
    SUM(CASE WHEN shipping_fee IS NULL THEN 1 ELSE 0 END) AS missing_shipping_fee,
    SUM(CASE WHEN tax_amount IS NULL THEN 1 ELSE 0 END) AS missing_tax_amount,
    SUM(CASE WHEN final_amount IS NULL THEN 1 ELSE 0 END) AS missing_final_amount,
    SUM(CASE WHEN campaign_id IS NULL THEN 1 ELSE 0 END) AS missing_campaign_id
FROM orders;
 

-- Checking missing values for order_items table ------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS missing_order_item_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS missing_unit_price,
    SUM(CASE WHEN discount_percentage IS NULL THEN 1 ELSE 0 END) AS missing_discount_percentage,
    SUM(CASE WHEN item_revenue IS NULL THEN 1 ELSE 0 END) AS missing_item_revenue,
    SUM(CASE WHEN item_cost IS NULL THEN 1 ELSE 0 END) AS missing_item_cost,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit
FROM order_items;


-- Checking missing values for Payments table ----------------------------------------------------------------------
select * from payments

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN payment_id IS NULL THEN 1 ELSE 0 END) AS missing_payment_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN payment_date IS NULL THEN 1 ELSE 0 END) AS missing_payment_date,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS missing_payment_method,
    SUM(CASE WHEN payment_status IS NULL THEN 1 ELSE 0 END) AS missing_payment_status,
    SUM(CASE WHEN amount_paid IS NULL THEN 1 ELSE 0 END) AS missing_amount_paid,
    SUM(CASE WHEN transaction_fee IS NULL THEN 1 ELSE 0 END) AS missing_transaction_fee,
    SUM(CASE WHEN refund_amount IS NULL THEN 1 ELSE 0 END) AS missing_refund_amount
FROM payments;

-- Checking missing values for Shipment table ---------------------------------------------------------------------

select * from shipments

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN shipment_id IS NULL THEN 1 ELSE 0 END) AS missing_shipment_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN warehouse_city IS NULL THEN 1 ELSE 0 END) AS missing_warehouse_city,
    SUM(CASE WHEN delivery_city IS NULL THEN 1 ELSE 0 END) AS missing_delivery_city,
    SUM(CASE WHEN shipping_method IS NULL THEN 1 ELSE 0 END) AS missing_shipping_method,
    SUM(CASE WHEN dispatch_date IS NULL THEN 1 ELSE 0 END) AS missing_dispatch_date,
    SUM(CASE WHEN expected_delivery_date IS NULL THEN 1 ELSE 0 END) AS missing_expected_delivery_date,
    SUM(CASE WHEN actual_delivery_date IS NULL THEN 1 ELSE 0 END) AS missing_actual_delivery_date,
    SUM(CASE WHEN delivery_days IS NULL THEN 1 ELSE 0 END) AS missing_delivery_days,
    SUM(CASE WHEN delivery_status IS NULL THEN 1 ELSE 0 END) AS missing_delivery_status,
    SUM(CASE WHEN delayed_flag IS NULL THEN 1 ELSE 0 END) AS missing_delayed_flag
FROM shipments;

SELECT delivery_status, COUNT(*) AS shipment_count
FROM shipments
WHERE actual_delivery_date IS NULL
GROUP BY delivery_status;

-- Checking missing values for Returns table ----------------------------------------------------------------------

select * from returns

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN return_id IS NULL THEN 1 ELSE 0 END) AS missing_return_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN return_date IS NULL THEN 1 ELSE 0 END) AS missing_return_date,
    SUM(CASE WHEN return_reason IS NULL THEN 1 ELSE 0 END) AS missing_return_reason,
    SUM(CASE WHEN refund_amount IS NULL THEN 1 ELSE 0 END) AS missing_refund_amount,
    SUM(CASE WHEN return_status IS NULL THEN 1 ELSE 0 END) AS missing_return_status
FROM returns;

-- Checking missing values for Customer_reviews table ------------------------------------------------------------

select * from customer_reviews

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END) AS missing_review_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN review_date IS NULL THEN 1 ELSE 0 END) AS missing_review_date,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS missing_rating,
    SUM(CASE WHEN review_sentiment IS NULL THEN 1 ELSE 0 END) AS missing_review_sentiment,
    SUM(CASE WHEN verified_purchase IS NULL THEN 1 ELSE 0 END) AS missing_verified_purchase
FROM customer_reviews;

SELECT rating, COUNT(*) AS reviews_without_sentiment
FROM customer_reviews
WHERE review_sentiment IS NULL
GROUP BY rating
ORDER BY rating;

SELECT rating, review_sentiment, COUNT(*) AS review_count
FROM customer_reviews
GROUP BY rating, review_sentiment
ORDER BY rating, review_sentiment;

--Missing review sentiments (233 records) were populated using the consistent rating-to-sentiment mapping 
--observed in the dataset: 1–2 = Negative, 3 = Neutral, and 4–5 = Positive.

update customer_reviews
set review_sentiment =
 case 
    when rating in (1,2) then 'Negative'
    when rating = 3 then 'Neutral'
    when rating in (4,5) then 'Positive'
 end 
where review_sentiment is null; 

-- Checking missing values for Marketing_ampaigns table ---------------------------------------------

select * from marketing_campaigns

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN campaign_id IS NULL THEN 1 ELSE 0 END) AS missing_campaign_id,
    SUM(CASE WHEN campaign_name IS NULL THEN 1 ELSE 0 END) AS missing_campaign_name,
    SUM(CASE WHEN channel IS NULL THEN 1 ELSE 0 END) AS missing_channel,
    SUM(CASE WHEN campaign_start_date IS NULL THEN 1 ELSE 0 END) AS missing_campaign_start_date,
    SUM(CASE WHEN campaign_end_date IS NULL THEN 1 ELSE 0 END) AS missing_campaign_end_date,
    SUM(CASE WHEN campaign_type IS NULL THEN 1 ELSE 0 END) AS missing_campaign_type,
    SUM(CASE WHEN target_segment IS NULL THEN 1 ELSE 0 END) AS missing_target_segment,
    SUM(CASE WHEN discount_percentage IS NULL THEN 1 ELSE 0 END) AS missing_discount_percentage,
    SUM(CASE WHEN conversions IS NULL THEN 1 ELSE 0 END) AS missing_conversions,
    SUM(CASE WHEN revenue_generated IS NULL THEN 1 ELSE 0 END) AS missing_revenue_generated,
    SUM(CASE WHEN impressions IS NULL THEN 1 ELSE 0 END) AS missing_impressions,
    SUM(CASE WHEN clicks IS NULL THEN 1 ELSE 0 END) AS missing_clicks,
    SUM(CASE WHEN campaign_cost IS NULL THEN 1 ELSE 0 END) AS missing_campaign_cost,
    SUM(CASE WHEN roi IS NULL THEN 1 ELSE 0 END) AS missing_roi
FROM marketing_campaigns;

------------------------------------------------------------------------------

select discount_percentage
from orders;

