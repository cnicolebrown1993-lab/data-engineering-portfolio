--Window function
--Create a leaderboard for highest spender, and order from highest to lowest
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
    TotalSpent,
    ROW_NUMBER() OVER
    (
        ORDER BY TotalSpent DESC
    ) AS CustomerRank
FROM CustomerSummary;