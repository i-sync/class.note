create database bank
on primary 
(
	name ='bank',
	filename ='D:\database\bank.mdf',
	size=3,
	maxsize=200,
	filegrowth=1
)
log on 
(
	name ='bank_log',
	filename='D:\database\bank_log.ldf'
)
go

use bank 
go 
drop table customer
go
create table customer
(
	customer_id int not null,
	customer_name nvarchar(20) not null,
	customer_balance money
)
go

--添加主键约束
alter table customer
	add constraint PK_customer_id primary key (customer_id)
go
--添加范围约束
alter table customer
	add constraint CK_cusotmer_balance check(customer_balance >=1)
	
--创建索引
create index index_customer_name 
	on customer (customer_name)
--删除索引
drop index customer.index_customer_name

--插入数据
insert into customer
	select 1,'zhangsan',1 union
	select 2,'lisi',1000

select * from customer
print @@rowcount

use bank
go

begin transaction
declare @flag bit
set @flag=0
update customer
	set customer_balance =customer_balance-1000
	where customer_name='lisi'
	if(@@error<>0)
	begin
		set @flag=1
	end	
update customer
	set customer_balance =customer_balance+1000
	where customer_name='zhangsan'
	if(@@error<>0)
	begin
		set @flag=1
	end
if(@flag<>0)
begin 
	print '事务出错,回滚中....'
	rollback tran
	print '回滚结束.'
end	
else
begin 
	print '事务完成,提交中....'
	commit transaction
end	
go


---------------------------------
---课堂练习------------
print '事务开始之前的数据'
select * from customer

--开始事务
begin transaction
--声明变量,标识是否出错
declare @flag int 
--为变量@flag赋初始值0
set @flag=0

--更新语句
update customer 
	set customer_balance =customer_balance -1000
	where customer_name='lisi'

set @flag = @flag+@@error	

update customer 
	set customer_balance = customer_balance + 1000	
	where customer_name ='zhangsan'
set @flag =@flag + @@error

print '事务之中的数据'
select * from customer

if(@flag>0)
begin	
	print '事务出错,回滚中....'
	rollback transaction
end
else
begin
	print '事务完成,提交中....'
	commit transaction
end

print '事务之后数据'
select * from customer
------------------------------------

/*
create function dbo.Getweekday(@date datetime)
returns int
as 
begin
	return datepart(weekday,@date)
end

select dbo.Getweekday(getdate())	
*/

------------并发控制----------
begin transaction
select * from customer with(holdlock)
waitfor delay '00:00:30'
commit transaction

begin transaction
select * from customer 
commit transaction