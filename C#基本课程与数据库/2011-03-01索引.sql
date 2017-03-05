drop table a
create table a
(
	 id int not null,
	 name nvarchar(20) not null,
	 age int ,
	 address nvarchar(50),
	 seat int,
	 classname nvarchar(20),
	 teachername nvarchar(20)
)

--创建主键索引
alter table a 
	add constraint PK_a_id primary key (id)

--创建唯一索引
alter table a 
	add constraint UQ_a_name unique (name)	

create unique nonclustered 
index index_age on a (age)
with fillfactor=20

--创建聚集索引
alter table a 
	drop constraint PK_a_id

create unique clustered 
index index_a_id on a (id)
with fillfactor=20	

--创建不唯一组合索引
create nonclustered 
index index_a_cname_tname on a(classname,teachername)
with fillfactor=20

--创建唯一非聚集索引
create unique nonclustered 
index index_a_address on a (address)
with fillfactor=20

drop index a.index_a_address
drop index a.index_a_id

use pubs
go 

if exists(select * from sys.indexes where name='index_clindx_titiepub')
drop index titles.index_clindx_titiepub
else 
begin
create unique nonclustered 
index index_clindx_titiepub on titles(title_id,pub_id)
with fillfactor=80
end
go


use northwind
go

create unique nonclustered 
index index_customer on customers (customerid)

drop index customers.index_customer

create nonclustered 
index index_orderid_productid on [order details] (orderid,productid)

drop index [order details].index_orderid_productid


exec sp_helpindex [order details]


--作业
use tarena
go

select * from student 
go
select * from mark


select student.stu_id,stu_name ,lab_exam= case when lab_exam is null then '缺考' else lab_exam end
	from student
	left join mark
	on student .stu_id= mark.stu_id