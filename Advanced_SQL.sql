Select
Customers.CustomerID
,Customers.CompanyName
,Orders.OrderID
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
,Orders.Orderid
Having Sum(Quantity * UnitPrice) > 10000
Order by TotalOrderAmount DESC


Select
Customers.CustomerID
,Customers.CompanyName
--,Orders.OrderID
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
--,Orders.Orderid
Having sum(Quantity * UnitPrice) > 15000
Order by TotalOrderAmount desc;


Select
Customers.CustomerID
,Customers.CompanyName
,TotalsWithoutDiscount = SUM(Quantity * UnitPrice)
,TotalsWithDiscount = SUM(Quantity * UnitPrice * (1- Discount))
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
Having sum(Quantity * UnitPrice * (1- Discount)) > 10000
Order by TotalsWithDiscount DESC;Select
EmployeeID
,OrderID
,OrderDate
From Orders
Where OrderDate = EOMONTH(OrderDate )
Order by
EmployeeID
,OrderIDSelect top 10
Orders.OrderID
,TotalOrderDetails = count(*)
From Orders
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Group By Orders.OrderID
Order By count(*) descSelect top 2 percent
OrderID
From Orders
Order By NewID()Select
OrderID
From OrderDetails
Where Quantity >= 60
Group By
OrderID
,Quantity
Having Count(*) > 1;with PotentialDuplicates as (
Select
OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
 )
Select
OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
From OrderDetails
Where
OrderID in (Select OrderID from PotentialDuplicates)
Order by
OrderID
,QuantitySelect
OrderDetails.OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
From OrderDetails
Join (
Select distinct
OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
)PotentialProblemOrders
on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductIDSelect
OrderID
,OrderDate = convert(date, OrderDate)
,RequiredDate = convert(date, RequiredDate)
,ShippedDate = convert(date, ShippedDate)
From Orders
Where
RequiredDate <= ShippedDateSelect
Employees.EmployeeID
,LastName
,TotalLateOrders = Count(*)
From Orders
Join Employees
on Employees.EmployeeID = Orders.EmployeeID
Where
RequiredDate <= ShippedDate
Group By
Employees.EmployeeID
,Employees.LastName
Order by TotalLateOrders desc;With LateOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Where
RequiredDate <= ShippedDate
Group By
EmployeeID
)
,AllOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Group By
EmployeeID
)
Select
Employees.EmployeeID
,LastName
,AllOrders = AllOrders.TotalOrders
,LateOrders = LateOrders.TotalOrders
From Employees
Join AllOrders
on AllOrders.EmployeeID = Employees.EmployeeID
Join LateOrders
on LateOrders.EmployeeID = Employees.EmployeeID;With LateOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Where
RequiredDate <= ShippedDate
Group By
EmployeeID
)
, AllOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Group By
EmployeeID
)
Select
Employees.EmployeeID
,LastName
,AllOrders = AllOrders.TotalOrders
,LateOrders = LateOrders.TotalOrders
From Employees
Join AllOrders
on AllOrders.EmployeeID = Employees.EmployeeID
Left Join LateOrders
on LateOrders.EmployeeID = Employees.EmployeeID


