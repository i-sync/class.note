use northwind
go

--������
select top 100 orderid ,customers.customerid, companyname,orderdate 
from customers
inner join orders
on customers.customerid=orders.customerid


--������
select orderid,customers.customerid,companyname,orderdate
from customers
left outer join orders
on customers.customerid=orders.customerid
where orderdate >'1998-5-1'


--�������
select top 10 productid,productname,categoryname,companyname
from products
join categories
on products.categoryid=categories.categoryid
join suppliers
on products.supplierid=suppliers.supplierid
where categoryname like 'C%'

select distinct (customerid) from orders
select distinct (o1.customerid)
from orders o1
join orders o2
on o1.customerid=o2.customerid
where o1.orderid!=o2.orderid



--�ֲ�SQL
--ÿ��������
--��ǰ�ڼ�ҳ
--����:ÿ��ҳ��ʾ10������,��ʾ��3ҳ������
--��һ�ֽ������:������б����,ʹ��where between ... and...
--�ڶ��ֽ������:
--1.��ѡȡǰ10��,����top,����������topֻ�ܴӵ�һ����ʼ
--2.���Ի�ȡǰ20��,��ǰ20�� �Ҳ�Ҫ,Ҳ����,ȥ��ǰ20��
--3.ʹ���Ӳ�ѯ
select top 10 *
from orders
where orderid not in
(
	select top 20 orderid
	from orders
)

/*
��ҳ��ʵ��

declare @pageSize int
declare @pageIndex int 
declare @condition nvarchar(30)
select @pageSize =10,@pageIndex = 3,

create function page(@pageSize,@pageIndex,@condition)
returns 
begin
	return
	select top @pageSize * 
	from orders
	where ���� and orderid not in
	(
		select top (@pageIndex-1)*@pageSize orderid
		from orders 
		where ����
		order by @condition
	)
	order by @condition	
end

*/

select top 100 row_number() over (order by orderdate) as rcount,* 
from orders

select top 100 row_number() over (order by customerid) as rcount,*
from orders

--��ҳ
select *
from(
	select row_number() over(order by orderdate) as rcount,* 
	from orders	
	)         --���Ӳ�ѯ��Ϊһ�ű� 
	as Ranks  --���������
where rcount between 21 and 30
order by orderdate	




--���Ӳ�ѯ�ҳ�customers���orders���е�orderid,customerid,orderdate,companyname
select orderid,customerid,orderdate,
	(select companyname from customers c
	 where c.customerid=o.customerid) as companyname
from orders o
--�ñ����Ӳ�ѯ
select orders.orderid,orders.customerid ,companyname ,orderdate 
from orders
join customers
on orders.customerid= customers.customerid


use northwind
go


--2011-03-01��ϰ
--��ÿҳ10������,ѡ���3ҳ����������

select top 10 * from orders
where orderid not in 
(
	select top 20 orderid 
	from orders 
)
select top 30 * from orders


--���һ�����
select row_number() over(order by orderid) as rcount ,* from orders

select * from 
(
	select row_number() over (order by orderid) as rcount,* from orders
) as ranks
where rcount between 21 and 30
order by orderid

create table a 
(
	id int not null,
	name nvarchar(20) not null,
	sex nvarchar(20)
)

create unique clustered 
	index index_id
	on a(id)
drop index a.index_id
