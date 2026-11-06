
----------------Invalid Values Check for Customers Table---------------------------
select * from customers 

SELECT
    COUNT(*) AS total_rows,

    -- Numerical validation
    SUM(CASE WHEN age < 0 OR age > 100 THEN 1 ELSE 0 END) AS invalid_age,

    SUM(CASE WHEN total_orders < 0 THEN 1 ELSE 0 END) AS invalid_total_orders,

    SUM(CASE WHEN total_spend < 0 THEN 1 ELSE 0 END) AS invalid_total_spend,

    SUM(CASE WHEN average_order_value < 0 THEN 1 ELSE 0 END) AS invalid_average_order_value,

    -- Date validation
    SUM(CASE WHEN customer_signup_date < '2023-01-01'
              OR customer_signup_date >= '2026-01-01'
             THEN 1 ELSE 0 END) AS invalid_signup_dates,

    SUM(CASE WHEN last_order_date < customer_signup_date
             THEN 1 ELSE 0 END) AS invalid_last_order_dates,

    SUM(CASE WHEN last_order_date >= '2026-01-01'
             THEN 1 ELSE 0 END) AS invalid_future_order_dates

FROM customers;

----------------Invalid Values Check for Product Table-------------------------------------------
select * from Products  

SELECT
    COUNT(*) AS total_rows,

    -- Primary key validation
    COUNT(DISTINCT product_id) AS unique_product_ids,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_ids,

    -- Numerical validation
    SUM(CASE WHEN price <= 0 THEN 1 ELSE 0 END) AS invalid_price,
    SUM(CASE WHEN stock_quantity < 0 THEN 1 ELSE 0 END) AS invalid_stock_quantity,
    SUM(CASE WHEN rating_average < 0 OR rating_average > 5
             THEN 1 ELSE 0 END) AS invalid_rating,
    SUM(CASE WHEN return_rate_baseline < 0 OR return_rate_baseline > 100
             THEN 1 ELSE 0 END) AS invalid_return_rate

FROM products;

----------------Invalid Values Check for Order_items Table-------------------------------------------
  --Duplicate ID checks 
SELECT
    order_item_id,
    COUNT(*) AS duplicate_count
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

  --Numerical and Business logic validation

