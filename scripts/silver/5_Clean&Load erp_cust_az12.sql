TRUNCATE TABLE silver.erp_cust_az12;
insert into [silver].[erp_cust_az12](
	cid,
	bdate,
	gen
)

select
case when cid like 'NAS%' then SUBSTRING(cid, 4, len(cid))
	else cid
end as cid,
case when bdate > getdate() then null
	else bdate
end as bdate,
case when upper(trim(gen)) in ('F', 'FEMALE') then 'Female'
	 when upper(trim(gen)) in ('F', 'MALE') then 'Male'
	 else 'N/a'
end as gen
from [bronze].[erp_cust_az12]
