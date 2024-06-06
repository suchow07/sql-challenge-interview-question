-- DAY 11 --
-- CHALLENGE INSPIRATION FROM: Ankit Bansal
-- =========
-- TASK --
-- =========
-- Write a query to find the number of people present inside the hospital.




create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');


select * from hospital;

-- ============ Method 1: Using CTE ============================
select count(*) from (
select emp_id,
max(case when action = 'in' then time end) as intime,
max(case when action= 'out' then time end) as outtime
from hospital
group by emp_id) a
where intime > outtime or outtime is null;

-- =============== Method 1: Using Having
select emp_id,
max(case when action = 'in' then time end) as intime,
max(case when action= 'out' then time end) as outtime
from hospital
group by emp_id
having intime > outtime or outtime is null; 


-- ================ Methos 2: Using Join

with intime as (
select emp_id, max(time) as latest_intime
from hospital
where action = 'in'
group by emp_id),
outtime as (
select emp_id, max(time) as latest_outtime 
from hospital
where action = 'out'
group by emp_id)
select *
from intime left join 
outtime
on intime.emp_id =outtime.emp_id
where latest_intime > latest_outtime or latest_outtime is null;

-- ================== Method 3 ===============
with latest_time as
(select emp_id,  max(time) as max_time
from hospital
group by emp_id) ,
latest_in_time as (
select emp_id,  max(time) as max_in_time
from hospital
where action = 'in'
group by emp_id)
select lt.emp_id from latest_time lt
inner join latest_in_time lit
on lt.emp_id = lit.emp_id
and lt.max_time = lit.max_in_time;

-- ======================== Method 4

with cte4 as (
select *,row_number() over (partition by emp_id order by time desc) as activity
from hospital)

select * from cte4
where action='in' and activity=1;


