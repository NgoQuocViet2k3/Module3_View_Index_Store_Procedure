create database DemoProduct;
use DemoProduct;
create table Products
(
    id                int auto_increment primary key,
    productCode       varchar(20),
    productName       varchar(50),
    productPrice      int,
    productAmount     int default 1,
    productDesciption varchar(80),
    productStatus     bit default 1
);
insert into Products (productCode, productName, productPrice, productAmount)
values ('001', 'A1', 50, 2),
       ('002', 'A2', 45, 2),
       ('003', 'A3', 60, 2),
       ('004', 'B1', 55, 2),
       ('005', 'B2', 35, 2);

select *
from products;

alter table Products
    add index index_productCode (productCode);


alter table Products
    add index index_productName_productPrice (productName, productPrice);

explain
select *
from products
where productCode = '001';
explain
select *
from products
where productName = 'A1';



create view product_info as
select productCode, productName, productPrice, ProductStatus
from Products;

update product_info
set productPrice = 52
where productCode = '001';
select *
from product_info;
select *
from Products;

drop view product_info;

delimiter //
create procedure getInfo()
begin
    select productCode, productName, productPrice, ProductStatus
    from Products;
end
// delimiter ;

call getInfo();

delimiter //
create procedure addNewProduct(in inputProductCode varchar(20),
                               in inputProductName varchar(50),
                               in inputProductPrice int,
                               in inputProductAmount int
)
begin
    insert into Products (productCode, productName, productPrice, productAmount)
    values (inputProductCode, inputProductName, inputProductPrice, inputProductAmount);
end
// delimiter ;

call addNewProduct('006', 'A6', 72, 2);

drop procedure editProduct;
delimiter //
create procedure editProduct(
    in searchProductID int,
    in newProductCode varchar(20),
    in newProductName varchar(50),
    in newProductPrice int,
    in newProductAmount int
)
begin
    update Products
    set productCode   = newProductCode,
        productName   = newProductName,
        productPrice  = newProductPrice,
        productAmount = newProductAmount
    where Products.ID = searchProductID;
end
// delimiter ;

select *
from products;
call editProduct(006, '007', 'A7', 65, 2);

delimiter //
create procedure deleteProduct(in searchProductID int)
begin
    delete
    from Products
    where ID = searchProductID;
end
// delimiter ;

select *
from products;
call deleteProduct(8);