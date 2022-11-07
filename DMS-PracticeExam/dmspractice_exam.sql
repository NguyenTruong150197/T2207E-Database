-- 2.
create table Categories(
	CateID char(6) primary key,
	CateName nvarchar(100) not null unique,
	Description nvarchar(200)
);

create table Parts(
	PartID int primary key identity(1, 1),
	PartName nvarchar(100) not null,
	CateID char(6) foreign key references Categories(CateID),
	Description nvarchar(1000),
	Price money not null check(Price >= 0) default 0,
	Quantity int check(Quantity >= 0) default 0,
	Warranty int check(Warranty >= 1) default 1,
	Photo nvarchar(200) check(Photo like 'photo/%') default 'photo/nophoto.png'
);

-- 3.
insert into Categories(CateID, CateName, Description)
values('UX9702', N'Máy tính Zenbook 17 Fold CPU', N'Bộ vi xử lý lên đến Intel Core i7 thế hệ thứ 12'),
('UX8402', N'Máy tính Zenbook Pro 14 Duo', N'Máy tính xách tay đạt chứng nhận Intel Evo'),
('UX7602', N'CPU', N'Bộ vi xử lý lên đến Intel Core i9 thế hệ thứ 12');

insert into Parts(PartName, CateID, Description, Price, Quantity, Warranty, Photo)
values(N'Đồ họa GeForce RTX 3050 Ti', 'UX9702', N'Ổ cứng lên đến 2 TB SSD', 2000, 2, 5, 'photo/photo01'),
(N'Đồ họa GeForce RTX 3060 Ti', 'UX8402', N'Đồ họa', 1500, 3, 3, 'photo/photo02'),
(N'Đồ họa GeForce RTX 3090 Ti', 'UX7602', N'Ổ cứng lên đến 2 TB SSD', 90, 4, 7, 'photo/photo03');

-- 4.
select * from Parts where Price > 100;

-- 5.
select * from Parts where CateID in (select CateID from Categories where CateName like '%CPU%');

-- 6.
create view v_Parts
as select distinct PartID, PartName, CateName, Price, Quantity from Parts a right join Categories b on a.CateID = b.CateID;

-- 7.
create view v_TopParts
as select top 5 * from Parts order by Price desc;