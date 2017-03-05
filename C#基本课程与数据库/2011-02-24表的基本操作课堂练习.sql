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
	stu_sex nchar(1) not null default ('男') check(stu_sex like '[男女]'),
	stu_birthday datetime not null default (getdate()),
	stu_address nvarchar(100) default ('北京'),
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
	select 201101,'zhangsan','男','2010-5-6','北京海滨',1 union
	select 201102,'lisi','女','2005-02-02','TX',1 union
	select 201103,'wangwu','男','2006-06-06','HD',2 union
	select 201104,'liuda','女','2001-01-03','河南',3 union
	select 201105,'wangfeng','男','2004-04-09','上海',2

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

--将liuda的性别改为男
update student
	set stu_sex = '男'
	where stu_id = 201104

--将所有机试成绩低于90分的学员成绩+5
update 	mark
	set lab_exam=lab_exam+5
	where lab_exam<=90
	
select * from mark	

--修改所有2班的同学为男
update student 
	set stu_sex ='男'
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

truncate table student  --不能删除数据，因为它是先删除表，然后再重构表，
						--而该表中有外键约束，是它所不能重构的，所以不允许删除	

delete from student 

select * from student 
go
select * from mark
go