--�������ݿ�
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

--���һ������Ҫ�����ļ�
alter database student
	add file
	(
		name='student_ndf',
		filename='D:\database\student_ndf.ndf'
	)
	
--�޸����ݿ����Ե�
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

--�������ݿ�
exec sp_detach_db @dbname=student

--�������ݿ�
exec sp_attach_db @dbname=student,@filename1='D:\database\student.mdf',@filename2='D:\database\student_log.ldf'

--�������ݿ⵽D��
backup database student to disk='D:\database\backup\student_bak.bak'

--��ԭ���ݿ⣨������ɾ�������ݿ⣩
restore database student from disk='D:\database\backup\student_bak.bak'

drop database student

--��ȡ�����������ݿ�
exec sp_helpdb

select databasepropertyex('pubs','version')

exec sp_detach_db @dbname='student'
exec sp_attach_db @dbname='student',@filename1='D:\database\student.mdf',@filename2='D:\database\student_log.ldf'

backup database student to disk='D:\database\backup\student_back.bak'
drop database student
restore database student from disk='D:\database\backup\student_back.bak'


/*--���ݿ��еı��ʵ��

--������
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

--Ϊ�����һ��
alter table student 
	add stu_sex bit not null
go

--�޸ı�������	
alter table student
	alter column stu_address nvarchar(50) not null	
go
	
--ɾ�����ĳ��
alter table student 
	drop column stu_sex	
go

--ɾ����
drop table student 
go

*/	

----Լ����ʵ��

/*
��ϰ
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

--��������һ��
alter table stuMark
	add note char(10)
go 
 
 --�޸ı�����
alter table stuMark
	alter column note varchar(100)
go	
	
	
--ɾ�����е�һ��	
alter table stuMark
	drop column note
go	