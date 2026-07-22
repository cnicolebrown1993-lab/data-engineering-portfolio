use vertexcommercedb
go

select*from orders
--subqueries
--Write a query that returns every customer who has placed at least one order larger than the average order
Select
	c.firstname,
	c.lastname, 
	o.TotalAmount
from customers as c
inner join orders as o
	on c.CustomerID = o.CustomerID
Where o.TotalAmount > 
(
	select AVG(totalamount)
	from orders
);
--Show customers whose total spending is greater than the average customer spending.
SELECT
    c.FirstName,
    c.LastName,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING SUM(o.TotalAmount) >
(
    SELECT AVG(CustomerTotal)
    FROM
    (
        SELECT
            CustomerID,
            SUM(TotalAmount) AS CustomerTotal
        FROM Orders
        GROUP BY CustomerID
    ) AS CustomerSpending
);
--
select * from orders;

select *
from
(
    select 
        c.customerid,
       sum(o.totalamount) as totalspent
    from customers as c
    inner join orders as o
        on c.customerid = o.CustomerID
    group by
        c.CustomerID
    ) as CustomerTotals;

--CTE
;With NumberofOrders as
(
    select
       customerid,
        count(OrderID) as NumberofOrders
    from orders
    group by CustomerID
)
Select * 
from NumberofOrders;

;with CustomerTotals as
 (
    select
        customerid,
        sum(totalamount) as totalSpent
    from orders
    group by customerid
)Select 
    Customerid,
    avg(totalSpent) as averagespent
from CustomerTotals
where totalSpent >
(
    select AVG(TotalSpent)
    From CustomerTotals
); 

with CustomerSummary as
(
    select
        customerid,
        sum(totalamount) as totalspent,
        Count(OrderID) as numberoforders
    from orders
    group by customerid
) 
select
    customerid,
    numberoforders,
    totalspent
from CustomerSummary
where numberoforders >=2
and totalspent >
(
    select avg(totalspent)
    from customersummary
);
---
;With CustomerSummary as
(   
    Select 
        customerid,
        sum(TotalAmount) as TotalSpent,
        count(orderid) as NumberofOrders,
        Avg(totalamount) as AverageOrderAmount
    from orders
    group by customerid
)
select* 
from CustomerSummary; 

--build reusable dataset of customer spending then show only customers whose total spending is above the average customer

; with CustomerSummary as
( 
    select
        customerid,
        count (orderid) as NumberofOrders,
        sum(totalamount) as TotalSpent,
        avg(totalamount) as AverageofAmount
    from orders
    group by customerid
) 
select
    customerid,
    totalspent
from CustomerSummary
where TotalSpent >
(
    select avg(totalspent)
    from CustomerSummary
);
-- Can you build a resusable dataset to investigate customer behavior?

;WITH CustomerSummary AS
(
    SELECT
        CustomerID,
        COUNT(OrderID) AS NumberOfOrders,
        SUM(TotalAmount) AS TotalSpent,
        MAX(TotalAmount) AS LargestOrder
    FROM Orders
    GROUP BY CustomerID
)
SELECT *
FROM CustomerSummary;

--Build a resuable dataset for least 2 orders places, and a total spend greater than the customer average

;with CustomerSummary as
(
    select
        CustomerID,
        count(OrderID) as NumberOfOrders,
        Sum(TotalAmount) as TotalSpent,
        min(TotalAmount) as SmallestOrder
    from orders
    group by customerid
)Select
    Customerid,
    NumberOfOrders,
    TotalSpent,
    SmallestOrder
 from CustomerSummary
 where numberoforders >=2
 and totalspent >
(
    select avg(totalspent) 
    from customersummary
);
--build a dataset that showd most engaged customers, primarily to identify ordering frequency

; with CustomerActivity as
(
    select
        Customerid,
        count(orderid) as NumberofOrders,
        max(TotalAmount) as LargestOrders,
        Min(TotalAmount) as SmallesOrder
    from orders
    Group by CustomerID
)
Select
    CustomerID,
    NumberofOrders,
    LargestOrders,
    SmallesOrder
