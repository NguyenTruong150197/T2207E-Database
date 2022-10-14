create table Subjects(
	Code int primary key,
	Name varchar(255) not null unique
);

create table Classes(
	Code int primary key,
	Name varchar(255) not null unique,
	Room varchar(10)
);

create table Students(
	Code int primary key,
	Name varchar(255) not null,
	Birthday date not null check(Birthday < getdate()),
	ClassCode int foreign key references Classes(Code)
);

create table Results(
	ID int primary key identity(1, 1),
	Mark int not null check(Mark >= 0 and Mark <= 10) default 0,
	Result varchar(255) not null check(Result in (N'Yếu', N'Trung Bình', N'Khá', N'Giỏi', N'Xuất Xắc')),
	StudentCode int not null foreign key references Students(Code),
	SubjectCode int not null foreign key references Subjects(Code)
);

create table StudentSubjects(
	StudentCode int not null foreign key references Students(Code),
	SubjectCode int not null foreign key references Subjects(Code)
);