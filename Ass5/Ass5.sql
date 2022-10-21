create table Companys(
	ID int primary key,
	Name varchar(10) not null unique,
	Address varchar(10) not null unique,
	Tel varchar(12) not null unique
);

create table Products(
	ID int primary key,
	Name nvarchar(50) not null,
	Description nvarchar(50),
	Unit nvarchar(20) not null check(Unit in (N'Chiếc')),
	Price decimal(4, 0) not null,
	Qty int not null
);

create table CompanyProducts(
	CompanyID int not null foreign key references Companys(ID),
	ProductID int not null foreign key references Products(ID)
);