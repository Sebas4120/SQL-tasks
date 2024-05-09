Use my_guitar_shop;

Select *
From categories
Order by category_id;
Select *
From products
Order by category_id;

Select category_name,product_name,list_price-- , C.category_id
From categories C JOIN products P
	On C.category_id=P.category_id
Order by category_name,product_name;

Select *
From addresses;

Select *
From customers;

Select first_name,last_name,line1,city,state,zip_code--  email_address, c.customer_id
From customers c JOIN addresses a USING (customer_id)
    Where email_address = "allan.sherwood@yahoo.com";

Select first_name,last_name,line1,city,state,zip_code-- ,c.shipping_address_id,a.address_id
From customers c JOIN addresses a 
	ON c.shipping_address_id=a.address_id;
    
Select last_name,first_name,order_date,product_name,item_price,discount_amount,quantity
From customers c JOIN orders o 
		ON c.customer_id=o.customer_id
	JOIN order_items oi
		ON o.order_id=oi.order_id
	JOIN products p
		ON oi.product_id=p.product_id
Order by last_name,order_date,product_name;

Select *
From products;

Select P1.product_name,P1.list_price
From products P1 JOIN products 	P2
	ON P1.list_price=P2.list_price
    WHERE P1.product_id<>P2.product_id;

-- 6

Select category_name
From categories;

Select product_id
From products;

Select *
From categories;

Select *
From products;

SELECT c.category_name, p.product_id
FROM categories c LEFT JOIN products p 
	ON c.category_id = p.category_id
	where p.product_id IS NULL;

Select *
From orders;

Select order_id,order_date, 'SHIPPED' as "Ship_status"
From orders
WHERE ship_date IS NOT NULL
UNION
Select order_id,order_date, 'NOT SHIPPED' as "Ship_status"
From orders
WHERE ship_date IS NULL
ORDER BY order_date;

