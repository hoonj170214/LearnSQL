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
    양쪽 테이블에 모두 내용이 있는 데이터만 조인
    
    - 책
    SELECT 열목록 
    FROM 첫번째 테이블
		INNER JOIN 두번째 테이블
        ON 조인될 조건
	WHERE 검색조건
    
    ON, WHERE 뒤에 조건을 쓸때 '테이블.열 이름' 형식으로 써줘야 한다.
    WHERE 검색조건은 호환성 등의 문제로 권장하지 않는 방법.
    ON 검색조건을 애용하자.
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

-- SCOTT이 근무하는 부서의 이름과 SCOTT 사원의 급여 출력
-- where과 and를 사용해서 검색
select dept.dname, emp.sal from emp,dept
where emp.deptno = dept.deptno and emp.ename = 'SCOTT';

-- INNER JOIN, USING을 사용해서 검색 
select dname, sal from emp JOIN dept USING(deptno)
where emp.ename = 'SCOTT'; 

-- SELF JOIN 
-- 동일한 테이블을 결합하여 검색
select * from emp;
-- 사원의 이름과 그 사원의 매니저 이름을 검색
-- 같은 테이블을 조인할때는 AS로 테이블의 별칭을 지정해줘야 한다.
select * from emp AS A, emp AS B; -- 에러 : 별칭을 지정하지 않으면 에러 뜸.

-- emp와 mgr가 일치하는 데이터만 출력
select * from emp AS A, emp AS B
WHERE A.mgr = B.empno;

select A.ename AS 사원이름 , B.ename AS 매니저이름
from emp AS A, emp AS B
WHERE A.mgr = B.empno;

/*
	- OUTER JOIN
    - JOIN 조건에 만족하지 않는 행 정보도 남아있는 테이블의 값이 존재하면 
    - 검색에 포함
    - 조인의 조건에 만족되지 않는 행까지도 포함시키는 것
    - 한쪽에만 내용이 있어도 결과가 표시되는 조인
    
    - 책
    SELECT 열목록
    FROM 첫번째 테이블(left 테이블)
    <left | RIGHT | FULL> OUTER JOIN 두번째 테이블(right 테이블)
		ON 검색될 조건
	[WHERE 검색조건];
    
    - LEFT, RIGHT 를 작성하면 OUTER는 안적어도 됨
*/

-- 사원의 이름과 매니저 이름을 출력하되 매니저가 없는 사원 정보도 검색
SELECT A.ename AS 사원, B.ename AS 매니저
FROM emp AS A LEFT OUTER JOIN emp AS B
ON A.mgr = B.empno;

-- 검색된 결과를 이름을 기준으로 정렬
SELECT A.ename AS 사원, B.ename AS 매니저
FROM emp AS A LEFT OUTER JOIN emp AS B
ON A.mgr = B.empno ORDER BY B.ename;

-- 사원의 이름과 매니저 이름을 출력하되 매니저가 아닌 사원 정보도 출력
SELECT A.ename AS 사원, B.ename AS 매니저
FROM emp AS A RIGHT OUTER JOIN emp AS B
ON A.mgr = B.empno ORDER BY B.ename;

-- emp table과 salgrade table을 조인하여
-- 각 사원의 급여등급을 사원명, 급여, 급여 등급으로 출력

select * from salgrade;
select * from emp e LEFT JOIN salgrade s
ON e.sal between s.losal and s.hisal;


-- 각 사원의 급여 등급을 사원명, 부서명, 급여, 급여 등급으로 검색
SELECT 
	e.ename, d.dname, e.sal, s.grade
FROM emp e NATURAL JOIN dept d LEFT JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal
ORDER BY s.grade;









