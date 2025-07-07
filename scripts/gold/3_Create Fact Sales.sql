create view gold.fact_sales as

SELECT
    sd.sls_ord_num  order_number,
    pr.product_key  product_key,
    cu.customer_key customer_key,
    sd.sls_order_dt order_date,
    sd.sls_ship_dt  shipping_date,
    sd.sls_due_dt   due_date,
    sd.sls_sales    sales_amount,
    sd.sls_quantity quantity,
    sd.sls_price    price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id