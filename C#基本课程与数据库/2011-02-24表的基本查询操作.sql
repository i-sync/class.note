--目标：
--1.基本查询
--	1）使用like/between/in 进行模糊查询
--	2）在查询中使用聚合函数
--	3）使用group by 进行分组查询
--2.高级查询
--	1）多表联结查询
--	2）子查询


select * from student order by class_id]
select * from student order by class_id asc,stu_name desc


select  stu_id ,stu_name,stu_sex,stu_birthday,stu_address,stu_seat,class_id from student

use northwind
 
select	productid,productname,supplierid,categoryid,quantityperunit,unitprice,unitsinstock,unitsonorder,reorderlevel,discontinued 
	from products order by categoryid asc ,unitprice desc


use tarena
go

--查询机试成绩前2名的数据
select top 10 percent * from mark order by lab_exam desc

select * from student where stu_id=1
select stu_id ,class_id from student order by 1 desc,2 asc


select distinct country from suppliers order by country
select * from suppliers

select supplierid ,companyname,contactname,contacttitle ,address,city ,region,postalcode, country ,phone,fax,homepage from suppliers order by country


use northwind 

select top 5 * from products
select top 5 productid,productname,supplierid,categoryid,quantityperunit,unitprice,unitsinstock,unitsonorder,reorderlevel,discontinued from products order by unitprice desc

select top 5 percent * from products


-----起别名
use tarena

select stu_id as 学号, stu_name 姓名, 性别=stu_sex from student 

select cast(stu_id as nvarchar)+'.'+stu_name as 标识 from student 


select  lastname 姓,firstname as 名,雇员编号=employeeid  from employees

select 姓名=lastname+' '+firstname from employees

--格式化
select 员工编号=N'员工编号为:'+convert(nvarchar ,employeeid) from employees order by 员工编号 desc

select * from products 
	where unitprice>16 and (productname like 'T%' or productid =16 )order by unitprice asc

----where 关键字: 用来筛选记录
--语法:select <列名> from <表名> [where<条件>]
--SQL server提供了运算符和关键字来帮助限制条件


























