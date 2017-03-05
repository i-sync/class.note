use northwind
select top 10 * from products
use tarena

create table class
(
	class_id int primary key ,
	class_name nvarchar(10) not null
)
go

create table student
(
	stu_id int primary key,
	stu_name nvarchar(20) not null,
	stu_sex nchar(1) not null default ('��') check(stu_sex like '[��Ů]'),
	stu_birthday datetime not null default (getdate()),
	stu_address nvarchar(100) default ('����'),
	stu_seat int identity(1,1),
	class_id int not null foreign key references class (class_id)
)
go

create table course
(
	course_id int primary key,
	course_name nvarchar(20) not null
)
go

create table mark
(
	mark_id int identity(1,1) primary key ,
	stu_id int not null foreign key references student(stu_id),
	course_id int not null foreign key references course(course_id),
	written_exam int default(0) check(written_exam>=0 and written_exam<=100) not null,
	lab_exam int default (0) check(lab_exam>=0 and lab_exam <=100) not null
)
go


insert into class (class_id,class_name)
	select 1,'MSD1101' union
	select 2,'MSD1102' union
	select 3,'MSD1103'
	
--select class_id,class_name from class	

insert into student(stu_id,stu_name,stu_sex ,stu_birthday,stu_address,class_id)
	select 201101,'zhangsan','��','2010-5-6','��������',1 union
	select 201102,'lisi','Ů','2005-02-02','TX',1 union
	select 201103,'wangwu','��','2006-06-06','HD',2 union
	select 201104,'liuda','Ů','2001-01-03','����',3 union
	select 201105,'wangfeng','��','2004-04-09','�Ϻ�',2

insert into course(course_id,course_name)
	select 101,'C#' union
	select 102,'WindowForm' union
	select 103,'ASP.NET'	
	
insert into mark(stu_id,course_id,written_exam,lab_exam)
	select 201101,101,100,100 union
	select 201101,102,90,90 union
	select 201101,103,80,80 union
	select 201102,101,90,90 union
	select 201102,102,80,80 union
	select 201102,103,70,80 union
	select 201103,102,90,90 union 
	select 201104,101,45,78 union
	select 201105,103,100,98	

select * from student
go

--��liuda���Ա��Ϊ��
update student
	set stu_sex = '��'
	where stu_id = 201104

--�����л��Գɼ�����90�ֵ�ѧԱ�ɼ�+5
update 	mark
	set lab_exam=lab_exam+5
	where lab_exam<=90
	
select * from mark	

--�޸�����2���ͬѧΪ��
update student 
	set stu_sex ='��'
	where class_id=2
	
select * from student 	

--
update mark
	set lab_exam=lab_exam-5
	where lab_exam=100

delete from mark
	where written_exam=100

select * from mark

truncate table mark

delete from mark

truncate table student  --����ɾ�����ݣ���Ϊ������ɾ����Ȼ�����ع���
						--���ñ��������Լ���������������ع��ģ����Բ�����ɾ��	

delete from student 

select * from student 
go
select * from mark
go