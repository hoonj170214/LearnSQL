SHOW databases;

use sqldb;

show tables;

SELECT * FROM userTbl;
SELECT * FROM employees.employees;

CREATE DATABASE testDatabase;
DROP DATABASE testDatabase;

CREATE USER 'staff'@'10.100.203.%' IDENTIFIED BY '1234';
-- user 와 host를 조회
SELECT user, host FROM mysql.user;

GRANT CREATE,SELECT,UPDATE,INSERT,DELETE ON sqldb.*
TO 'staff'@'10.100.203.%';
-- 권한 확인
SHOW GRANTS FOR 'staff'@'10.100.203.%';

-- 대표 계정 생성 
CREATE USER 'ceo'@'10.100.203.15' IDENTIFIED BY '12345';

GRANT SELECT, INSERT, UPDATE ON sqldb.* TO
'ceo'@'10.100.203.15';

-- REVOKE ... FROM
-- ceo 계정에 부여된 INSERT, UPDATE 권한 회수
REVOKE INSERT, UPDATE ON sqldb.* FROM 'ceo'@'10.100.203.15';
SHOW GRANTS FOR 'ceo'@'10.100.203.15';

