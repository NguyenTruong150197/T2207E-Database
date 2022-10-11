create table Subjects(
	Code int primary key,
	Name varchar(255)
);

create table Classes(
	Code int primary key,
	Name varchar(255),
	Room varchar(10)
);

create table Students(
	Code int primary key,
	Name varchar(255),
	Birthday date,
	ClassCode int foreign key references Classes(Code)
);

create table StudentSubjects(
	StudentCode int foreign key references Students(Code),
	SubjectCode int foreign key references Subjects(Code)
);

create table Results(
	ID int primary key,
	Mark int,
	Result varchar(255),
	StudentCode int foreign key references Students(Code),
	SubjectCode int foreign key references Subjects(Code)
);