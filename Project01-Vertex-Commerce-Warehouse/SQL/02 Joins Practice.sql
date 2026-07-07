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