create table Publishers(
	ID int primary key identity(1, 1),
	Name nvarchar(255) not null unique,
	Address nvarchar(255) not null unique
);

create table Categories(
	ID int primary key identity(1, 1),
	Name nvarchar(255) not null unique
);

create table Authors(
	ID int primary key identity(1, 1),
	Name varchar(255) not null unique
);

create table Books(
	Code varchar(20) primary key,
	Name varchar(255) not null,
	Description ntext,
	PublishYear int not null check(PublishYear <= Getdate()),
	NumberOfPublish int not null check(NumberOfPublish >= 1),
	Price decimal(12, 4) not null check(Price >= 0),
	Qty int not null check(Qty >= 1),
	CategoryID int not null foreign key references Categories(ID),
	PublisherID int not null foreign key references Publishers(ID)
);

create table BookAuthors(
	BookCode varchar(20) not null foreign key references Books(Code),
	AuthorID int not null foreign key references Authors(ID)
);

drop table BookAuthors;
drop table Books;
drop table Authors;
drop table Categories;
drop table Publishers;