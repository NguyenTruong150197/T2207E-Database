create view data_all as
select a.MaDKCC, a.MaNhaCC, b.TenNhaCC, b.DiaChi, b.MaSoThue, e.MaLoaiDV, c.DonGia, 
d.HangXe, a.NgayBatDauCungCap, a.NgayKetThucCungCap from DANGKYCUNGCAP a
right join NHACUNGCAP b on a.MaNhaCC = b.MaNhaCC
left join MUCPHI c on a.MaMP = c.MaMP
left join DONGXE d on a.DongXe = d.DongXe
left join LOAIDICHVU e on a.MaLoaiDV = e.MaLoaiDV;

select * from data_all;

drop view data_all;
/* View có thể lấy dữ liệu từ 1 database khác để xem được
Cú pháp: create view + Tên bảng + as select  from Tên database.dbo.Tên bảng trong database khác */

create view database2 as
select * from Ass2.dbo.Students;

select * from database2;

create procedure select_all as
select * from data_all;
select * from database2;

exec select_all;

drop procedure select_all;

create procedure find_order_by_customer @name nvarchar(255) as
select * from Orders where CustomerID in (select ID from Customers where Name like @name);

exec find_order_by_customer @name = N'Nguyễn Văn An';

create procedure add_new_customer @name_customer nvarchar(255), @address nvarchar(255), @tel varchar(15) as
insert into Customers(Name, Address, Tel)
values(@name_customer, @address, @tel);

create procedure normal_user_add_new_product @name nvarchar(255), @description ntext, @unit nvarchar(50), @price decimal(12, 4) as
if @price <= 100000
begin
	insert into Products(Name, Description, Unit, Price)
	values(@name, @description, @unit, @price);
end
else
	print'Khong duoc dang san pham qua 100000';

exec normal_user_add_new_product @name = N'Túi xách Dior', @description = N'Túi xách hàng hiệu fake 1', @unit = N'Chiếc', @price = '100000';

create trigger thong_bao_them_san_pham on Products
after insert 
as
print N'Vừa có người thêm sản phẩm xong';

create trigger khong_cho_xoa_san_pham on Products
after delete
as
	if exists (select * from deleted where ID = 1005)
	begin
		rollback transaction;
		print N'Không cho xóa sản phẩm';
	end

select * from Products;

delete from Products where ID = 1006;

drop trigger khong_cho_xoa_san_pham;

create trigger gia_moi_cao_hon_gia_cu on Products
after update
as
if (select Price from inserted) < (select Price from deleted)
begin
	rollback transaction;
	print N'Không được giảm giá sản phẩm';
end

update Products set Price = 60000 where ID = 1005;

--Viết trigger chỉ cho phép tạo đơn với khách chưa có đơn nào

create trigger chi_them_don_hang_cho_khach_moi on Orders
after insert
as
	if exists (select * from inserted where CustomerID in (select distinct CustomerID from Orders))
		rollback transaction;