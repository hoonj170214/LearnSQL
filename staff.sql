-- staff.sql
show databases;
show tables;

select * from sqldb.userTbl;
-- command denied, sqldb를 제외한 db 접근 권한이 없음
select * from employees.titls;

select * from buytbl3;

delete from buytbl3 where userId = 'KBS';
rollback;

create table testTbl(
	userID VARCHAR(10)
    );
    
DROP TABLE testTbl;

CREATE USER 'ceo'@'10.100.203.15' IDENTIFIED BY '12345';
