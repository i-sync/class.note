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

--�������Լ��
alter table customer
	add constraint PK_customer_id primary key (customer_id)
go
--��ӷ�ΧԼ��
alter table customer
	add constraint CK_cusotmer_balance check(customer_balance >=1)
	
--��������
create index index_customer_name 
	on customer (customer_name)
--ɾ������
drop index customer.index_customer_name

--��������
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
	print '�������,�ع���....'
	rollback tran
	print '�ع�����.'
end	
else
begin 
	print '�������,�ύ��....'
	commit transaction
end	
go


---------------------------------
---������ϰ------------
print '����ʼ֮ǰ������'
select * from customer

--��ʼ����
begin transaction
--��������,��ʶ�Ƿ����
declare @flag int 
--Ϊ����@flag����ʼֵ0
set @flag=0

--�������
update customer 
	set customer_balance =customer_balance -1000
	where customer_name='lisi'

set @flag = @flag+@@error	

update customer 
	set customer_balance = customer_balance + 1000	
	where customer_name ='zhangsan'
set @flag =@flag + @@error

print '����֮�е�����'
select * from customer

if(@flag>0)
begin	
	print '�������,�ع���....'
	rollback transaction
end
else
begin
	print '�������,�ύ��....'
	commit transaction
end

print '����֮������'
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

------------��������----------
begin transaction
select * from customer with(holdlock)
waitfor delay '00:00:30'
commit transaction

begin transaction
select * from customer 
commit transaction