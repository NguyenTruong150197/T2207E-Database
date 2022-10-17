insert into Customers(Name, Address, Tel)
values(N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân', '0987654321');

select * from Customers;

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

select * from Products;

insert into  Orders(OrderDate, GrandTotal, CustomerID)
values('2022-09-10', 1500, 1);

select * from Orders;

insert into OrderItems(Qty, Total, ProductID, OrderID)
values(1, 1000, 1, 1),
(2, 400, 2, 1),
(1, 100, 3, 1);

select * from OrderItems;

update Customers set Address = N'Số 8 Tôn Thất Thuyết, Nam Từ Liêm'
where ID = 1;

delete from Customers;