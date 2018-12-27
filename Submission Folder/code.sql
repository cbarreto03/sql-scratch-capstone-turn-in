-- Quiz Funnel Q1
select *
 from survey
limit 10;
-- Quiz Funnel Q2
select question, count (distinct user_id)
from survey
group by question;
-- Quiz Funnel Q3 in Excel
-- Home Try On Funnel Q4
select *
from quiz
limit 5;
select *
from home_try_on
limit 5;
select *
from purchase
limit 5;
-- Home Try On Funnel Q5
select distinct quiz.user_id, 
home_try_on.user_id is not null as 'is_home_try_on', 
home_try_on.number_of_pairs, 
purchase.user_id is not null as 'is_purchase'
from quiz
left join home_try_on on home_try_on.user_id = quiz.user_id
left join purchase on purchase.user_id = quiz.user_id
limit 10;
-- Home Try On Funnel Q6 - Conversion Rates Lesson
with funnels as (
select distinct quiz.user_id, 
home_try_on.user_id is not null as 'is_home_try_on', 
home_try_on.number_of_pairs, 
purchase.user_id is not null as 'is_purchase'
from quiz
left join home_try_on on home_try_on.user_id = quiz.user_id
left join purchase on purchase.user_id = quiz.user_id)
select count(*) as 'Quiz Users', 
sum(is_home_try_on) as 'Home Try On', 
sum(is_purchase) as 'Purchase', 
1.0 * sum(is_home_try_on) / count(user_id) as 'Percent Home Try On', 
1.0 * sum(is_purchase) / sum(is_home_try_on) as 'Percent of HTO Purchased', 
1.0 * sum(is_purchase) / count(user_id) as 'Percent of Quiz Purchased'
from funnels;
-- Home Try On Funnel Q6 - Conversion Rates Lesson Add On 3 vs 5 Purchase Impact
with funnels as 
(select distinct quiz.user_id, 
home_try_on.user_id is not null as 'is_home_try_on', 
home_try_on.number_of_pairs, 
purchase.user_id is not null as 'is_purchase'
from quiz
left join home_try_on on home_try_on.user_id = quiz.user_id
left join purchase on purchase.user_id = quiz.user_id)
select number_of_pairs, 
count(*) as 'Quiz Users', 
sum(is_home_try_on) as 'Home Try On', 
sum(is_purchase) as 'Purchase',
round(1.0 * sum(is_purchase) / sum(is_home_try_on),2) as 'Percent of HTO Purchased'
from funnels
group by number_of_pairs;
-- Q6 Quiz Results Basic Style
select style, count(*) as 'User Response'
from quiz
group by style;
-- Q6 Quiz Results Popular Models Purchased
select distinct model_name, count(*) as 'User Response'
from purchase
group by model_name
order by count(*) desc;