create database ms
go
use ms
go 
create table a
(
	id int primary key ,
	name nvarchar (20) not null,
	address nvarchar(50) default ('��ַ����'),
	sex char(2) check (sex like '[��Ů]') default('��') not null
)
go

insert into a 
	select 1,'zhangsan','����','��'

create unique 
	index index_name
	on a (name)

select * from a 

if exists (select * from sys.objects where name='a')
	drop table a
else
	print 'a����ɾ��'
			
if exists (select * from sys.databases where name ='ms')
	drop database ms
else 
	print 'ms���ݿ���ɾ��'	

if exists (select * from sys.indexes where name='index_name')
	drop index a.index_name
else
	print '"index_name"������ɾ��'
		