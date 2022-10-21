create table NHACUNGCAP(
	MaNhaCC varchar(6) primary key,
	TenNhaCC nvarchar(255) not null unique,
	DiaChi varchar(20) not null,
	SoDT varchar(15) not null check(SoDT like N'0%'),
	MaSoThue int not null unique
);

create table LOAIDICHVU(
	MaLoaiDV varchar(4) primary key,
	TenLoaiDV nvarchar(255) not null unique
);

create table MUCPHI(
	MaMP varchar(4) primary key,
	DonGia decimal(10,0) not null,
	Mota nvarchar(50)
);

create table DONGXE(
	DongXe varchar(15) primary key,
	HangXe varchar(10) not null check(HangXe in ('Toyota', 'Ford', 'KIA', 'Huyndai')),
	SoChoNgoi int not null
);

create table DANGKYCUNGCAP(
	MaDKCC varchar(5) primary key,
	MaNhaCC varchar(6) not null foreign key references NHACUNGCAP(MaNhaCC),
	MaLoaiDV varchar(4) not null foreign key references LOAIDICHVU(MaLoaiDV),
	DongXe varchar(15) not null foreign key references DONGXE(DongXe),
	MaMP varchar(4) not null foreign key references MUCPHI(MaMP),
	NgayBatDauCungCap date,
	NgayKetThucCungCap date,
	SoLuongXeDangKy int
);

drop table DANGKYCUNGCAP;