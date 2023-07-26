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
-- 10.100.203.15_ -> 뒤에 1자리만 더 올 수 있음.

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

/*
- MySql 사용자 변수 초기화 및 선언
SET 명령어를 통해 변수 선언.
MySQL 변수는 값이 대입될때 타입이 결정되므로
선언과 동시에 초기화가 되어야 함.
변수와 식별자를 구분하기 위해서 변수이름 앞에 @를 부여하여 표시.
변수의 값의 대입 연산자는 = , := 두가지 키워드 사용가능하나
query문과 구분하기 위해 :=를 사용하여 변수의 값을 할당함.
*/

SET @myVal = 10;
-- select를 사용해서 조회
-- 변수나 함수의 결과값을 확인하기 위해 제공되는 가상의 table DUAL
-- 값을 확인하기 위해 제공되는 의미없는 테이블이므로 생략해도 결과는 같다.
SELECT @myVal FROM DUAL;
-- 생략해도 괜찮음.
SELECT @myVal;

-- mysql에서는 문자열개념이 없다. 그래서 '랑 " 아무거나 써도 됨.
-- 다른 sql에서는 '만 써야 하니까 되도록 ' 쓰자.
SET @myVal2 := 3;
SET @myVal3 := 3.141592;
SET @myVal4 := '이름->';
SET @myVal5 := "문자열";

-- 선언된 변수는 현재 세션에서만 쓸 수 있다.
SELECT @myVal2 + @myVal3 FROM DUAL;

-- 문자열은 연산할 수 없다.
-- 연산할 수 없는 문자는 0이 된다.
-- 문자열(0) + 3
SELECT @myVal5 + @myVal2;

-- 0 + 0
SELECT @myVal4 + @myVal5;

SELECT @myVal4, name FROM userTbl WHERE height > 180;
-- 문자열을 연산할 수 없다. 
-- 문자열 앞에 숫자로 시작하면 숫자만 연산된다. 
SELECT '32강' + '16강';

-- 숫자로 시작하지 않으면 그 문자열은 0으로 처리됨.
SELECT '32강' + '강16';

SELECT @myVal4 + ':' + @myVal5;

SELECT concat(@myVal4, ':' , @myVal5);

/*
mysql 내장함수
	- 특정 기능을 수행할 수있도록 MySQL에서 미리 만들어 둔 함수 
    - 
*/

-- 현재 데이터베이스와 연결되어 작업을 수행하는 계정
SELECT current_user();  -- FROM DUAL;
SELECT user() FROM DUAL;

-- 문자열 관련된 함수
SELECT 
	'Welcome to MySQL', 
    upper('Welcome to MySQL'), -- 대문자
    lower('Welcome to MySQL'); -- 소문자
    
-- 문자열 길이 - byte, 한글은 한 글자당 3byte로 취급
SELECT length('MySQL'), length('마이에스큐엘');

SELECT @temp := 'Welcome to MySQL';
-- 문자열 추출
-- (추출할 문자열, 시작 위치, 개수)
Select substr(@temp,4,3);
-- 시작위치가 음수면 뒤에서부터 검색
SELECT substr(@temp, -3, 3);
commit;

USE develop_sql;
-- 사원테이블 검색
SELECT * FROM emp;
-- hiredate 입사일 : 0000-00-00 
SELECT hiredate FROM emp;
-- 사원의 정보를 사원번호, 사원명, 입사년도, 입사 월로 검색
SELECT 
empno, ename,
 substr(hiredate,1,4) AS '입사년도',
 substr(hiredate,6,2) AS '입사 월'
 FROM emp;

-- 특정 문자의 위치를 알려주는 함수
-- 대소문자 구분하지 않는다. 
-- 대문자로 검색하든, 소문자로 검색하든 결과는 같다.
SELECT instr('WELCOME TO MYSQL', 'O');
SELECT instr('welcome to mysql', 'O');
-- 문자열을 검색하면 그 문자열로 '시작하는 위치'(시작점)를 알려준다.
SELECT instr('이것이 MYSQL이다', '이다');
-- 자바에서 indexOf, lastIndexOf 랑 같은 역할을 함.
-- mysql에서는 뒤에서부터 인덱스 위치 검색하는 건 없다. 무조건 앞에서만 검색

SELECT 
	empno AS '사원번호',
    ename AS '사원이름',
    substr(hiredate,1,(instr(hiredate,'-')-1)) AS '입사년도',
   substr(hiredate,(instr(hiredate,'-')+1),2) AS '입사월'
    FROM emp;
    
-- 문자열에 공백을 제거하는 함수 -> trim() 과 같음. 
SELECT '                      MySQL';
SELECT ltrim('                 MySQL'); -- 왼쪽의 공백을 제거
SELECT rtrim('MySQL                 '); -- 오른쪽의 공백을 제거
SELECT trim('a' FROM 'aaaaaMySQLaaaaa'); -- 좌우에 지정한 문자를 제거
SELECT trim(' ' FROM '      MySQL    '); -- 좌우에 공백을 제거

-- concat : 넘겨받은 매개변수들을 묶어서 새로운 문자열 생성
SELECT concat(ename, '은 ',sal, '을 받습니다.') FROM emp;

-- 현재 날짜와 시간의 값을 출력하는 함수
SELECT 
	sysdate(), -- 년월일 시분초, 함수가 호출되는 시점의 시간
    now(),     -- 년월일 시분초, 쿼리가 호출되는 시점의 시간
    curdate(), -- 날짜 - 년월일
    curtime(), -- 시간 - 시분초
    current_timestamp() -- 년월일 시분초
    FROM DUAL;

-- 한 쿼리 안에서 2개의 함수의 처리시간이 동일해야 한다면 now()를 써야 한다.
SELECT now(), SLEEP(2), now();

-- 한 쿼리 안에서 2개의 함수 처리시간이 달라야 한다면 sysdate()를 써야 한다.
SELECT sysdate(), SLEEP(2), sysdate();


-- 특정 기간에 따른 시간 정보 확인
SELECT sysdate() FROM DUAL;

-- 현재 시간을 기준으로 어제와 내일 날짜 및 시간을 출력
-- year, month, day, hour, minute, second 라는 키워드 사용할 수 있다. 
-- INTERVAL은 간격. 앞에 플러스 마이너스는 전 후.
SELECT sysdate() - INTERVAL 1 day AS 어제,
		sysdate() AS 오늘,
		sysdate() + INTERVAL 1 day AS 내일;
        
        
-- 한달 전
SELECT sysdate() - INTERVAL 1 month AS 한달전;
-- 2년 전
SELECT sysdate() - INTERVAL 2 year AS 2년전;

-- 두시간 사이의 간격(차이)를 계산 하는 함수
-- timestampdiff
SELECT empno, ename, hiredate, now(),
timestampdiff(year, hiredate, now())
FROM emp;

-- 날짜 계산 함수
SELECT now(), date_add(now(), INTERVAL 1 MINUTE) AS '1분 후';
SELECT now(), date_add(now(), INTERVAL -1 MINUTE) AS '1분 전';
SELECT now(), date_sub(now(), INTERVAL 1 HOUR) AS '1시간 전';
SELECT now(), date_sub(now(), INTERVAL -1 HOUR) AS '1시간 후';
