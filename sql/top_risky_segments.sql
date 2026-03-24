with segment_ratio as (
SELECT 
	   p.segment,
       SUM(c.claim_amount) AS total_claims,
       SUM(p.premium) AS total_premium,
       SUM(c.claim_amount)*1.0 / SUM(p.premium) AS loss_ratio
FROM policies p
LEFT JOIN claims c 
ON p.policy_id = c.policy_id
GROUP BY p.segment)
select *,
rank() over (order by loss_ratio desc) as rank_by_risk
from segment_ratio;
