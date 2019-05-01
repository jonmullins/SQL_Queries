Select *
From Shippers


Select CategoryName
,Description
from Categories


Select
FirstName
,LastName
,HireDate
From Employees
Where Title = 'Sales Representative'


Select
FirstName
,LastName
,HireDate
From Employees
Where Title = 'Sales Representative'and Country = 'USA'


Select
OrderID
,OrderDate
From Orders
Where EmployeeID = 5


Select
SupplierID
,ContactName
,ContactTitle
From Suppliers
Where ContactTitle <> 'Marketing Manager'


Select
ProductID
,ProductName
From Products
Where ProductName like '%queso%'


Select
OrderID
,CustomerID
,ShipCountry
From Orders
where ShipCountry = 'France' or ShipCountry = 'Belgium'Select
OrderID
,CustomerID
,ShipCountry
From Orders
where
ShipCountry in
 (
 'Brazil'
 ,'Mexico'
 ,'Argentina'
 ,'Venezuela')


Select
FirstName
,LastName
,Title
,BirthDate
From Employees
Order By Birthdate


Select
FirstName
,LastName
,Title
,DateOnlyBirthDate = convert(date, BirthDate)
From Employees
Order By Birthdate


Select
FirstName
,LastName
,FullName = FirstName + ' ' + LastName
From EmployeesSelect
OrderID
,ProductID
,UnitPrice
,Quantity
,TotalPrice = UnitPrice * Quantity
From OrderDetails
Order by
OrderID
,ProductID

Select
TotalCustomers = count(*)
from CustomersSelect
FirstOrder = min(OrderDate)
From OrdersSelect
Country
From Customers
Group by Country

Select
ContactTitle
,TotalContactTitle = count(*)
From Customers
Group by
ContactTitle
Order by
count(*) desc


Select
ProductID
,ProductName
,Supplier = CompanyName
From Products
Join Suppliers
on Products.SupplierID = Suppliers.SupplierID

Select
OrderID
,OrderDate = convert(date, OrderDate)
,Shipper = CompanyName
From Orders
join Shippers
on Shippers.ShipperID = Orders.ShipVia
Where OrderID < 10300
Order by OrderID
