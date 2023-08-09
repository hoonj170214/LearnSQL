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
	CREATE PROCEDURE info_sal_over2(in _sal int)
		BEGIN
			PREPARE empQuery
			FROM 'SELECT empno, ename, hiredate, sal FROM emp WHERE sal >= ?';
            SET @sal = _sal;
			EXECUTE empQuery USING @sal;
        END //
DELIMITER ; 


CALL info_sal_over2(1500);

show procedure status;

