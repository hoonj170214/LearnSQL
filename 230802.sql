/*
JOIN : 동일한 또는 서로 다른 테이블의 정보를 결합하여 원하는 정보를 검색하는 것
책) 두 개 이상의 테이블을 서로 묶어서 하나의 결과 집합으로 만들어 내는 것

1. 테이블의 중복과 공간낭비를 피하고
2. 데이터의 무결성을 위해서 
여러개의 테이블로 나눠서 저장하는데
테이블들을 묶을 필요가 있을 때 JOIN을 사용한다.

*/

use develop_sql;
select * from emp;
select * from dept;

-- count는 인자값으로 전달한 값이 유효한 데이터의 개수를 알려주는 함수
select count(*) from emp;  -- 14 개
select count(*) from dept;  -- 4 개

-- emp테이블과 dept 테이블을 동시에 출력하는데,
-- 두 테이블을 결합해서 새로운 행을 만들어서 출력해준다.
-- 14 X 4 만큼의 행정보가 생성된다.
/* - Cross Join
	- 책 방법(권장)
    SELECT * FROM ATable 
    CROSS JOIN BTable;
    
    - 쌤 방법(권장X)
    SELECT * FROM ATable,BTable;
    
    -용도 
    : 테스트로 사용할 많은 용량의 데이터를 생성할때 주로 사용
    
    - 크로스 조인에는 ON구문을 사용할 수 없다.
    
*/
select * from emp, dept;
select count(*) from emp,dept; -- 56

select * from salgrade;
select count(*) from salgrade;   -- 8
-- 3개 테이블의 행 개수를 곱한 것 만큼 나온다.
select count(*) from emp, dept, salgrade; -- 14 X 4 X 8 = 448

-- 모든 행정보 검색
select * from emp, dept;
-- where 절로 검색조건 추가해서 검색
-- emp와 dept의 deptno가 일치하는 정보만 검색
select * from emp, dept WHERE emp.deptno = dept.deptno;

/*
	- INNER JOIN
	기준 테이블과 JOIN 테이블 모두 데이터가 존재해야 조회
    결합 상태는 CROSS JOIN과 동일
    
    - 책
    SELECT 열목록 
    FROM 첫번째 테이블
		INNER JOIN 두번째 테이블
        ON 조인될 조건
	WHERE 검색조건
    
    ON, WHERE 뒤에 조건을 쓸때 '테이블.열 이름' 형식으로 써줘야 한다.
    
*/
SELECT * FROM emp INNER JOIN dept;
SELECT * FROM emp INNER JOIN dept
WHERE emp.deptno = dept.deptno;

-- ON, USING
SELECT emp.*, dept.* FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno;

-- INNER key word 는 생략 가능
SELECT emp.* , dept.* FROM emp JOIN dept USING(deptno);

/* 
	-- NATURAL JOIN
-- JOIN 하려는 table 중에 속성 이름이 같은 녀석으로 결합
-- 같은 열 이름을 가진 두 테이블을 조인할때만 작동
-- 같은 열 이름(중복된 데이터)는 1개만 남겨두고 출력

SELECT 컬럼, 컬럼, …
FROM 테이블1
	NATURAL JOIN 테이블2
	[NATURAL JOIN 테이블3] …
WHERE 검색 조건;
*/
SELECT * FROM emp NATURAL JOIN dept;

-- 뉴욕('NEW YORK') 에서 근무하는 사원의 이름(ename)과 급여(sal) 검색
-- 2단계로 풀어서 검색
SELECT deptno FROM dept WHERE loc = 'NEW YORK';  -- 10번
SELECT ename, sal FROM emp where deptno = 10;

-- 서브쿼리를 사용해서 검색
SELECT ename, sal FROM emp WHERE deptno =(
SELECT deptno FROM dept WHERE loc = 'NEW YORK'
);

-- 내추럴 조인을 이용해서 검색(NATURAL JOIN)
SELECT emp.ename, emp.sal FROM emp NATURAL JOIN dept
WHERE dept.loc = 'NEW YORK';
