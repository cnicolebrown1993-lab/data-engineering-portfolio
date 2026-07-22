--SQL Warmup 
--show customers who live in california, first and last name
select firstname, lastname
from customers
where state = 'CA';

--How many customers in each state

select  
	state, 
	count (CustomerID) as CustomerCount
from customers
group by state;

--How many states have more than one customer
Select 
	state,
	count(customerid) as CustomerCount
from customers
group by state
having count(customerid) >1;

--update customer id 4 to be tx
Select CustomerID, state
from customers
where CustomerID = 4


Update customers
set state = 'FL'
from customers
where CustomerID = 4
	
select customerid,State
from customers
where CustomerID =4

---How many cities do we have cutomers in?
Select distinct
Count (City) as NumberOfCities
from customers;

--show every unique zip code sort from lowest to highest
select distinct 
	zipcode
from customers
order by zipcode asc,

--show every customer whos first name ends with a "Y"

select
	firstname,
	lastname
from customers
where FirstName like '%y'

--Show every customer whose last name contains "son".
select
	firstname,
	lastname
from customers
where LastName like '%son%'

--Show customers who: live in TX, FL, or CA and whose last name starts with "B" or "W" Sort by: State and LastName 
select 
	firstname,
	lastname,
	state
from customers
where state in ('TX','FL','CA')
	and (
	LastName like 'b%' 
	or lastname like 'w%'
	)
Order by state,
	LastName;

--7/10/2026 review and practice
--Show the first name, last name, state, and total amount of every customer that has placed an order. Sort by TotalAmount from highest to lowest.
--forgot column names
Select *
from orders

Select 
	c.firstname,
	c.lastname,
	c.state,
	o.totalamount
from customers as c
inner join orders as o
	on c.CustomerID = o.CustomerID
order by o.TotalAmount desc;
--select every customer who has neber placed an order
Select
	c.firstname,
	c.lastname,
	c.state,
from customers as c
left join orders as o
	on c.CustomerID=o.CustomerID
where o.CustomerID is null;
--Show every state and total sales generate from that state
select
	c.state,
	sum(o.totalamount) as TotalSales
from customers as c
left join orders as o
	on c.CustomerID=o.customerid
group by c.State
order by sum(o.totalamount) desc;

--Find customers whose average order is greater than 300
select
	c.firstname,
	c.lastname,
	c.customerid,
	avg(o.totalamount) as AverageOrder
from customers as c
left join orders as o
	on c.CustomerID=o.CustomerID
group by 
	c.CustomerID,
	c.FirstName,
	c.LastName
having Avg(o.totalamount) >300;
-- 	"Which states have the highest average customer spending?"
SELECT
    CustomerSpending.State,
    AVG(CustomerSpending.TotalCustomerSpend) AS AverageCustomerSpend
FROM
(
    SELECT
        c.CustomerID,
        c.State,
        SUM(o.TotalAmount) AS TotalCustomerSpend
    FROM Customers AS c
    INNER JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    GROUP BY
        c.CustomerID,
        c.State
) AS CustomerSpending
GROUP BY CustomerSpending.State
ORDER BY AverageCustomerSpend DESC;
--Right, Full outer, Self join
create table democustomers
(
	customerID int primary key, 
	customerName varchar(50)
);

Create Table DemoOrders
(
	OrderID int primary key, 
	CustomerID int,
	TotalAmount Decimal(10,2)
); 

INSERT INTO DemoCustomers (CustomerID, CustomerName)
VALUES
(1, 'Amy'),
(2, 'Bob'),
(3, 'Charlie');

Insert into DemoOrders (OrderID, customerID, TotalAmount)
values
(101, 1, 100.00),
(102, 2, 200.00),
(103, 999, 250.00);

--table check
--inner join
select
	c.customerid,
	c.customername, 
	o.orderid,
	o.totalamount
from democustomers as c
inner join DemoOrders as o
	on c.customerID=o.CustomerID;
--left join
select
	c.customerid,
	c.customername,
	o.orderid,
	o.totalamount
from democustomers as c
left join demoorders as o
	on c.customerid = o.customerid;
--right join
select 
	c.customerid,
	c.customername, 
	o.orderid,
	o.customerid as ordercustomerid,
	o.totalamount
from democustomers as c
right join DemoOrders as o
	on c.customerID=o.CustomerID; 
--full outer join
select
	c.customerid,
	c.customername,
	o.orderid,
	o.customerid as ordercustomerid,
	o.totalamount
from democustomers as c
full outer join DemoOrders as o
	on c.customerID = o.CustomerID;
--remove demo tables
drop table DemoOrders;
drop table democustomers;

--Buidling new tables for full outer join
create table DemoCustomers
(
	CustomerID int primary key,
	CustomerName VarChar(50)
);

Create Table DemoOrders
(
	OrderID int primary key,
	CustomerID int,
	TotalAmount Decimal(10,2)
);

INSERT INTO DemoCustomers
VALUES
(1,'Amy'),
(2,'Bob'),
(3,'Charlie');

INSERT INTO DemoOrders
VALUES
(101,1,100),
(102,2,250),
(103,999,500);

Select
	c.customerID,
	c.CustomerName,
	o.orderid,
	o.customerid as OrderCustomerID,
	o.totalamount
from DemoCustomers as c
full outer join DemoOrders as o
	on c.CustomerID = o.CustomerID;

Select
	c.CustomerID,
	c.CustomerName,
	o.OrderID,
	o.CustomerID as OrderCustomerID,
	o.TotalAmount 
from DemoCustomers as c
full outer join DemoOrders as o
	on c.CustomerID =  o.CustomerID
where
	c.CustomerID is null
	or
	o.OrderID is null;
--self joins

	
