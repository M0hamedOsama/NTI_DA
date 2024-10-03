create database project ;
use project ;
select * from brands ;
select * from categories ;
select * from customers ;
select * from order_items ;
select * from orders ;
select * from products ;
select * from staffs ;
select * from stocks ;
select * from stores ;


#1)Which bike is most expensive?--
select * from products 
order by list_price desc ;
# brand id 9 and the category_id 1 

#2)How many total customers does BikeStore have?
select count(distinct customer_id) as total_customers  from orders ;
select count(distinct customer_id)  from orders
where order_status !=3 ;

#3)How many stores does BikeStore have?
select count(distinct store_id) as Number_of_stores  from stores ;


#4)What is the total price spent per order?
select order_id, Sum(list_price *quantity*(1-discount)) as Total_price 
from order_items  group by order_id;



#5)What’s the sales/revenue per store?
select store_id, Sum(list_price *quantity*(1-discount)) as sales_over_revenue_per_store 
FROM order_items as oritem
		INNER JOIN orders ore 
		ON oritem.order_id = ore.order_id
        group by store_id ;

#6)Which category is most sold?
select category_id,count( category_id ) as Number_of_categore_items  from products
group by category_id ;

#7)Which category rejected more orders?
select p.category_id, count(oritem.order_id) as Rej_order 
from order_items as oritem 
inner join orders as ore on oritem.order_id= ore.order_id
inner join products as p on p.product_id=oritem.product_id 
where ore.order_status =3
group by p.category_id 
order by Rej_order desc ;

# 8 )Which bike is the least sold?
select brand_id,count( brand_id ) as Number_of_brand  from products
group by brand_id 
order by Number_of_brand asc ;

# 9) What’s the full name of a customer with ID 259?
select concat(first_name , " ",last_name )
from customers
where customer_id = 259 ;

#10) What did the customer on question 9 buy and when? What’s the status of this order?
select order_id  ,order_status ,order_date 
from orders 
where customer_id = 259  ;

#11) Which staff processed the order of customer 259? And from which store?
SELECT s.staff_id, st.store_id
from orders o
inner join staffs  s on o.staff_id = s.staff_id
inner join stores st ON o.store_id = st.store_id
where o.customer_id = 259;

#12) How many staff does BikeStore have? Who seems to be the lead Staff at BikeStore?
select count(*) as total_bikestore_staff
from staffs;
# the lead of staff at bikestore > staff_id  =1 ,, the name  >> Fabiola Jackson

# 13) Which brand is the most liked?
select p.brand_id, count(oritem.order_id) as total_orders
from order_items oritem
inner join products  p  on oritem.product_id = p.product_id
group by p.brand_id
order by total_orders desc
limit 1;

#14) How many categories does BikeStore have, and which one is the least liked?

SELECT COUNT(*) AS total_categories
FROM categories;
# the one of the least liked based on num of request
select category_id,count( oritem.order_id) as  total_orders
from order_items  oritem
inner join products  p on oritem.product_id = p.product_id
group by p.category_id 
order by total_orders asc 
limit 1 ;

#15) Which store still have more products of the most liked brand?
select p.brand_id , count(oritm.order_id ) as total_orders
from order_items oritm 
inner join products p on oritm.product_id = p.product_id
group by p.brand_id
order by total_orders desc 
limit 1;

#16) Which state is doing better in terms of sales?
select state, count(*) as total_customers
from customers
group by state
order by total_customers desc;
# so the  better state NY the total customers > 1019

#17 )What’s the discounted price of product id 259?
select product_id , discount 
from order_items
where product_id = 259 ;

#18)What’s the product name, quantity, price, category, model year and brand name of product number 44?
SELECT p.product_name,oritm.quantity,p.list_price,p.category_id,p.model_year,b.brand_name
from products  p 
inner join order_items   oritm on p.product_id = oritm.product_id
inner join brands         b    on p.brand_id     =   b.brand_id
where p.product_id = 44; 

#19)What’s the zip code of CA?
select zip_code , state
from stores
where state = 'ca'  ;

#20)How many states does BikeStore operate in?     ***************
select count(distinct state)   num_of_state
from stores;



#21)How many bikes under the children category were sold in the last 8 months?

#?????

#22) What’s the shipped date for the order from customer 523?
select CONCAT(cs.first_name, ' ', cs.last_name) AS Full_name, ord.shipped_date
from orders as ord
inner join customers AS cs on cs.customer_id = ord.customer_id
where ord.customer_id = 523;


#23) How many orders are still pending? where order status = 1 is pending
select order_status, COUNT(order_id) as total_orders_pending
from orders
where order_status = 1
group by order_status;


#24) What’s the names of category and brand does "Electra white water 3i - 2018" fall under?
select cs.category_name category, bd.brand_name brand, 
pd.product_name product, pd.model_year  model_Year
from products as pd
inner join categories  cs on pd.category_id = cs.category_id
inner join brands  bd on pd.brand_id = bd.brand_id
where pd.product_name = 'Electra white water 3i-2018';
