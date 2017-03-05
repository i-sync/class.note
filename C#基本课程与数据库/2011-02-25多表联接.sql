exec sp_attach_db @dbname=DBStu,@filename1='D:\projects\dbstu.mdf'
exec sp_detach_db dbstu
use dbstu
go

select * from student_info
	where stu_name like '李%'
	
select * from student_info
	where stu_address =''



select * from student_mark
select sum(written_exam) as 笔试总分 from student_mark
go
select max(written_exam) as 笔试最高分 from student_mark
go 
select min (lab_exam) as 机试最低分 from student_mark
go
select count(exam_id) as 参加考试总人数 from student_mark
go
select avg(lab_exam) as 机试平均分 from student_mark
go

select * from student_mark

use tarena

select * from mark

--笔试平均分
select avg(written_exam) from mark

--每门课程的笔试平均分
select avg(written_exam)
	from mark 
	group by course_id


select sum(written_exam)
	from mark
	where written_exam>60
	group by course_id

--求每个学员的笔试平均分,只考虑及格成绩
select * from mark
select stu_id,avg(written_exam)
	from mark
	where written_exam >=60
	group by stu_id

--求每个学员的笔试成绩平均分地,只考虑及格成绩,并且平均分大于90的

select * from mark

select stu_id,avg(written_exam)
	from mark
	where written_exam >=60
	group by stu_id
	having avg(written_exam)>90

--求每个学员的笔试平均分,并且至少包含两门及格成绩的
--update mark 
--	set written_exam=written_exam-30

select * from mark

select 	stu_id,avg(written_exam)
	from mark
	where written_exam>=60
	group by stu_id
	having count(written_exam)>=2
	
--求每个班的男生女生各有多少人
select * from student

select class_id, stu_sex,count(stu_sex) as 男生 
	from student
	group by class_id,stu_sex

select class_id,count(stu_id)
	from student
	group by class_id

select * from student
go 
select * from mark
go

select a.stu_id,a.stu_name,b.written_exam,b.lab_exam 
	from student a
	inner join mark b
	on a.stu_id = b.stu_id

select a .stu_id,a.stu_name,b.written_exam,b.lab_exam
	from student a
	left outer join mark b 
	on a.stu_id = b.stu_id

select a .stu_id,a .stu_name,b.written_exam,b.lab_exam
	from student a
	right outer join mark b 
	on a .stu_id= b .stu_id

select a .stu_id,a .stu_name,b .written_exam,b .lab_exam 
	from student a,mark b 
	where a.stu_id =b .stu_id









	