insert into Publishers(Name, Address)
values(N'Tri Thức', N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội');

insert into Categories(Name)
values(N'Khoa học xã hội');

insert into Authors(Name)
values('Eran Katz');

insert into Books(Code, Name, Description, PublishYear, NumberOfPublish, Price, Qty, CategoryID, PublisherID)
values(N'B001', N'Trí tuệ Do Thái', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốc trí tuệ 
của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ những bí ẩn về sự thông thái của người Do Thái, của 
một dân tộc thông tuệ với những phương pháp và kỹ thuật phát triển tầng lớp trí thức đã được giữ kín hàng nghìn 
năm như một bí ẩn mật mang tính văn hóa.', 2010, 1, 79000, 100, 1, 1);

insert into BookAuthors(BookCode, AuthorID)
values('B001', 1);

select * from Publishers;
select * from Categories;
select * from Authors;
select * from Books;
select * from BookAuthors;

-- Câu 3: Liệt kê các cuốn sách có năm xuất bản từ 2008 đến nay
select * from Books where PublishYear >= 2008;

-- Câu 4: Liệt kê 10 cuốn sách có giá bán cao nhất
select top 10 * from Books order by Price desc;

-- Câu 5: Tìm những cuốn sách có tiêu đề chứa từ “tin học”
select * from Books where Name like (N'%tin học%');

-- Câu 6: Liệt kê các cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dần
select * from Books where Name like ('T%') order by Price asc;

-- Câu 7: Liệt kê các cuốn sách của nhà xuất bản Tri thức
select * from Books where PublisherID in (select ID from Publishers where Name like (N'Trí Thức'));

-- Câu 8: Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”
select * from Publishers where ID in (select PublisherID from Books where Name like (N'Trí tuệ Do Thái'));

-- Câu 9: Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản, Loại sách
select distinct a.Code as BookCode, a.Name as BookName, a.PublishYear, b.Name as PublisherName, c.Name as Category from Books a 
right join Categories c on a.CategoryID = c.ID
left join Publishers b on a.PublisherID = b.ID;

-- Câu 10: Tìm cuốn sách có giá bán đắt nhất
select top 1 * from Books order by Price desc;

-- Câu 11: Tìm cuốn sách có số lượng lớn nhất trong kho
select top 1 * from Books order by Qty desc;

-- Câu 12: Tìm các cuốn sách của tác giả “Eran Katz”
select * from Books where Code in (select BookCode from BookAuthors where AuthorID in (select ID from Authors where Name like 'Eran Katz'));

-- Câu 13: Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trước
update Books set Price = Price * 90/100 where PublishYear < 2008;

-- Câu 14: Thống kê số đầu sách của mỗi nhà xuất bản
select PublisherID, count(*) as BookQty from Books group by PublisherID;

-- Câu 14 (Cách 2) (Thực tế thường dùng cách này): 
select * from Publishers a left join (select PublisherID, count(*) as BookQty from Books group by PublisherID) b on a.ID = b.PublisherID;

-- Câu 15: Thống kê số đầu sách của mỗi loại sách
select CategoryID, count(*) as BookQty from Books group by CategoryID;

-- Câu 16: Đặt chỉ mục (Index) cho trường tên sách
create index bookname_index on Books(Name);

-- Câu 17: Viết view lấy thông tin gồm: Mã sách, tên sách, tác giả, nhà xb và giá bán
create view BookInfo as
select * from Books a 
left join Publishers b on a.PublisherID = b.ID
left join BookAuthors c on c.BookCode = a.Code
left join Authors d on c.AuthorID = d.ID;

-- Câu 18: Viết Store Procedure:
-- 1. SP_Them_Sach: thêm mới một cuốn sách
create procedure AddBook @code varchar(20), @name nvarchar(255), 

-- 2. SP_Tim_Sach: Tìm các cuốn sách theo từ khóa


-- 3. SP_Sach_ChuyenMuc: Liệt kê các cuốn sách theo mã chuyên mục


-- Câu 19: 
create trigger NoDeleteBook 
on Books
after delete as
	if exists (select * from deleted where Qty > 0)
	rollback transaction;

-- Câu 20: 
create trigger NoDeleteCategory
on Categories
after delete
as
	if exists (select * from deleted where ID in (select * from Books))
	rollback transaction;