;With LateOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Where
RequiredDate <= ShippedDate
Group By
EmployeeID
)
,AllOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Group By
EmployeeID
)
Select
Employees.EmployeeID
,LastName
,AllOrders = AllOrders.TotalOrders
,LateOrders = IsNull(LateOrders.TotalOrders, 0)
From Employees
Join AllOrders
on AllOrders.EmployeeID = Employees.EmployeeID
Left Join LateOrders
on LateOrders.EmployeeID = Employees.EmployeeID;With LateOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Where
RequiredDate <= ShippedDate
Group By
EmployeeID
)
,AllOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Group By
EmployeeID
)
Select
Employees.EmployeeID
,LastName
,AllOrders = AllOrders.TotalOrders
,LateOrders = IsNull(LateOrders.TotalOrders, 0)
,PercentLateOrders =
(IsNull(LateOrders.TotalOrders, 0) * 1.00) / AllOrders.TotalOrders
From Employees
Join AllOrders
on AllOrders.EmployeeID = Employees.EmployeeID
Left Join LateOrders
on LateOrders.EmployeeID = Employees.EmployeeID;With LateOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Where
RequiredDate <= ShippedDate
Group By
EmployeeID
)
,AllOrders as (
Select
EmployeeID
,TotalOrders = Count(*)
From Orders
Group By
EmployeeID
)
Select
Employees.EmployeeID
,LastName
,AllOrders = AllOrders.TotalOrders
,LateOrders = IsNull(LateOrders.TotalOrders, 0)
,PercentLateOrders =
Convert(
Decimal (10,2)
,(IsNull(LateOrders.TotalOrders, 0) * 1.00) / AllOrders.TotalOrders
)
From Employees
Join AllOrders
on AllOrders.EmployeeID = Employees.EmployeeID
Left Join LateOrders
on LateOrders.EmployeeID = Employees.EmployeeID;with Orders2016 as (
Select
Customers.CustomerID
,Customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
)
Select
CustomerID
,CompanyName
,TotalOrderAmount
,CustomerGroup =
Case
when TotalOrderAmount between 0 and 1000 then 'Low'
when TotalOrderAmount between 1001 and 5000 then 'Medium'
when TotalOrderAmount between 5001 and 10000 then 'High'
when TotalOrderAmount > 10000 then 'Very High'
End
from Orders2016
Order by CustomerID;with Orders2016 as (
Select
Customers.CustomerID
,Customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
)
Select
CustomerID
,CompanyName
,TotalOrderAmount
,CustomerGroup =
case
when TotalOrderAmount >= 0 and TotalOrderAmount < 1000 then 'Low'
when TotalOrderAmount >= 1000 and TotalOrderAmount < 5000 then 'Medium'
when TotalOrderAmount >= 5000 and TotalOrderAmount <10000 then 'High'
when TotalOrderAmount >= 10000 then 'Very High'
end
from Orders2016
Order by CustomerID;with Orders2016 as (
Select
Customers.CustomerID
,Customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
join Orders
on Orders.CustomerID = Customers.CustomerID
join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group By
Customers.CustomerID
,Customers.CompanyName
)
,CustomerGrouping as (
Select
CustomerID
,CompanyName
,TotalOrderAmount
,CustomerGroup =
case
when TotalOrderAmount >= 0 and TotalOrderAmount < 1000 then 'Low'
when TotalOrderAmount >= 1000 and TotalOrderAmount < 5000 then 'Medium'
when TotalOrderAmount >= 5000 and TotalOrderAmount <10000 then 'High'
when TotalOrderAmount >= 10000 then 'Very High'endfrom Orders2016
 -- Order by CustomerID
)
Select
CustomerGroup
, TotalInGroup = Count(*)
, PercentageInGroup = Count(*) * 1.0/ (select count(*) from CustomerGrouping)
from CustomerGrouping
group by CustomerGroup
order by TotalInGroup desc;with Orders2016 as (
Select
Customers.CustomerID
,Customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
From Customers
Join Orders
on Orders.CustomerID = Customers.CustomerID
Join OrderDetails
on Orders.OrderID = OrderDetails.OrderID
Where
OrderDate >= '20160101'
and OrderDate < '20170101'
Group by
Customers.CustomerID
,Customers.CompanyName
)
Select
CustomerID,CompanyName
,TotalOrderAmount
,CustomerGroupName
from Orders2016
Join CustomerGroupThresholds
on Orders2016.TotalOrderAmount between
CustomerGroupThresholds.RangeBottom and CustomerGroupThresholds.RangeTop
Order by CustomerIDSelect Country From Customers
Union
Select Country From Suppliers
Order by Country


;With SupplierCountries as
(Select Distinct Country from Suppliers)
,CustomerCountries as
(Select Distinct Country from Customers)
Select
SupplierCountry = SupplierCountries .Country
,CustomerCountry = CustomerCountries .Country
From SupplierCountries
Full Outer Join CustomerCountries
on CustomerCountries.Country = SupplierCountries.Country


;With SupplierCountries as
(Select Country , Total = Count(*) from Suppliers group by Country)
,CustomerCountries as
(Select Country , Total = Count(*) from Customers group by Country)
Select
Country = isnull( SupplierCountries.Country, CustomerCountries.Country)
,TotalSuppliers= isnull(SupplierCountries.Total,0)
,TotalCustomers= isnull(CustomerCountries.Total,0)
From SupplierCountries
Full Outer Join CustomerCountries
on CustomerCountries.Country = SupplierCountries.Country;with OrdersByCountry as
(
Select
ShipCountry
,CustomerID
,OrderID
,OrderDate = convert(date, OrderDate)
,RowNumberPerCountry =
Row_Number()
over (Partition by ShipCountry Order by ShipCountry, OrderID)
From Orders
)
Select
ShipCountry
,CustomerID
,OrderID
,OrderDate
From OrdersByCountry
Where
RowNumberPerCountry = 1
Order by
ShipCountrySelect
InitialOrder.CustomerID
,InitialOrderID = InitialOrder.OrderID
,InitialOrderDate = convert(date, InitialOrder.OrderDate)
,NextOrderID = NextOrder.OrderID
,NextOrderDate = convert(date, NextOrder.OrderDate)
,DaysBetween = datediff(dd, InitialOrder.OrderDate, NextOrder.OrderDate)
from Orders InitialOrder
join Orders NextOrder
on InitialOrder.CustomerID = NextOrder.CustomerID
where
InitialOrder.OrderID < NextOrder.OrderID
and datediff(dd, InitialOrder.OrderDate, NextOrder.OrderDate) <= 5
Order by
InitialOrder.CustomerID
,InitialOrder.OrderID;With NextOrderDate as (
Select
CustomerID
,OrderDate = convert(date, OrderDate)
,NextOrderDate =
convert(
date
,Lead(OrderDate,1)
OVER (Partition by CustomerID order by CustomerID, OrderDate)
)
From Orders
)
Select
CustomerID
,OrderDate
,NextOrderDate
,DaysBetweenOrders = DateDiff (dd, OrderDate, NextOrderDate)
From NextOrderDate
Where
DateDiff (dd, OrderDate, NextOrderDate) <= 5

