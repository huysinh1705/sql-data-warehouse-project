--Quality Checks
--Check null and duplicate primary_key
--Expectation: No Results
select cst_id,
COUNT(*) no_cst_id
from silver.crm_cust_info
group by cst_id
having COUNT(*) > 1 or cst_id is null

--Check for unwanted Spaces
--Expectation: No Results
select cst_firstname
from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

--Data Standardization & Consistency
select distinct prd_line
from silver.crm_prd_info

select *
from silver.crm_prd_info
where prd_end_dt is null


