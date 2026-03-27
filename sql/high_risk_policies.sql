with policy_total as (
select p.policy_id,
p.segment,
p.premium,
sum(c.claim_amount) as total_claims
from policies p 
left join claims c 
on p.policy_id =c.policy_id 
group by p.policy_id, p.segment, p.premium
order by total_claims desc)
select *,
case 
	when total_claims > premium then 'high_risk'
	else 'ok'
	end
from policy_total;
