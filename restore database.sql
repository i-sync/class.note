--�鿴�����ļ����߼��ļ���
restore filelistonly from disk ='E:\huayiLast\HengRong.bak'
--��ԭ���ݿ�
restore database HengRong from disk ='E:\huayiLast\HengRong.bak'
with recovery,
Move 'QinYingDB' to 'D:\Project_2\HengRong.mdf',
Move 'QinYingDB_Log' to 'D:\Project_2\HengRong_log.ldf'

--�������ݿ�
exec sp_detach_db   @dbname='HengRong'
--�������ݿ�
exec sp_attach_db @dbname='HengRong',@filename1='D:\Project_2\HengRong.mdf',@filename2='D:\Project_2\HengRong_log.ldf'
