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

-- Câu 3: Liệt kê các cuốn sách có năm xuất bản từ 2008 đến nay
select * from Books where PublishYear >= 2008;

-- Câu 4: Liệt kê 10 cuốn sách có giá bán cao nhất
select top 10 * from Books order by Price desc;

-- Câu 5: Tìm những cuốn sách có tiêu đề chứa từ “tin học”
select * from Books where Name like (N'%tin học%');

-- Câu 6: Liệt kê các cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dần
select * from Books order by Price asc and where Name like ('T%');

-- Câu 7: Liệt kê các cuốn sách của nhà xuất bản Tri thức
select * from Books where PublisherID in (select ID from Publishers where Name like ('Trí Thức'));

-- Câu 8: Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”
select * from Publishers where ID in (select PublisherID from Books where Name like (N'Trí tuệ Do Thái'));

-- Câu 9: Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản, Loại sách
select distinct a.Code, a.Name, a.PublishYear, a.