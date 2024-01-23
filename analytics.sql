-- Churn rate based on geography
select  geography,
        (SUM(CASE WHEN exited = 'true' THEN 1 ELSE 0 END)::numeric / COUNT(*))*100 AS leftpercent
from customer_churn_records
group by geography;
-- In Spain and France, only 16% of the customers left the bank, while in Germany, 32% of customers left.
-- Suggestion: check on the service quality in Germany locations.

-- Churn rate based on tenure
select  tenure,
        (SUM(CASE WHEN exited = 'true' THEN 1 ELSE 0 END)::numeric / COUNT(*))*100 AS leftpercent,
        SUM(case when exited = 'true' then 1 else 0 end) as left,
        count(*) as total
from customer_churn_records
group by tenure
order by leftpercent desc;
-- Highest churn percentage is those who been customers for less than 1 year (23%).
-- Suggestion: The bank can give out bonuses or promotions to new customers to have good first impression of the bank.

-- Churn rate based on age segment
select  agesegment,
        (SUM(CASE WHEN exited = 'true' THEN 1 ELSE 0 END)::numeric / COUNT(*))*100 AS leftpercent,
        SUM(case when exited = 'true' then 1 else 0 end) as left,
        count(*) as total
from customer_churn_records
group by agesegment
order by leftpercent desc;
-- Age segment 4 (55-64) has a highest churn rate of 50%, second highest is age segment 3 (35-54) with churn rate of 26%.
-- Suggestion: Focus on taking care these two age segments, for example having banker contact customers more frequently.

-- Churn rate based on complain
select  complain,
        (SUM(CASE WHEN exited = 'true' THEN 1 ELSE 0 END)::numeric / COUNT(*))*100 AS leftpercent,
        SUM(case when exited = 'true' then 1 else 0 end) as left,
        count(*) as total
from customer_churn_records
group by complain
order by leftpercent desc;
-- 99% of customers who has a complain left the bank.
-- Suggestion: Escalate customer complain to upper management for quicker solutions.
select  geography,
        sum(case when complain = 'true' then 1 else 0 end) as num_complain,
        (sum(CASE WHEN complain = 'true' THEN 1 ELSE 0 END) / sum(sum(CASE WHEN complain = 'true' THEN 1 ELSE 0 END)) OVER ())*100 AS complaint_percentage
from customer_churn_records
group by geography;
-- 40% of customers who has complain are from Germany and 39% are from France.
-- Suggestion: Upper management should pay more attention to the service of these locations.