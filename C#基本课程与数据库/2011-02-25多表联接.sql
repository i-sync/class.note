exec sp_attach_db @dbname=DBStu,@filename1='D:\projects\dbstu.mdf'
exec sp_detach_db dbstu
use dbstu
go

select * from student_info
	where stu_name like '��%'
	
select * from student_info
	where stu_address =''



select * from student_mark
select sum(written_exam) as �����ܷ� from student_mark
go
select max(written_exam) as ������߷� from student_mark
go 
select min (lab_exam) as ������ͷ� from student_mark
go
select count(exam_id) as �μӿ��������� from student_mark
go
select avg(lab_exam) as ����ƽ���� from student_mark
go

select * from student_mark

use tarena

select * from mark

--����ƽ����
select avg(written_exam) from mark

--ÿ�ſγ̵ı���ƽ����
select avg(written_exam)
	from mark 
	group by course_id


select sum(written_exam)
	from mark
	where written_exam>60
	group by course_id

--��ÿ��ѧԱ�ı���ƽ����,ֻ���Ǽ���ɼ�
select * from mark
select stu_id,avg(written_exam)
	from mark
	where written_exam >=60
	group by stu_id

--��ÿ��ѧԱ�ı��Գɼ�ƽ���ֵ�,ֻ���Ǽ���ɼ�,����ƽ���ִ���90��

select * from mark

select stu_id,avg(written_exam)
	from mark
	where written_exam >=60
	group by stu_id
	having avg(written_exam)>90

--��ÿ��ѧԱ�ı���ƽ����,�������ٰ������ż���ɼ���
--update mark 
--	set written_exam=written_exam-30

select * from mark

select 	stu_id,avg(written_exam)
	from mark
	where written_exam>=60
	group by stu_id
	having count(written_exam)>=2
	
--��ÿ���������Ů�����ж�����
select * from student

select class_id, stu_sex,count(stu_sex) as ���� 
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









	