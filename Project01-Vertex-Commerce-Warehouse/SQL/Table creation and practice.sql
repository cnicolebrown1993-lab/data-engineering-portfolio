create database vertexcommercedb
go
use vertexcommerceDB
go
Create Table customers ( 
	CustomerID int identity(1,1) primary key,
	FirstName varchar(50) not null, 
	LastName varchar(50) not null,
	Email varchar(100) not null, 
	Phone varchar(20),
	StreetAddress varchar (150),
	City varchar (75),
	State varchar(2),
	ZipCode varchar(10),
	DateofBirth Date,
	CreateDate DATETIME Default GETDATE()
	);
	Go 
	Insert into customers
	(
		FirstName,
		LastName,
		Email,
		Phone,
		StreetAddress,
		City,
		State,
		ZipCode,
		DateofBirth
	)
	Values
	(
		'Faelen',
		'Brown',
		'Katonakatsuki@yahoo.com',
		'555-123-4567',
		'123 Main Street',
		'Dallas',
		'TX',
		'75001',
		'1995-05-12'
	);
Insert into customers
(
	FirstName,
    LastName,
    Email,
    Phone,
    StreetAddress,
    City,
    State,
    ZipCode,
    DateOfBirth
)
Values
('John','Smith','john@email.com','555-111-1111','456 Oak St','Austin','TX','73301','1988-03-15'),

('Sarah','Johnson','sarah@email.com','555-222-2222','789 Pine Ave','Miami','FL','33101','1992-11-08'),

('Michael','Davis','mike@email.com','555-333-3333','22 Elm Rd','Dallas','TX','75201','1985-07-19'),

('Emily','Wilson','emily@email.com','555-444-4444','101 Maple Dr','Seattle','WA','98101','1997-02-25');

INSERT INTO Customers
(
    FirstName,
    LastName,
    Email,
    Phone,
    StreetAddress,
    City,
    State,
    ZipCode,
    DateOfBirth
)
VALUES
('Ava','Martinez','ava.martinez@email.com','555-101-0001','221 Cedar St','Phoenix','AZ','85001','1994-04-18'),
('Noah','Williams','noah.williams@email.com','555-101-0002','88 Lake Dr','Denver','CO','80201','1989-09-22'),
('Sophia','Garcia','sophia.garcia@email.com','555-101-0003','19 Hill Ave','Austin','TX','73301','1991-12-05'),
('Liam','Anderson','liam.anderson@email.com','555-101-0004','402 River Rd','Chicago','IL','60601','1984-06-11'),
('Mia','Thomas','mia.thomas@email.com','555-101-0005','73 Sunset Blvd','Los Angeles','CA','90001','1998-01-29'),
('Ethan','Moore','ethan.moore@email.com','555-101-0006','14 Pinecrest Ln','Dallas','TX','75201','1979-03-08'),
('Isabella','Jackson','isabella.jackson@email.com','555-101-0007','950 Market St','Atlanta','GA','30301','1996-10-14'),
('Lucas','White','lucas.white@email.com','555-101-0008','300 Ocean Ave','Miami','FL','33101','1987-07-30'),
('Amelia','Harris','amelia.harris@email.com','555-101-0009','61 North St','Seattle','WA','98101','1993-02-17'),
('Mason','Clark','mason.clark@email.com','555-101-0010','742 West End','Nashville','TN','37201','1982-11-03'),
('Harper','Lewis','harper.lewis@email.com','555-101-0011','18 Willow Way','Boston','MA','02101','1999-05-24'),
('Logan','Young','logan.young@email.com','555-101-0012','125 Park Ave','New York','NY','10001','1990-08-19'),
('Evelyn','King','evelyn.king@email.com','555-101-0013','87 Ridge Rd','Orlando','FL','32801','1986-12-12'),
('James','Scott','james.scott@email.com','555-101-0014','43 Spruce Ct','Houston','TX','77001','1975-04-04'),
('Charlotte','Green','charlotte.green@email.com','555-101-0015','209 Main St','Portland','OR','97201','1997-09-09');

select 
	state,
	count (*)  as TotalCustomers
from customers
Group by state
Order by TotalCustomers desc;

Select FirstName, LastName, State, DateofBirth
from customers
where state= 'FL'
or state= 'TX';

Select FirstName, LastName, State, DateofBirth
from customers
where state in ('TX','FL','CA','WA')
Order by state asc;

Select FirstName, LastName, DateofBirth
From customers
Where DateofBirth < '1990-01-01'
Order by DateofBirth asc;

Select FirstName, LastName, State, DateofBirth
from customers
where DateofBirth > '1990-01-01'
and state in ('TX','FL')
order by DateofBirth desc;

Select 
	City,
	count(*) as TotalCustomers
	From Customers 
Group by city
Order by TotalCustomers DESC;

--Question: "I need a list of all customers whose last names begin with the letter J."
Select firstname, lastname, city, state
from customers
where LastName like 'j%'
order by lastname asc 

--Question: which names appear more than once?
Select
	lastname,
	count(*) as LastNameCount
from customers
group by lastname
Having count(*)  >1

--add customer
INSERT INTO Customers
(
    FirstName,
    LastName,
    Email,
    Phone,
    StreetAddress,
    City,
    State,
    ZipCode,
    DateOfBirth
)
VALUES
('Matthew','Rowle', 'mrowle@gmail.com','254-777-6589', '705 main car rd', 'Austin', 'TX', '76522', '1993-03-12');

--Update new customer's last name
select * 
from customers
where FirstName = ' Matthew'
	and LastName = 'Rowle';
--confirmed one row 
Update customers
set LastName ='Wilson'
Where FirstName = 'Matthew'
	and LastName = 'Rowle';
--verification
Select * 
from customers
where FirstName = 'Matthew'
	and LastName = 'Wilson'

--Question: which names appear more than once?
Select
	lastname,
	count(*) as LastNameCount
from customers
group by lastname
Having count(*)  >1

--I need a list of every customer born during the 1990s.

select firstname, lastname, dateofbirth
from customers
where DateofBirth between '1990-01-01' and '1999-12-31'
order by DateofBirth asc

--Show all states customers live in, occurance once

Select distinct State
from customers
order by state asc
--"I only want customers who live in either Texas or Florida and whose last name starts with the letter 'W'."

select FIRStname, lastname, state
from customers	
where state in ('FL','TX')
and LastName like 'w%'
order by lastname asc, firstname asc; 
