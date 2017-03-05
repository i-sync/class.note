create database ms
go
use ms
go 
create table a
(
	id int primary key ,
	name nvarchar (20) not null,
	address nvarchar(50) default ('地址不详'),
	sex char(2) check (sex like '[男女]') default('男') not null
)
go

insert into a 
	select 1,'zhangsan','北京','男'

create unique 
	index index_name
	on a (name)

select * from a 

if exists (select * from sys.objects where name='a')
	drop table a
else
	print 'a表已删除'
			
if exists (select * from sys.databases where name ='ms')
	drop database ms
else 
	print 'ms数据库已删除'	

if exists (select * from sys.indexes where name='index_name')
	drop index a.index_name
else
	print '"index_name"索引已删除'
		