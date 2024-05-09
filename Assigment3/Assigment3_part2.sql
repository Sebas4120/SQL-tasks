Use my_guitar_shop;

Select *
From orders;
-- 11
Select COUNT(order_id) as "Number of orders",
	sum(tax_amount) as "Total taxes amount"
from orders;



Select *
From categories c Inner Join products p
	ON c.category_id=p.category_id;
-- 12
Select category_name,count(product_id) as 'Total_Products' ,max(list_price) as 'Max_list_price'
From categories c Inner Join products p
	ON c.category_id=p.category_id
group by c.category_id
order by Total_Products desc;




Select *
From customers c,order_items;
-- 13
Select c.email_address,SUM(oi.item_price * oi.quantity) AS total_item_price,
    SUM(oi.discount_amount * oi.quantity) AS total_discount_amount
From customers c JOIN orders o 
	ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_item_price DESC;



Select *
From orders;

Select *
From customers;
-- 14
Select c.email_address,count(o.order_id) as "Number_of_orders_per_customer",
sum((oi.item_price - oi.discount_amount)*oi.quantity) as "Total_amount_per_order"
From customers c JOIN orders o 
	ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id,c.email_address
having count(oi.order_id)>1
order by Total_amount_per_order desc;

Select *
From customers c JOIN orders o 
	ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id;
-- 15
Select c.email_address,count(DISTINCT o.order_id) as "Number_of_orders_per_customer",
sum((oi.item_price - oi.discount_amount)*oi.quantity) as "Total_amount_per_order"
From customers c JOIN orders o 
	ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
Where oi.item_price>400
GROUP BY c.customer_id,c.email_address
having count(DISTINCT oi.order_id)>1
order by Total_amount_per_order desc;

SELECT
  customers.email_address,
  COUNT(orders.order_id) AS order_count,
  SUM((order_items.item_price - order_items.discount_amount) * order_items.quantity) AS total_order_amount
FROM customers LEFT JOIN orders 
	ON customers.customer_id = orders.customer_id
	LEFT JOIN order_items 
    ON orders.order_id = order_items.order_id
WHERE order_items.item_price > 400
GROUP BY customers.email_address
HAVING order_count > 1
ORDER BY total_order_amount DESC;

SELECT
    c.email_address,
    COUNT(o.order_id) AS num_orders,
    SUM((CASE WHEN oi.item_price > 400 THEN (oi.item_price - oi.discount_amount) * oi.quantity ELSE 0 END)) AS total_amount
FROM
    customers c
INNER JOIN
    orders o ON c.customer_id = o.customer_id
INNER JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY
    c.email_address
HAVING
    num_orders > 1
ORDER BY
    total_amount DESC;
-- 16
Select p.product_name,sum((oi.item_price - oi.discount_amount)*oi.quantity) as "Total_amount_per_order"
From products p JOIN order_items oi
	ON p.product_id=oi.product_id
group by product_name WITH ROLLUP;

-- 17
Select email_address,count(DISTINCT oi.product_id) as "Distinct_prod_per_customer"
From customers c JOIN orders o 
	ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
group by c.customer_id
having count(distinct oi.product_id)>1
order by c.email_address asc;



-- 18
Select if(GROUPING(c.category_name) = 1, 'Grand Total', c.category_name) AS "category_name",
    if(GROUPING(p.product_name) = 1, 'Category Total', p.product_name) AS "product_name",
    SUM(oi.quantity) AS "total_quantity"
from categories c inner join products p 
	on c.category_id = p.category_id
    left join order_items oi
    on p.product_id = oi.product_id
group by c.category_name,p.product_name with rollup;



SELECT
    IF(GROUPING(category_name) = 1, 'Grand Total', category_name) AS category_name,
    IF(GROUPING(product_name) = 1, 'Category Total', product_name) AS product_name,
    SUM(quantity) AS total_quantity_purchased
FROM
    categories c
INNER JOIN
    products p ON c.category_id = p.category_id
LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
GROUP BY
    category_name, product_name
WITH ROLLUP;

-- 19

SELECT oi.order_id,
SUM((oi.item_price - oi.discount_amount) * oi.quantity) OVER (PARTITION BY oi.order_id) AS total_order_amount
FROM Order_Items oi
ORDER BY oi.order_id ASC;

-- 20
SELECT oi.order_id, SUM((oi.item_price - oi.discount_amount) * oi.quantity) 
OVER (PARTITION BY oi.order_id ORDER BY oi.order_id) AS cumulative_total, 
AVG((oi.item_price - oi.discount_amount) * oi.quantity) OVER (PARTITION BY oi.order_id) 
AS average_item_amount 
FROM Order_Items oi;

-- 21

SELECT o.customer_id, o.order_date,
	SUM(oi.item_price) OVER(PARTITION BY o.customer_id) AS total_amount_per_customer,
	SUM(SUM(oi.item_price)) OVER(PARTITION BY o.customer_id, o.order_date) AS total_amount_per_customer_by_date
FROM Orders o INNER JOIN Order_Items oi 
	ON o.order_id = oi.order_id
GROUP BY o.customer_id, o.order_date, oi.item_price;





