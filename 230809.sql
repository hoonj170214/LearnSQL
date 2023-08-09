/*
	저장 프로시저(Stored Procedure)
    - 절차를 저장하다. 
    - 여러개의 쿼리 혹은 동작을 프로시저라는 개체로 묶어서 저장
    - 프로시저 이름을 통해서 작동하므로 내부의 쿼리를 숨길 수 있음.
    - 저장된 프로시저는 CALL 예약어를 통해서 호출(사용)
*/

/*
	-- Procedure 생성 방법
    DELIMITER //
		CREATE PROCEDURE '프로시저 이름'(매개변수 ...)
			BEGIN
			-- 실행할 쿼리 작성
			END //
	DELIMITER ;
    
    -- 실행
    CALL '프로시저 이름'(인자값...);
*/

DELIMITER //
	CREATE PROCEDURE readEmp()
		BEGIN 
			SELECT * FROM emp;
        END //
DELIMITER ;

CALL reademp();

-- 매개변수를 전달 받는 프로시저
-- 매개변수 선언 형식 : 'IN `매개변수명` 데이터 형식(타입)'
-- 사원번호를 매개변수로 받아서 해당 사원의 정보를 검색
DELIMITER $$
	CREATE PROCEDURE info_emp(IN _empno INT)
		BEGIN
			SELECT * FROM emp WHERE empno = _empno;
		END $$
DELIMITER ;

CALL info_emp(7902);
SELECT empno FROM emp;

-- Question - procedure name : `info_sal_over`
-- 매개변수 : 급여(정수)
-- 전달받은 급여 이상의 급여를 받는 사원의 
-- 사원번호, 이름, 입사일, 급여를 검색하는 프로시저 작성
select * FROM emp;

-- 내가 작성해본 것
-- DELIMITER //
-- 	CREATE PROCEDURE info_sal_over(in Inputsal int)
-- 		BEGIN
-- 			SELECT empno, ename, hiredate, sal FROM emp WHERE sal >= Inputsal;
--         END //
-- DELIMITER ; 

-- 프로시저 삭제
DROP PROCEDURE info_sal_over;
DROP PROCEDURE info_sal_over2;

-- 썜이 한것 
DELIMITER //
	CREATE PROCEDURE `info_sal_over2`(in _sal int)
		BEGIN
			PREPARE empQuery
			FROM 'SELECT empno, ename, hiredate, sal FROM emp WHERE sal >= ?';
            SET @sal = _sal;
			EXECUTE empQuery USING @sal;
        END //
DELIMITER ; 


CALL info_sal_over2(1500);

show procedure status;

-- 데이터베이스에 등록된 프로시저 정보 확인 
SHOW PROCEDURE STATUS;
-- 특정 데이터베이스에 등록된 프로시저 정보 확인
SHOW PROCEDURE STATUS WHERE db = 'develop_sql';

/* 		INFORMATION_SCHEMA 오브젝트를 조회해서 확인해볼 수도 있다.
SELECT T1.ROUTINE_DEFINITION
FROM   INFORMATION_SCHEMA.ROUTINES T1
WHERE  T1.ROUTINE_SCHEMA = [스키마명]
AND    T1.ROUTINE_NAME = [프로시저명];
*/

/*
	show create procudure 프로시저 이름
    -> 프로시저 스크립트(안에 내용)을 확인할 수 있다.
*/

-- userTbl 테이블 회원 이름을 전달 받아
-- 회원의 연령대를 출력 
DELIMITER $$
	CREATE PROCEDURE checkAge(IN uname VARCHAR(10))
		BEGIN
			-- 변수 선언
            DECLARE yearBirth INT;
            DECLARE age INT;
            DECLARE answer TEXT;
			SELECT birthyear INTO yearBirth FROM sqldb.usertbl WHERE name = uname;
			SET age = YEAR(curdate()) - yearBirth;
            
            -- 조건문
            -- IF 조건식 THEN
            -- 	실행 명령어
            -- ELSE
            -- 	실행 명령어
            -- END IF
            
            IF age >= 60 THEN
				SET answer = "어르신입니다.";
            ELSEIF age BETWEEN 50 AND 59 THEN
				SET answer = "50대 입니다.";
			ELSEIF age BETWEEN 40 AND 49 THEN
				SET answer = "40대 입니다.";
			ELSEIF age BETWEEN 30 AND 39 THEN
				SET answer = "30대 입니다.";
			ELSE
				SET answer = "젊습니다.";
            END IF;
            SELECT answer AS '답변'; -- AS 뒤에 FROM DUAL 이 생략된 거임.
		END $$
DELIMITER ;

SELECT YEAR(curdate()) - 1970;
SELECT MONTH(curdate());
SELECT DATE(curdate());

SELECT * FROM sqldb.usertbl;
DROP PROCEDURE checkAge; 
CALL checkAge('은지원');
CALL checkAge('김범수');
CALL checkAge('이승기');

/*
반복문
형식
	WHILE < 부울 식 > DO
		SQL 명령문 ....
	END WHILE;

*/


--  구구단 수를 입력 받아 출력하고 출력된 문자열을 테이블에 저장
-- 용량별 텍스트 데이터타입
-- TINYTEXT : 256 BYTES
-- TEXT : 64 KB
-- MIDIUMTEXT : 16MB
-- LONGTEXT : 4GB

CREATE TABLE temp_tbl(
	txt TEXT
);

DELIMITER //
	CREATE PROCEDURE whileTest(IN num INT)
		BEGIN
			DECLARE str TEXT;	-- 구구단 문자열 텍스트를 저장할 변수 선언
			DECLARE i INT;		-- 1 ~ 9 변화되는 수
			SET str = '';
            SET i = 1;
            WHILE(i < 10) DO      
            -- DO는 반복을 시작하는 곳을 지정해줌
            -- WHILE(탈출 조건) DO   실행   END WHILE;
            -- 반복 수행 작업
				SET str = concat(str,' ',num,'*',i,'=',num*i,' ');
				SET i = i+1;
            END WHILE;	-- WHILE 종료
            INSERT INTO temp_tbl VALUES(str);
            SELECT str AS RESULT FROM DUAL;
        END //
DELIMITER ;


call whileTest(4);
call whileTest(3);
SELECT * FROM temp_tbl;

-- 프로시저 생성한 시점이 커밋시점이니까 그때로 돌아간다.
rollback;

-- 
/*
-- 저장 프로시저 매개변수의 3가지 모드
MODE 매개변수이름 데이터타입(사이즈)
IN , OUT , INOUT




*/

SELECT * FROM tbl_member;
INSERT INTO tbl_member(id,pw,name)
VALUES('id001','pw001','최기근');
INSERT INTO tbl_member(id,pw,name)
VALUES('id002','pw002','홍길동');
commit;

-- 매개변수로 id, pw를 넘겨받아서
-- 아이디와 패스워드가 일치하는 행이 검색되면 true
-- 존재하지 않으면 false 를 반환
DELIMITER $$
	CREATE PROCEDURE loginCheck()
    BEGIN
    END$$
DELIMITER ;








