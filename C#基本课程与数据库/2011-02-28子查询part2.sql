use tarena

select * from mark
--select * from student

--�Ӳ�ѯ
--����û�вμӻ��Կ��Ե�ͬѧ��Ϣ
select * from student
where stu_id not in
(
select distinct stu_id 
from mark
where lab_exam is not null
)


select  distinct stu_name
from student
join mark
on student.stu_id=mark.stu_id
where mark.lab_exam is not null

select stu_name from student
where stu_id in
(
select stu_id 
from mark
where lab_exam=100
)

select stu_name
from student 
join mark
on student.stu_id=mark.stu_id
where mark.lab_exam=100


select 