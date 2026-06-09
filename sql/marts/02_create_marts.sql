CREATE OR REPLACE VIEW marts.mart_sales AS
WITH items_by_order AS (
    SELECT
        oi.order_id,
        COUNT(*) AS total_items,
        COUNT(DISTINCT oi.product_id) AS total_distinct_products,
        SUM(oi.price) AS total_items_value,
        SUM(oi.freight_value) AS total_freight_value,
        STRING_AGG(
            DISTINCT COALESCE(p.product_category_name_english, p.product_category_name),
            ', '
        ) AS product_categories
    FROM staging.stg_order_items oi
    LEFT JOIN staging.stg_products p
        ON oi.product_id = p.product_id
    GROUP BY
        oi.order_id
),

payments_by_order AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value,
        COUNT(*) AS total_payment_transactions,
        STRING_AGG(DISTINCT payment_type, ', ') AS payment_types
    FROM staging.stg_payments
    GROUP BY
        order_id
)

SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp::date AS purchase_date,
    DATE_TRUNC('month', o.order_purchase_timestamp)::date AS purchase_month,
    COALESCE(i.total_items, 0) AS total_items,
    COALESCE(i.total_distinct_products, 0) AS total_distinct_products,
    COALESCE(i.total_items_value, 0) AS total_items_value,
    COALESCE(i.total_freight_value, 0) AS total_freight_value,
    COALESCE(p.total_payment_value, 0) AS total_payment_value,
    COALESCE(p.total_payment_transactions, 0) AS total_payment_transactions,
    p.payment_types,
    i.product_categories
FROM staging.stg_orders o
LEFT JOIN staging.stg_customers c
    ON o.customer_id = c.customer_id
LEFT JOIN items_by_order i
    ON o.order_id = i.order_id
LEFT JOIN payments_by_order p
    ON o.order_id = p.order_id;


CREATE OR REPLACE VIEW marts.mart_customer_behavior AS
SELECT
    c.customer_unique_id,
    MAX(c.customer_city) AS customer_city,
    MAX(c.customer_state) AS customer_state,
    COUNT(DISTINCT ms.order_id) AS total_orders,
    COUNT(DISTINCT CASE WHEN ms.order_status = 'delivered' THEN ms.order_id END) AS delivered_orders,
    SUM(ms.total_payment_value) AS total_spent,
    AVG(ms.total_payment_value) AS avg_order_value,
    MIN(ms.purchase_date) AS first_purchase_date,
    MAX(ms.purchase_date) AS last_purchase_date,
    MAX(ms.purchase_date) - MIN(ms.purchase_date) AS customer_lifetime_days
FROM marts.mart_sales ms
LEFT JOIN staging.stg_customers c
    ON ms.customer_id = c.customer_id
GROUP BY
    c.customer_unique_id;


CREATE OR REPLACE VIEW marts.mart_delivery_performance AS
WITH sellers_by_order AS (
    SELECT
        oi.order_id,
        STRING_AGG(DISTINCT s.seller_state, ', ') AS seller_states
    FROM staging.stg_order_items oi
    LEFT JOIN staging.stg_sellers s
        ON oi.seller_id = s.seller_id
    GROUP BY
        oi.order_id
)

SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    s.seller_states,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    ROUND(
        EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) / 86400.0,
        2
    ) AS delivery_days,

    ROUND(
        EXTRACT(EPOCH FROM (o.order_estimated_delivery_date - o.order_purchase_timestamp)) / 86400.0,
        2
    ) AS estimated_delivery_days,

    ROUND(
        EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) / 86400.0,
        2
    ) AS delay_days,

    CASE
        WHEN o.order_status <> 'delivered' THEN 'not_delivered'
        WHEN o.order_delivered_customer_date IS NULL THEN 'missing_delivery_date'
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'on_time'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'delayed'
        ELSE 'unknown'
    END AS delivery_status,

    CASE
        WHEN o.order_status = 'delivered' THEN TRUE
        ELSE FALSE
    END AS is_delivered,

    CASE
        WHEN o.order_status = 'delivered'
             AND o.order_delivered_customer_date <= o.order_estimated_delivery_date
        THEN TRUE
        ELSE FALSE
    END AS is_delivered_on_time

FROM staging.stg_orders o
LEFT JOIN staging.stg_customers c
    ON o.customer_id = c.customer_id
LEFT JOIN sellers_by_order s
    ON o.order_id = s.order_id;