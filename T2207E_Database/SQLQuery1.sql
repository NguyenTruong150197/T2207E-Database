create table Categories(
	ID int primary key,
	Name varchar(255)
);

create table Publishers(
	ID int primary key,
	Name varchar(255),
	Address varchar(255)
);

create table Authors(
	ID int primary key,
	Name varchar(255)
);

create table Books(
	Code varchar(20) primary key,
	Name varchar(255),
	Description text,
	PublishYear int,
	NumberOfPublish int,
	Price decimal(12,4),
	Qty int,
	CategoryID int foreign key references Categories(ID),
	PublisherID int foreign key references Publishers(ID)
);

create table BookAuthors(
	BookCode varchar(20) foreign key references Books(Code),
	AuthorID int foreign key references Authors(ID)
);

drop table Categories;