SELECT 
	   case
	   	when premium >500 then 'HIGH'
	   	when premium >= 300 then 'MEDIUM'
	   	else 'LOW'
	   end as premium_band,	   
       SUM(c.claim_amount) AS total_claims,
       SUM(p.premium) AS total_premium,
       SUM(c.claim_amount)*1.0 / SUM(p.premium) AS loss_ratio
FROM policies p
LEFT JOIN claims c 
ON p.policy_id = c.policy_id
GROUP BY premium_band
order by loss_ratio desc;
