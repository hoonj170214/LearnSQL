/*
	Session - (특정한 활동을 하기 위한) 시간(기간)
    동일 Session 내에서 처리되는 작업단위를 논리적으로 묶어서 Transaction이라고 함.
    Transaction을 제어하는 명령어를 TCL(Transaction Control Language)라고 함.
    
    commit; 
    : 현 session에서 실행된 작업을 적용.
    
    rollback;
    : 현재 session에서 실행된 작업 이전 commit 시점으로 돌림.
    
    
*/ 
use sqldb;
-- buytbl2, buytbl3에 buytbl내용을 복제 
INSERT INTO buytbl2 SELECT * FROM buytbl;
INSERT INTO buytbl3 SELECT * FROM buytbl;

SELECT * FROM buytbl2;
SELECT * FROM buytbl3;

-- @@ == system 변수
SELECT @@autocommit;

-- autocommit 설정 변경
-- 명령문이 실행될 때 자동으로 commit을 수행 할건지 여부를 저장
-- 0 : False 자동 commit 설정 해제
-- 1 : True 자동 commit 설정
-- 오토커밋 주의사항!
-- 오토커밋을 활성화하면 실수를 하더라도 즉시 반영된다.
-- 커밋된 트랜잭션은 롤백이 불가능하다.

SET @@autocommit := 0;
SET @@autocommit := TRUE;
SET @@autocommit := FALSE;

-- TCL은 DML만 적용
SELECT * FROM buyTbl2; 
UPDATE buyTbl2 SET price = 0;
rollback;

UPDATE buyTbl2 SET price = price + 50;
SELECT * FROM buyTbl2;
commit;
-- commit 한 시점부터 새로운 트랜잭션 시작된다.
rollback;

CREATE TABLE dev1(SELECT * FROM employees.employees);
CREATE TABLE dev2(SELECT * FROM employees.employees);
CREATE TABLE dev3(SELECT * FROM employees.employees);

-- data 삭제
SELECT * FROM dev1;
/*
DELETE : 데이터만 삭제(트랜잭션 로그를 기록하기 때문에 속도 느림)
TRUNCATE : 행정보를 삭제, 컬럼값만 남아 있음.(속도 빠름)
DROP : 테이블 삭제
DELETE는 롤백 가능, TRUNCATE, DROP은 롤백 불가능
*/
-- dev1 table의 모든 행 정보 삭제
DELETE FROM dev1;
rollback;
-- DML을 제외하고 모든 명령은 COMMIT이 이뤄진다.
-- 따라서 DML을 제외하고 모든 명령은 단일 트랜잭션이다. 

-- 테이블의 데이터(행 정보)를 전부 삭제(제목행은 유지)
TRUNCATE TABLE dev2;
SELECT * FROM dev2;

DELETE FROM dev3;
rollback;
TRUNCATE TABLE dev3;
SELECT * FROM dev3;
DROP TABLE dev3;

/*
DDL을 이용하여 사용자 계정 생성
DCL을 이용하여 권한 부여 및 회수
-DCL : Data Control Language
: 데이터 베이스에 접근하는 객체들의 권한을 부여하고 회수하는 명령어들.
	-GRANT : 권한 부여
    -REBOKE : 권한 제거
    -COMMIT : 처리 적용
    -ROLLBACK : 처리 취소

*/
-- 내 컴퓨터 ip주소 : 10.100.203.15 -> 대신에 localhost 를 사용할 수 있음.
-- 10.100.203.15 == 내컴퓨터 ip주소 == localhost == 127.0.0.1(IPv4)

-- 사용자 계정 정보 확인
show databases;
-- 사용자 계정 정보를 담고 있는 테이블 사용 
use mysql;
-- 맨 밑에 'user'가 사용자 정보를 담고 있다.
SHOW TABLES;
-- 조회
SELECT * FROM user;

-- 사용자계정 생성, 
-- user1이 사용자 이름, 
-- 'localhost'에서만 접근가능하고, 
-- 비번은 12345
CREATE USER user1@'localhost' IDENTIFIED BY '12345';

-- % 는 어떤 컴퓨터던지 상관없이 접근가능하다는 뜻.
-- 동일한 username이라도 접근가능한 컴퓨터가 다르면 다른 계정으로 취급
CREATE USER user1@'%' IDENTIFIED BY '54321';

-- 유저 계정정보 삭제
Drop user user1@'%';

CREATE USER 'pm'@'10.100.203.15' IDENTIFIED BY '1234';
-- 계정명@'접속위치'
-- host 가 % : 어디서나 접근 가능
-- 특정 컴퓨터 주소 사용가능
-- 10.100.203.%  -> 10.100.203. 안에 있는 모든 컴퓨터는 접속 가능하다 는 뜻
-- 10.100.203.15_ -> 뒤에  

SELECT user, host FROM user;

-- 계정명이 호스트까지 포함된다.
-- 사용자의 권한 보기
SHOW GRANTS FOR pm@'10.100.203.15';
 
 -- grant 권한 종류 ON 권한으로 사용이 가능한 database.table TO 사용자계정;
-- WITH GRANT OPTION 권한 부여 옵션 추가 
-- 사용자에게 
-- 모든 권한(all)
-- (*.*) == ( 모든 데이터베이스 . 모든 테이블 ) 
-- with grant option == 다른 사용자에게 권한을 줄 수 있는 권한
-- 부여해주기
GRANT ALL ON *.* TO pm@'10.100.203.15' WITH GRANT OPTION;
