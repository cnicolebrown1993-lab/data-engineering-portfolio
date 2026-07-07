use vertexcommercedb
go

create table orders
(
	OrderID int IDENTITY(1,1) Primary Key,
	CustomerID INT not null, 
