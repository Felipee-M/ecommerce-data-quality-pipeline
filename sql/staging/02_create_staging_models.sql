CREATE OR REPLACE VIEW staging.stg_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    LOWER(TRIM(customer_city)) AS customer_city,
    UPPER(TRIM(customer_state)) AS customer_state,
    source_file,
    loaded_at
FROM raw.customers;


CREATE OR REPLACE VIEW staging.stg_orders AS
SELECT
    order_id,
    customer_id,
    LOWER(TRIM(order_status)) AS order_status,
    NULLIF(order_purchase_timestamp, '')::timestamp AS order_purchase_timestamp,
    NULLIF(order_approved_at, '')::timestamp AS order_approved_at,
    NULLIF(order_delivered_carrier_date, '')::timestamp AS order_delivered_carrier_date,
    NULLIF(order_delivered_customer_date, '')::timestamp AS order_delivered_customer_date,
    NULLIF(order_estimated_delivery_date, '')::timestamp AS order_estimated_delivery_date,
    source_file,
    loaded_at
FROM raw.orders;


CREATE OR REPLACE VIEW staging.stg_order_items AS
SELECT
    order_id,
    order_item_id::int AS order_item_id,
    product_id,
    seller_id,
    NULLIF(shipping_limit_date, '')::timestamp AS shipping_limit_date,
    price::numeric(12, 2) AS price,
    freight_value::numeric(12, 2) AS freight_value,
    source_file,
    loaded_at
FROM raw.order_items;


CREATE OR REPLACE VIEW staging.stg_payments AS
SELECT
    order_id,
    payment_sequential::int AS payment_sequential,
    LOWER(TRIM(payment_type)) AS payment_type,
    payment_installments::int AS payment_installments,
    payment_value::numeric(12, 2) AS payment_value,
    source_file,
    loaded_at
FROM raw.payments;


CREATE OR REPLACE VIEW staging.stg_products AS
SELECT
    p.product_id,
    LOWER(TRIM(p.product_category_name)) AS product_category_name,
    LOWER(TRIM(t.product_category_name_english)) AS product_category_name_english,
    p.product_name_lenght::int AS product_name_length,
    p.product_description_lenght::int AS product_description_length,
    p.product_photos_qty::int AS product_photos_qty,
    p.product_weight_g::numeric(12, 2) AS product_weight_g,
    p.product_length_cm::numeric(12, 2) AS product_length_cm,
    p.product_height_cm::numeric(12, 2) AS product_height_cm,
    p.product_width_cm::numeric(12, 2) AS product_width_cm,
    p.source_file,
    p.loaded_at
FROM raw.products p
LEFT JOIN raw.product_category_translation t
    ON p.product_category_name = t.product_category_name;


CREATE OR REPLACE VIEW staging.stg_sellers AS
SELECT
    seller_id,
    seller_zip_code_prefix,
    LOWER(TRIM(seller_city)) AS seller_city,
    UPPER(TRIM(seller_state)) AS seller_state,
    source_file,
    loaded_at
FROM raw.sellers;


CREATE OR REPLACE VIEW staging.stg_reviews AS
SELECT
    review_id,
    order_id,
    review_score::int AS review_score,
    NULLIF(review_creation_date, '')::timestamp AS review_creation_date,
    NULLIF(review_answer_timestamp, '')::timestamp AS review_answer_timestamp,
    source_file,
    loaded_at
FROM raw.reviews;