insert into Customers(Name, Address, Tel)
values(N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân', '0987654321');
insert into Customers(Name, Address, Tel)
values(N'Nguyễn Văn Trường', N'123 Nguyễn Trãi, Thanh Xuân', '0987654123');


insert into Products(Name, Description, Unit, Price)
values(N'Máy Tính T450', N'Máy nhập mới', N'Chiếc', 1000);

insert into Products(Name, Description, Unit, Price)
values(N'Điện Thoại Nokia5670', N'Điện thoại đang hot', N'Chiếc', 200);

insert into Products(Name, Description, Unit, Price)
values(N'Máy In Samsung450', N'Máy in đang ế', N'Chiếc', 100);

/*insert into Products(Name, Description, Unit, Price)
  values(N'Máy Tính T450', N'Máy nhập mới', N'Chiếc', 1000),
  (N'Điện Thoại Nokia5670', N'Điện thoại đang hot', N'Chiếc', 200),
  (N'Máy In Samsung450', N'Máy in đang ế', N'Chiếc', 100);
*/


insert into  Orders(OrderDate, GrandTotal, CustomerID)
values('2022-09-10', 1500, 1);
insert into  Orders(OrderDate, GrandTotal, CustomerID)
values('2022-09-10', 1500, 2);
insert into  Orders(OrderDate, GrandTotal, CustomerID)
values('2022-09-10', 2000, (select ID from Customers where Name like N'Nguyễn Văn An'));


insert into OrderItems(Qty, Total, ProductID, OrderID)
values(1, 1000, 1, 1),
(2, 400, 2, 1),
(1, 100, 3, 1);
insert into OrderItems(Qty, Total, ProductID, OrderID)
values(1, 1000, 1, 2),
(2, 400, 2, 2),
(1, 100, 3, 2);
insert into OrderItems(Qty, Total, ProductID, OrderID)
values(1, 1000, 1, 1),
(4, 800, 2, 1),
(2, 200, 3, 1);

select * from Customers;
select * from Products;
select * from Orders;
select * from OrderItems;

update Customers set Address = N'111 Nguyễn Trãi, Thanh Xuân'
where ID = 1;

delete from Customers;

-- Liệt kê
select * from Products; -- Liệt kê toàn bộ trong bảng Products
select ID, Name, Price from Products; -- Liệt kê 3 cột ID, Name, Price
select ID as Code, Name, Price from Products; -- Liệt kê 3 cột Code, Name, Price với ID được gán tên thành Code

-- Sắp xếp
select * from Products order by Price asc; -- Sắp xếp theo giá tiền từ thấp đến cao
select * from Products order by Price desc; -- Sắp xếp theo giá tiền từ cao đến thấp
select * from Products order by Price desc, Name asc; -- Sắp xếp theo giá tiền từ cao đến thấp và theo tên từ a -> z

-- Lấy số lượng nhất định
select top 1 * from Products order by Price desc; /* Lấy món cố giá trị lớn nhất */
select top 50 percent * from Products order by Price desc; -- Lấy một nửa số hàng được sắp xếp theo giá tiền từ cao đến thấp

-- Lọc dữ liệu
select * from Products where ID = 1 or ID = 2;
select * from Products where ID in (1, 2, 5, 7, 8, 9, 10);
select * from Products where Price > 100 and Price < 1000;

select * from Orders where OrderDate = '2022-09-10';
select * from Orders where OrderDate = '2022-09-01' and OrderDate <= '2022-09-30';
select * from Orders where OrderDate between '2022-09-01' and '2022-09-30';

-- Tìm kiếm
select * from Products where Name like '%450'; -- Tìm kiếm sản phẩm có kí tự kết thúc là 450 (end with)
select * from Products where Name like 'M%'; -- Tìm kiếm sản phẩm có kí tự bắt đầu bằng chữ M (start with)
select * from Products where Name like '%45%'; -- Tìm kiếm sản phẩm có chứa kí tự 45 (constains)

-- Thống kê 
select count(ID) as SoLuongDonHang from Orders where OrderDate between '2022-09-01' and '2022-09-30'; -- Thống kê số lượng đơn hàng trong tháng 9
select sum(GrandTotal) as DoanhThu from Orders where OrderDate between '2022-09-01' and '2022-09-30'; -- Thống kê doanh số trong tháng 9
select avg(GrandTotal) as TrungBinh from Orders where OrderDate between '2022-09-01' and '2022-09-30'; -- Thống kê trung bình doanh thu trong tháng 9


select CustomerID, sum(GrandTotal) as DoanhThu from Orders group by CustomerID; -- Tạo một bảng danh sách tổng doanh thu theo CustomerID
select CustomerID, sum(GrandTotal) as DoanhThu from Orders where OrderDate = getdate() group by CustomerID; -- Tạo 1 bảng để thống kê xem ai mua nhiều nhất trong ngày hôm nay


-- Buổi 4 bt3-6
-- Bt4
-- a
select * from Customers;
-- b
select * from Products;
-- c
select * from Orders;

-- Bt5
-- a
select * from Customers order by Name asc;
-- b
select * from Products order by Price desc;
-- c
select * from Products;

-- Bt6
-- a
select count(ID) as SoKhachHang from Customers;
-- b
select count(Qty) as SoMatHang from OrderItems;
-- c
select GrandTotal as TongTien from Orders;


declare @x int; -- Khai báo 1 biến @x int
set @x = (select * from Customers where Name like N'Nguyễn Văn An');
select * from Orders where CustomerID = @x;


-- Subquery
select * from Orders where CustomerID in (select ID from Customers where Name like N'Nguyễn Văn An');
update Orders set GrandTotal = GrandTotal + 10 where CustomerID in (select ID from Customers where Name like N'Nguyễn Văn An');

-- Liệt kê sản phẩm mà ông An đã mua
select * from Products where ID in 
	(select ProductID from OrderItems where OrderID in 
		(select ID from Orders where CustomerID in 
			(select ID from  Customers where Name like N'Nguyễn Văn An')));

-- Tìm ai đã mua sản phẩm Máy Tính T450
select * from Customers where ID in 
	(select CustomerID from Orders where ID in 
		(select OrderID from OrderItems where ProductID in 
			(select ID from Products where Name like '%T450%')));


create table Classes(
	ID varchar(10) primary key,
	Name varchar(50)
);

create table Students(
	ID int primary key identity(1, 1),
	Name varchar(50),
	ClassID varchar(10) foreign key references Classes(ID)
);

insert into Classes(ID, Name)
values('A', 'Lop A'), ('B', 'Lop B');
insert into Students(Name, ClassID)
values('An', 'A'), ('Nam', 'A'), ('Tu', null);

select * from Classes;
select * from Students;

select * from Students tb1 inner join Classes tb2 on tb1.ClassID = tb2.ID;

select * from Students  tb1 left join Classes tb2 on tb1.ClassID = tb2.ID;

select * from Students tb1 right join Classes tb2 on tb1.ClassID = tb2.ID;


select CustomerID, count(ID) as sl from Orders group by CustomerID;

select tb1.Name, tb2.sl from Customers tb1 inner join
	(select CustomerID, count(ID) as sl from Orders group by CustomerID) tb2
	on tb1.ID = tb2.CustomerID;

select * from OrderItems A
	inner join Orders B on A.OrderID = B.ID
	inner join Products C on A.ProductID = C.ID
	inner join Customers D on B.CustomerID = D.ID;