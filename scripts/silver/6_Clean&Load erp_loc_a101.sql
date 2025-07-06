insert into [silver].[erp_loc_a101](cid,cntry)
select
REPLACE(cid,'-','') cid,
CASE
	WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
	WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	ELSE TRIM(cntry)
END AS cntry
from [bronze].[erp_loc_a101]