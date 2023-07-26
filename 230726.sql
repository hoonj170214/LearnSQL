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
SET @@autocommit := 0;