From CustomerActivity
where NumberofOrders >=2; 

-- Build a reusable dataset then show only customers whose total spending is great than the aveage customer total

;with CustomerSummary as 
(
    select
        Customerid,
        count(orderid) as NumberofOrders,
        Sum(totalAmount) as TotalSpent,
        Max(totalAmount) as LargestOrder,
        Min(TotalAmount) as SmallestOrder
    from orders
    group by customerid
) 
    select
        customerid,
        totalspent,
        NumberofOrders
    from Customersummary
    where totalspent>
(
select avg(totalspent)
from customersummary
);
    
--identify who customers are for a campagin, replace id with names

;WITH CustomerSummary AS
(
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        COUNT(o.OrderID) AS NumberOfOrders,
        SUM(o.TotalAmount) AS TotalSpent
    FROM Customers AS c
    LEFT JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)
SELECT
    CustomerID,
    FirstName,
    LastName,
    NumberOfOrders,
    TotalSpent
FROM CustomerSummary
WHERE TotalSpent >
(
    SELECT AVG(TotalSpent)
    FROM CustomerSummary
);
--Show customers who have placed more than the average customer
;WITH CustomerSummary AS
(
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        COUNT(o.OrderID) AS NumberOfOrders,
        SUM(o.TotalAmount) AS TotalSpent
    FROM Customers AS c
    LEFT JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)
SELECT
    FirstName,
    LastName,
    NumberOfOrders
FROM CustomerSummary
WHERE NumberOfOrders >
(
    SELECT AVG(NumberOfOrders)
    FROM CustomerSummary
);
--identify customers who are frequent and high value
;WITH CustomerSummary AS
(
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        COUNT(o.OrderID) AS NumberOfOrders,
        SUM(o.TotalAmount) AS TotalSpent
    FROM Customers AS c
    LEFT JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)
SELECT
    FirstName,
    LastName,
    NumberOfOrders,
    TotalSpent
FROM CustomerSummary
WHERE NumberOfOrders >
(
    SELECT AVG(NumberOfOrders)
    FROM CustomerSummary
)
AND TotalSpent >
(
    SELECT AVG(TotalSpent)
    FROM CustomerSummary
);
--Identify customers for a loytalty program
; with CustomerSummary as 
(
    select 
        c.customerid,
        c.firstname,
        c.lastname,
        count(o.orderid) as NumberofOrders,
        sum(o.TotalAmount) as TotalSpent
    from customers as c
    left join orders as o
        on c.customerid = o.orderid
    group by 
        c.customerid,
        c.firstname,
        c.lastname
),
HighValueCustomers as 
( 
    select
        customerid,
        firstname,
        lastname,
        NumberofOrders,
        TotalSpent
    from CustomerSummary
    Where TotalSpent >
    ( 
        select AVG(TotalSpent)
        from CustomerSummary
    )
)

Select 
    firstname,
    lastname,
    numberoforders,
    totalspent
from HighValueCustomers;

--Build a data set that cleanly reports customers who are both active and inactive
;WITH CustomerSummary AS
(
    SELECT 
        c.CustomerID,
        c.FirstName,
        c.LastName,
        COUNT(o.OrderID) AS NumberOfOrders,
        SUM(o.TotalAmount) AS TotalSpent
    FROM Customers AS c
    LEFT JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    GROUP BY 
        c.CustomerID,
        c.FirstName,
        c.LastName
),
QualifiedCustomers AS
(
    SELECT
        FirstName,
        LastName,
        NumberOfOrders,
        TotalSpent
    FROM CustomerSummary
    WHERE NumberOfOrders >= 2
      AND TotalSpent >
      (
          SELECT AVG(TotalSpent)
          FROM CustomerSummary
      )
)
SELECT 
    FirstName,
    LastName,
    NumberOfOrders,
    TotalSpent
FROM QualifiedCustomers
ORDER BY TotalSpent DESC;    
    
