--创建数据库
Create database Student
on primary
(
	name='Student',
	filename='D:\database\student.mdf',
	size=5,
	maxsize=200
)
log on
(
	name='Student_log',
	filename='D:\database\student_log.ldf'
)
go

--添加一个次主要数据文件
alter database student
	add file
	(
		name='student_ndf',
		filename='D:\database\student_ndf.ndf'
	)
	
--修改数据库属性的
alter database student 
   modify file
   (
		name='student',
		filename='D:\database\student.mdf',
		size=6,
		maxsize=150,
		filegrowth=15%		
   )	
   
drop database student

--分离数据库
exec sp_detach_db @dbname=student

--附加数据库
exec sp_attach_db @dbname=student,@filename1='D:\database\student.mdf',@filename2='D:\database\student_log.ldf'

--备份数据库到D盘
backup database student to disk='D:\database\backup\student_bak.bak'

--还原数据库（必须先删除该数据库）
restore database student from disk='D:\database\backup\student_bak.bak'

drop database student

--获取本机所有数据库
exec sp_helpdb

select databasepropertyex('pubs','version')

exec sp_detach_db @dbname='student'
exec sp_attach_db @dbname='student',@filename1='D:\database\student.mdf',@filename2='D:\database\student_log.ldf'

backup database student to disk='D:\database\backup\student_back.bak'
drop database student
restore database student from disk='D:\database\backup\student_back.bak'


/*--数据库中的表的实现

--创建表
use student
go

drop table student

create table student
(
	stu_id nvarchar(10) primary key ,
	stu_name nvarchar(8) not null,
	stu_address nvarchar(50),
	stu_age int 
)
go

select * from student 
go

--为表添加一列
alter table student 
	add stu_sex bit not null
go

--修改表属性列	
alter table student
	alter column stu_address nvarchar(50) not null	
go
	
--删除表的某列
alter table student 
	drop column stu_sex	
go

--删除表
drop table student 
go

*/	

----约束的实现

/*
练习
*/

use student
go 

create table stuMark
(
	examNo char(7) not null,
	stuNo char(10) not null,
	writtenExam int ,
	labExam int
)
go

--向表中添加一列
alter table stuMark
	add note char(10)
go 
 
 --修改表中列
alter table stuMark
	alter column note varchar(100)
go	
	
	
--删除表中的一列	
alter table stuMark
	drop column note
go	