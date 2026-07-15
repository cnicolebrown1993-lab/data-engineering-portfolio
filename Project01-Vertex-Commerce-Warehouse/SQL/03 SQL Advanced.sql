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