--Ŀ�꣺
--1.������ѯ
--	1��ʹ��like/between/in ����ģ����ѯ
--	2���ڲ�ѯ��ʹ�þۺϺ���
--	3��ʹ��group by ���з����ѯ
--2.�߼���ѯ
--	1����������ѯ
--	2���Ӳ�ѯ


select * from student order by class_id]
select * from student order by class_id asc,stu_name desc


select  stu_id ,stu_name,stu_sex,stu_birthday,stu_address,stu_seat,class_id from student

use northwind
 
select	productid,productname,supplierid,categoryid,quantityperunit,unitprice,unitsinstock,unitsonorder,reorderlevel,discontinued 
	from products order by categoryid asc ,unitprice desc


use tarena
go

--��ѯ���Գɼ�ǰ2��������
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


-----�����
use tarena

select stu_id as ѧ��, stu_name ����, �Ա�=stu_sex from student 

select cast(stu_id as nvarchar)+'.'+stu_name as ��ʶ from student 


select  lastname ��,firstname as ��,��Ա���=employeeid  from employees

select ����=lastname+' '+firstname from employees

--��ʽ��
select Ա�����=N'Ա�����Ϊ:'+convert(nvarchar ,employeeid) from employees order by Ա����� desc

select * from products 
	where unitprice>16 and (productname like 'T%' or productid =16 )order by unitprice asc

----where �ؼ���: ����ɸѡ��¼
--�﷨:select <����> from <����> [where<����>]
--SQL server�ṩ��������͹ؼ�����������������


