SELECT
    COUNT(*) AS total_rows,

    SUM(CASE WHEN quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity,

    SUM(CASE WHEN unit_price < 0 THEN 1 ELSE 0 END) AS invalid_unit_price,

    SUM(CASE WHEN discount_percentage < 0 OR discount_percentage > 100
        THEN 1 ELSE 0 END) AS invalid_discount,

    SUM(CASE WHEN item_revenue < 0 THEN 1 ELSE 0 END) AS invalid_item_revenue,

    SUM(CASE WHEN item_cost < 0 THEN 1 ELSE 0 END) AS invalid_item_cost,

    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS negative_profit,

    SUM(CASE
        WHEN ABS(profit - (item_revenue - item_cost)) > 1
        THEN 1 ELSE 0
    END) AS profit_calculation_mismatches

FROM order_items;

----------------Invalid Values Check for Payments Table-------------------------------------------

-- 1. Duplicate IDs
SELECT payment_id, COUNT(*) AS duplicate_count
FROM payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

-- 2. Numerical checks
SELECT
SUM(CASE WHEN amount_paid < 0 THEN 1 ELSE 0 END) AS invalid_amount,
SUM(CASE WHEN transaction_fee < 0 THEN 1 ELSE 0 END) AS invalid_fee,
SUM(CASE WHEN refund_amount < 0 THEN 1 ELSE 0 END) AS invalid_refund,
SUM(CASE WHEN refund_amount > amount_paid THEN 1 ELSE 0 END) AS refund_exceeds_payment
FROM payments;

-- 3. Date checks
SELECT COUNT(*) AS invalid_dates
FROM payments
WHERE payment_date < '2023-01-01' OR payment_date >= '2026-01-01';

-- 4. Category checks
SELECT DISTINCT payment_method, payment_status
FROM payments;

----------------Invalid Values Check for Shipments Table-------------------------------------------

-- Duplicates
SELECT shipment_id, COUNT(*) FROM shipments 
GROUP BY shipment_id 
HAVING COUNT(*) > 1;

-- Numerical
SELECT SUM(CASE WHEN delivery_days < 0 THEN 1 ELSE 0 END) AS invalid_days,
SUM(CASE WHEN delivery_days > 365 THEN 1 ELSE 0 END) AS unusual_days 
FROM shipments;

-- Dates
SELECT SUM(CASE WHEN dispatch_date < '2023-01-01' OR dispatch_date >= '2026-01-01' THEN 1 ELSE 0 END) AS invalid_dispatch,
SUM(CASE WHEN expected_delivery_date < dispatch_date THEN 1 ELSE 0 END) AS invalid_expected,
SUM(CASE WHEN actual_delivery_date < dispatch_date THEN 1 ELSE 0 END) AS invalid_actual 
FROM shipments;

-- Categories
SELECT DISTINCT shipping_method, delivery_status 
FROM shipments;

-- Delayed flag
SELECT delayed_flag, delivery_status, COUNT(*) 
FROM shipments GROUP BY delayed_flag, delivery_status;

----------------Invalid Values Check for Returns Table-------------------------------------------

-- 1. Duplicate return IDs
SELECT return_id,COUNT(*)
FROM returns
GROUP BY return_id
HAVING COUNT(*)>1;

-- 2. Refund amount
SELECT COUNT(*) AS invalid_refunds
FROM returns
WHERE refund_amount<0;

-- 3. Return dates
SELECT COUNT(*) AS invalid_dates
FROM returns
WHERE return_date<'2023-01-01'
OR return_date>='2026-01-01';

-- 4. Return categories
SELECT DISTINCT return_reason,return_status
FROM returns;

----------------Invalid Values Check for Customers_reviews Table-------------------------------------------

-- 1. Duplicate review IDs
SELECT review_id,COUNT(*)
FROM customer_reviews
GROUP BY review_id
HAVING COUNT(*)>1;

-- 2. Rating validation
SELECT COUNT(*) AS invalid_ratings
FROM customer_reviews
WHERE rating<1 OR rating>5;

-- 3. Review dates
SELECT COUNT(*) AS invalid_dates
FROM customer_reviews
WHERE review_date<'2023-01-01'
OR review_date>='2026-01-01';

-- 4. Review categories
SELECT DISTINCT rating,review_sentiment,verified_purchase
FROM customer_reviews;

----------------Invalid Values Check for Marketing_Campaigns Table-------------------------------------------

-- 1. Duplicate campaign IDs
SELECT campaign_id,COUNT(*)
FROM marketing_campaigns
GROUP BY campaign_id
HAVING COUNT(*)>1;

-- 2. Numeric validation
SELECT
SUM(CASE WHEN discount_percentage<0 OR discount_percentage>100 THEN 1 ELSE 0 END) AS invalid_discount,
SUM(CASE WHEN conversions<0 OR revenue_generated<0 OR impressions<0 OR clicks<0 OR campaign_cost<0 THEN 1 ELSE 0 END) AS invalid_metrics,
SUM(CASE WHEN clicks>impressions THEN 1 ELSE 0 END) AS invalid_clicks
FROM marketing_campaigns;

-- 3. Campaign dates
SELECT COUNT(*) AS invalid_dates
FROM marketing_campaigns
WHERE campaign_end_date<campaign_start_date
OR campaign_start_date<'2023-01-01'
OR campaign_end_date>='2026-01-01';

-- 4. Campaign categories
SELECT DISTINCT channel,campaign_type,target_segment
FROM marketing_campaigns;


-- Data quality Limitation.
SELECT campaign_id,campaign_name,campaign_start_date,campaign_end_date
FROM marketing_campaigns
WHERE campaign_end_date<campaign_start_date
OR campaign_start_date<'2023-01-01'
OR campaign_end_date>='2026-01-01';