execute sp_databases
use bank 
go 
execute sp_rename 'cu','customer'

execute sp_renamedb 'Banke' ,'bank'

execute sp_tables 

execute sp_columns customer_id

execute sp_help cu

execute sp_helpindex  spt_values

execute sp_helptext 'sys.all_columns'

execute sp_stored_procedures 

--创建最简单的存储过程
use northwind

create procedure proc_selectproducts
as 
	select * from products
go	

exec proc_selectproducts

--查询某个班的学生信息,以及这个班的平均成绩
use tarena
go 
select * from student

select * from mark
select * from class

drop procedure proc_selectclassinfo

--第一种方法创建存储过程
create procedure proc_selectclassinfo
	@class_id int = 1,
	@avg_great numeric(4,1) output 
as
	select * from student where class_id = @class_id
	declare @avg numeric(4,1)	
	select @avg =avg(written_exam) from mark
		where stu_id in 
		(
			select stu_id from student
			where class_id=@class_id
		)
	set @avg_great=@avg	
go
--第二种方法创建存储过程
create procedure proc_selectclassgreate
	@class_id int = 1,
	@avg_great numeric(4,1) output 
as
	select * from student where class_id = @class_id
	select @avg_great = avg(written_exam)
	from student
	join mark
	on student.stu_id = mark.stu_id
	where student.class_id =@class_id
go	

--执行第一种存储过程
declare @great numeric(4,1)
exec proc_selectclassinfo @avg_great=@great output
print @great

declare @great numeric(4,1)
exec proc_selectclassinfo @class_id = 2, @avg_great=@great output
print @great

--执行第二种存储过程
declare @avggreat numeric (4,1)
exec proc_selectclassgreate @class_id= 1,@avg_great=@avggreat output
print '平均分'+ cast(@avggreat as nvarchar)