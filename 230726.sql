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
DELETE : 데이터만 삭제(속도 느림)
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
