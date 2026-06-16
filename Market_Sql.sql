use project_orders;	
show tables;

select a.aisle,
				count(p.product_id) as total_products
from products p 
join aisles a 
on p.aisle_id = a.aisle_id
group by a.aisle
order by total_products desc 
limit 10;

select count(distinct department_id) as total_departments
from departments;

select d.department,
					count(p.product_id) as total_products
from products p
join departments d
on p.department_id = d.department_id
group by d.department;

select p.product_name, avg(op.reordered) * 100 as reorder_rate
from order_products_train op 
join products p
on op.product_id = p.product_id
group by p.product_name
order by reorder_rate desc
limit 10;

select count(distinct user_id) as total_user
from orders;

select user_id, avg(days_since_prior_order) as avg_days
from orders
group by user_id;

select order_hour_of_day, count(*) as total_orders
from orders
group by order_hour_of_day
order by total_orders desc;

select order_dow, count(*) as total_orders
from orders
group by order_dow
order by order_dow;

select p.product_name, count(*) as total_orders
from order_products_train op
join products p 
on op.product_id = p.product_id
group by product_name
order by total_orders desc
limit 10;

select d.department, count(distinct o.user_id) as total_users
from orders o
join order_products_train op 
on o.order_id = op.order_id
join products p 
on op.product_id =p.product_id
join departments d 
on d.department_id = p.department_id
group by d.department;

select avg(product_count) as avg_products
from (select order_id, 
						count(product_id) as product_count
		from order_products_train
group by order_id)t;

select d.department, 
		p.product_name, 
        sum(op.reordered) as reorder_count
from order_products_train op
join products p 
on op.product_id = p.product_id
join departments d
on p.department_id = d.department_id
group by d.department , p.product_name
order by d.department, reorder_count desc;

select count(*) as total_products
from 
(select product_id
from order_products_train
group by product_id
having sum(reordered)> 1 
)t;

select avg(product_count)
from 
(select order_id, 
				count(*) as product_count
from order_products_train
group by order_id
)t;

select order_hour_of_day, count(*) as total_orders
from orders
group by order_hour_of_day
order by order_hour_of_day;

select product_count, count(*) as orders
from 
( 
select order_id, 
				count(*) as product_count
from order_products_train
group by order_id
)t
group by product_count
order by product_count;

SELECT a.aisle,
       AVG(op.reordered)*100 AS reorder_rate
FROM order_products_train op
JOIN products p
ON op.product_id = p.product_id
JOIN aisles a
ON p.aisle_id = a.aisle_id
GROUP BY a.aisle;

select o.order_dow,
					avg(product_count) as avg_order_size
from 
(
select order_id ,count(*) as product_count
from order_products_train
group by order_id
)t
join orders o 
on t .order_id = o.order_id
group by o.order_dow;

select user_id, count(order_id) as total_orders
from orders
group by user_id
order by total_orders desc 
limit 10;

select d.department,
		a.aisle, 
        count(p.product_id) as total_products
from products p
join departments d
on p.department_id = d.department_id
join aisles a
on p.aisle_id = a.aisle_id
group by d.department, a.aisle
order by total_products desc;