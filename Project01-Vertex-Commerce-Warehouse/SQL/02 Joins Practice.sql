use vertexcommercedb
go

create table orders
(
	OrderID int IDENTITY(1,1) Primary Key,
	CustomerID INT not null, 
	OrderDate Date not Null, 
	TotalAmount Decimal(10,2) Not null,

	CONSTRAINT fk_orders_customers
		Foreign Key(CustomerID)
		References Customers(customerID)
);

Insert into Orders (CustomerID, OrderDate, TotalAmount)
Values
(1,'2026-01-15',249.99),
(1,'2026-03-04',89.99),
(2,'2026-02-20',799.00),
(3,'2026-01-11',49.99),
(3,'2026-04-18',399.99),
(4,'2026-05-05',24.99),
(5,'2026-03-22',199.99),
(6,'2026-02-14',59.99),
(7,'2026-06-01',999.99),
(8,'2026-01-30',149.99);

Select *
From Orders;

Select 
	c.firstname,
	c.lastname,
	o.orderdate,
	o.totalamount
from customers as c
inner join orders as o
	on c.CustomerID = o.CustomerID; 

select 
	c.firstname,
	c.lastname,
	o.totalamount
from customers as c
inner join orders as o
	on c.customerid=o.CustomerID
Order by o.totalamount desc 

--joins warm up 
SELECT
    c.FirstName,
    c.LastName,
    o.TotalAmount
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;

	Select 
		c.firstname,
		c.lastname, 
		o.totalamount
	from customers as c
	inner join orders as o
		on c.customerid=o.CustomerID
	where o.TotalAmount >200
	order by o.TotalAmount desc

	select *
	from customers

	--Left join practice
	select
		c.firstname,
		c.lastname,
		o.totalamount
	from customers as c
	left join orders as o
		on c.CustomerID=o.CustomerID;
	--missing value (question, who are the customers who never ordered from us)
	select 
		c.firstname,
		c.lastname,
		o.totalamount
	from customers as c
	left join orders as o
		on c.customerid=o.customerid
	where o.totalamount is null

	select 
		c.firstname,
		c.lastname,
		sum(o.totalamount) as TotalSpent
	from customers as c
	left join orders as o
		on c.customerid=o.customerid
	group by 
		c.CustomerID,
		c.firstname,
		c.LastName;
	----Coalesce() to return 0 instead of a null
	select
		c.firstname,
		c.lastname,
		coalesce(sum(o.totalamount),0) as TotalSpent
	from customers as c
	left join orders as o
		on c.CustomerID=o.CustomerID
	group by 
		c.CustomerID,
		c.firstname,
		c.LastName
	order by TotalSpent desc
---how many order did each customer place
SELECT
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY NumberOfOrders DESC;

--Show top 5 customers by total spending 
Select top 5
	c.firstname,
	c.lastname,
	coalesce(sum (o.totalamount),0) as TotalSpending
from customers as c
left join orders as o
	on c.customerid = o.customerid
group by 
	c.customerid,
	c.firstname,
	c.lastname
order by TotalSpending desc;
---Challenge 1 only show customers who actually placed an order
select
	c.firstname,
	c.lastname,
	o.orderdate,
	o.totalamount
from customers as c
inner join orders as o
	on c.customerid = o.customerid
---Challenge 2 Show every customer who has placed more than one order
select
	c.firstname,
	c.lastname,
	count (o.orderid) as NumberOfOrders
from customers as c
inner join orders as o
	on c.customerid = o.customerid
group by 
	c.CustomerID,
	c.firstname,
	c.lastname
having count (o.OrderID) >1

---"Can you show me every customer and the total amount they've spent? I only care about customers who have spent more than $300."
--clarified "Show me only the customers whose total spending is greater than $300."
select 
	c.firstname,
	c.lastname,
	sum (o.totalamount) as TotalSpent
from customers as c
inner join orders as o
	on c.CustomerID = o.CustomerID
Group by 
	c.CustomerID,
	c.FirstName,
	c.LastName
having 
	sum(o.TotalAmount) >300

---Show every customer who has spent between $200 and $800 in total.
select 
	c.firstname,
	c.lastname,
	COALESCE(sum(o.totalamount),0) as TotalSpent
from customers as c
inner join orders as o
	on c.CustomerID = o.CustomerID
group by 
	c.CustomerID,
	c.FirstName,
	c.LastName
having 
	SUM(o.TotalAmount) BETWEEN 200 AND 800
Order by 
	TotalSpent desc; 

----Finance wants to know how many orders each customer has placed."
select
	c.firstname,
	c.lastname, 
	count(o.orderid) as NumberOfOrders
from customers as c
left join orders as o
	on c.CustomerID = o.CustomerID
group by 
	c.CustomerID,
	c.FirstName,
	c.lastname
order by 
	NumberOfOrders desc,
	c.lastname asc;

--Show customers that have placed 2 orders and spent more than 300 total
select 
	c.firstname, 
	c.lastname, 
	COUNT(o.orderid) as NumberOfOrders,
	sum(o.totalamount) as TotalAmountSpent
from customers as c
inner join orders as o
	on c.CustomerID = o.CustomerID
group by 
	c.customerid,
	c.firstname,
	c.lastname
having 
	Sum(o.totalamount) > 300
	and count(o.OrderID)>=2
Order by 
	TotalAmountSpent Desc,
	C.lastname asc;


