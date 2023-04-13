create database FoodMarket;
use FoodMarket;

create table Users(
ID  int not null identity primary key(ID),
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
Gender bit not null,
PhoneNumber nvarchar(20),
CardNumber int
);

select * from Users;

create table Orders(
ID int not null identity Primary key(ID),
UsersID int not null,
foreign key(ID) references Users(ID),
CreatedDate Date,
DeliveryDate Date,
PaymentTypeID int,
);

create table PaymentType(
ID int identity primary key(ID),
PaymentMethod nvarchar(50),
);

alter table Orders add Deposit decimal;
alter table Orders add TotalCost decimal;
alter table Orders add [Status] Tinyint not null;
alter table Orders add Bag nvarchar(50);

create table Food(
ID int identity primary key(ID),
[Name] nvarchar(50) not null,
[Type] Tinyint not null, --2 sovorakan, 1 vegan, 3 pahq
Price decimal,
Sale Tinyint
);
insert into Orders values(1,'2023-01-02','2023-01-02',1,500,3500,0,0),
(2,'2023-10-22','2023-10-23',2,0,7800,1,1),
(3,'2023-10-24','2023-10-24',3,300,2500,0,0),
(4,'2023-03-08','2023-03-08',1,0,7000,2,2),
(5,'2023-06-06','2023-06-07',3,100,2500,0,1);
select * from Orders;
alter table Orders add foreign key(PaymentTypeID) references PaymentType(ID);
SELECT *,Orders.UsersID
FROM Users
Inner JOIN Orders ON Users.ID = Orders.UsersID;

select * from Food;

create proc Calc_Price_List
as
select sum(Price) from Food

exec Calc_Price_List

create proc Total @check decimal
as
select sum(Price) from Food 
where Price > @check


create proc Count_Total @check decimal
as
select count(Price) from Food 
where Price > @check

exec Count_Total 3500

create procedure TotalMany @check decimal, @id int
as select sum(Price) from Food 
where Price > @check and id != @id

exec TotalMany 3500, 3

BEGIN
    DECLARE @myvar INT;
    SELECT @myvar = count(Price) FROM Food WHERE Price > 3500
    SELECT @myvar;
    IF @myvar > 3500
    BEGIN
       PRINT ' '
    END
END

declare @price int, @totalSum int;
set @totalSum = 0;
  declare curs cursor for
  select Price from Food
  open curs
  FETCH NEXT FROM curs
  into @price
  WHILE @@FETCH_STATUS = 0
BEGIN
   set @totalSum = @totalSum + @price
   FETCH NEXT FROM curs
   into @price
END
CLOSE curs;
DEALLOCATE curs
select @totalSum

CREATE FUNCTION GetFoodPriceCount
(
    @SpecialityID int
)
RETURNS int
AS
BEGIN
    DECLARE @count int
    SELECT @count = COUNT(*) FROM Food WHERE Price = @SpecialityID
    RETURN @count
END  

create function Func_Count889()
returns int
as
begin
declare @count int
select @count=count (*) from Food Where Price>3500
return @count
end

select dbo.Func_Count889()


----select GetFoodPriceCount(5)

declare @price2 int, @Count int;
set @Count = 0;
  declare curs cursor for
  select Price from Food
  open curs
  FETCH NEXT FROM curs
  into @price2
  WHILE @@FETCH_STATUS = 0
BEGIN
   set @Count = @Count +1
   FETCH NEXT FROM curs
   into @price2
END
CLOSE curs;
DEALLOCATE curs
select @Count


create view Price_View as
select Price from Food
where Price>3500

select * from Price_View
