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


