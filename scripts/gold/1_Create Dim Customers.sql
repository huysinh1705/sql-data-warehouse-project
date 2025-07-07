create view gold.dim_customers as
select
ROW_NUMBER() over(order by cst_id) customer_key,
ci.cst_id customer_id,
ci.cst_key customer_number,
ci.cst_firstname first_name,
ci.cst_lastname last_name,
la.cntry country,
ci.cst_marital_status marital_status,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr --CRM is the master for gender info
	else coalesce(ca.gen,'n/a')
end as gender,
ca.bdate birthdate,
ci.cst_create_date create_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
left join [silver].[erp_loc_a101] la
on ci.cst_key = la.cid