create table Tels(
	ID int primary key,
	PhoneNumber varchar(14) not null unique
);

create table Contacts(
	ID int primary key,
	Name nvarchar(50) not null,
	Address nvarchar(255) not null,
	Birth date not null,
	TelID int foreign key references Tels(ID)
);

drop table Contacts;
drop table Tels;