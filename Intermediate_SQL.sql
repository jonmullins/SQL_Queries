Select
CategoryName
,TotalProducts = count(*)
From Products
Join Categories
on Products.CategoryID = Categories.CategoryID
Group by
CategoryName
Order by
 count(*) desc


Select
Country
,City
,TotalCustomer = Count(*)
From Customers
Group by
Country
,City
Order by 
count(*) desc


Select
ProductID
,ProductName
,UnitsInStock
,ReorderLevel
From Products
Where
UnitsInStock <= ReorderLevel
Order by ProductID


Select
ProductID
,ProductName
,UnitsInStock
,UnitsOnOrder
,ReorderLevel
,Discontinued
From Products
Where
UnitsInStock + UnitsOnOrder <= ReorderLevel
and Discontinued = 0
Order by ProductID


Select
CustomerID
,CompanyName
,Region
From Customers
Order By
Case
when Region is null then 1
else 0
End
,Region
,CustomerID


Select Top 3
ShipCountry
,AverageFreight = Avg(freight)
From Orders
Group By ShipCountry
Order By AverageFreight desc;
Select Top 3
ShipCountry
,AverageFreight = avg(freight)
From Orders
Where
OrderDate >= '20150101'
and OrderDate < '20160101'
Group By ShipCountry
Order By AverageFreight desc;Select TOP (3)
ShipCountry
,AverageFreight = Avg(freight)
From Orders
Where
OrderDate >= Dateadd(yy, -1, (Select max(OrderDate) from Orders))
Group by ShipCountry
Order by AverageFreight desc;


Select
Employees.EmployeeID
,Employees.LastName
,Orders.OrderID
,Products.ProductName
,OrderDetails.Quantity
From Employees
join Orders
on Orders.EmployeeID = Employees.EmployeeID
join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
join Products
on Products.ProductID = OrderDetails.ProductID
Order by
Orders.OrderID
,Products.ProductIDSelect
Customers_CustomerID = Customers.CustomerID
,Orders_CustomerID = Orders.CustomerID
From Customers
left join Orders
on Orders.CustomerID = Customers.CustomerID
Where
Orders.CustomerID is null


Select
Customers.CustomerID
,Orders.CustomerID
From Customers
left join Orders
on Orders.CustomerID = Customers.CustomerID
and Orders.EmployeeID = 4
Where
Orders.CustomerID is null


