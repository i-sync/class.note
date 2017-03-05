---�����洢����,����ѡȡ��ҳ
--����1 ������
create procedure proc_pagination
	@pagesize int = 10,
	@pageindex int =1,
	@ordercondition nvarchar(20),
	@primarykey nvarchar(20)
as
	select top @pagesize * from orders
	where @primarykey not in
	(
		select top (@pageindex-1)*@pagesize  @primarykey 
		from orders
		order by @ordercondition
	)
	order by @ordercondition
go		
--����2
drop procedure proc_pageination

create procedure proc_pageination
	@pagesize int = 10,
	@pageindex int =1,
	@ordercondition nvarchar(20)
as
	select * from 
	(
	select row_number() over (order by @ordercondition) as rownumber,* 
	from products
	) as newtable
	where rownumber between (@pageindex-1)*@pagesize+1 and @pageindex* @pagesize
go	

use northwind

exec proc_pageination 10,3,productname

--Ϊnorthwind���ݿ�����Ӵ洢����,Ҫ���ȡorders����
--shippeddateΪ��,��requiredate�ڵ�ǰ������ǰ�Ķ�������ϸ��Ϣ
create procedure proc_ordersinfo
as
	select * from orders
	where shippeddate is null	
	and requireddate>getdate()
go	

exec proc_ordersinfo

--�޸����ϵĴ洢����,Ҫ��:ֻ��ȡ�����ֶ�,
--��requireddate,orderdate,orderid,customerid,employid
alter proc proc_ordersinfo
as
	select requireddate,orderdate,orderid,customerid,employeeid
	from orders
	where shippeddate is null
	and requireddate> getdate()
go	
exec proc_ordersinfo

--ɾ���洢����
drop proc proc_ordersinfo