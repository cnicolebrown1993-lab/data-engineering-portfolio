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
