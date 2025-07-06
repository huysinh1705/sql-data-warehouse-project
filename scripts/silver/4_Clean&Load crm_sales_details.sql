insert into [silver].[crm_sales_details](
    sls_ord_num,
    sls_prd_key,  
    sls_cust_id,  
    sls_order_dt, 
    sls_ship_dt, 
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price   
)

select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt = 0 or len(sls_order_dt) !=8 then null
	else cast(cast(sls_order_dt as varchar) as date)
end as sls_order_dt,
case when sls_ship_dt = 0 or len(sls_ship_dt) !=8 then null
	else cast(cast(sls_ship_dt as varchar) as date)
end as sls_ship_dt,
case when sls_due_dt = 0 or len(sls_due_dt) !=8 then null
	else cast(cast(sls_due_dt as varchar) as date)
end as sls_due_dt,
CASE 
	WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
	END AS sls_sales, --Recalculate sales if original value is missing or incorrect
sls_quantity,
	CASE 
	WHEN sls_price IS NULL OR sls_price <= 0 
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price 
	END AS sls_price  --Derive price if original value is invalid
from [bronze].[crm_sales_details]
