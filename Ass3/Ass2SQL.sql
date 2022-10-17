create table Customers(
	ID int primary key identity(1, 1),
	Name nvarchar(255) not null,
	Address nvarchar(255) not null,
	Tel varchar(15) not null unique check(Tel like '0%')
);

create table Products(
	ID int primary key identity(1, 1),
	Name nvarchar(100) not null unique,
	Description ntext,
	Unit nvarchar(50) not null check(Unit in (N'Chiếc', N'Cặp', N'Bộ')),
	Price decimal(12, 4) not null check(Price >= 0) default 0
);

create table Orders(
	ID int primary key identity(1, 1),
	OrderDate date not null check(OrderDate <= Getdate()),
	GrandTotal decimal(12, 4) not null check(GrandTotal >= 0),
	CustomerID int not null foreign key references Customers(ID)
);

create table OrderItems(
	Qty int not null check(Qty > 0),
	Total decimal(12, 4) not null check(Total >= 0),
	ProductID int not null foreign key references Products(ID),
	OrderID int not null foreign key references Orders(ID)
);