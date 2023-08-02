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

/*
	VIEW - 가상의 테이블
    - 물리적으로 저장 공간을 가지고 있지 않지만
    SELECT 문을 통해 생성된 구조 정보를 가지고 있음
    
    VIEW 생성
    CREATE VIEW AS SELECT
    
    VIEW 사용 - 일반 테이블 사용법과 동일
	
    - 뷰는 기본적으로 '읽기 전용'으로 많이 사용하지만
	- 뷰를 통해서 원테이블의 데이터를 수정할 수도 있다.
    
    - 뷰의 장점
    1. 보안에 도움이 된다. -> 뷰에 보여주고 싶은 속성만 보여줄 수 있으니까.
    2. 복잡한 쿼리를 단순화 할 수 있다.
*/

DESC emp;
-- 뷰 생성
CREATE VIEW v_emp AS SELECT empno, ename FROM emp;

desc v_emp;

select * FROM v_emp;

-- 뷰 삭제
DROP VIEW IF EXISTS v_emp;

/*
	- SELECT 문의 결과를 이름을 가지는 뷰라는 개체
    저장하여 생성
    실제 데이터를 비추는 창에 비유
    검색된 COLUMN으로 데이터를 불러오기 때문에 
    실제 저장된 테이블 값을 보호하는 보안 목적으로 사용
    VIEW를 사용하는 사용자는 사용되고 있는 데이터가 
    실제 테이블인지 가상의 테이블(VIEW)인지 구별하기 힘듬
    실제 테이블의 구조를 파악하기 힘들다.
*/

use sqldb;

show tables;

-- CREATE OR REPLACE VIEW : 생성하거나 아니면 뷰로 대체해라
-- 
CREATE OR REPLACE VIEW v_usertbl AS
SELECT userID, name FROM usertbl;

-- 원테이블 조회
SELECT * FROM usertbl;

-- 뷰 조회
SELECT * FROM v_usertbl;

DESC v_usertbl;


INSERT INTO v_usertbl VALUES('CGG', '최기근');
-- Error Code: 1423. Field of view 'sqldb.v_usertbl' 
-- underlying table doesn't have a default value -> 에러 뜸.
-- 에러 이유(뜻)	
-- not null인 속성을 모두 입력해야 insert할 수 있다. 

DESC usertbl;

INSERT INTO v_usertbl 
VALUES('CGG', '최기근', 1982,'부산', null, null, 184, curdate());
-- 윗 문장 실행시키면 에러 뜸.
-- Error Code: 1136. 
-- Column count doesn't match value count at row 1	
-- 에러 뜻
-- 뷰에는 2개의 속성만 정의되어있기 때문에 만약에 insert할 거면 
-- 뷰랑 원테이블 데이터랑 둘 다 insert 해줘야 한다.
-- 뷰는 이렇게 잘못 인서트 하는 것을 미연에 방지해준다. 굿!

SELECT * FROM userTbl WHERE userID = 'HGD';

-- 뷰를 통해서 원 테이블의 데이터를 수정(update) 할 수 있다. 
UPDATE v_userTbl SET name = '최기근'
WHERE userID = 'HGD';


-- 구매목록 테이블에 들어가 있으니까 뷰의 데이터가 삭제 안됨.
DELETE FROM v_usertbl WHERE userID = 'HGD';

-- 구매목록 테이블에 아이디를 삭제하자
DELETE FROM buytbl WHERE userID= 'HGD';

-- 뷰를 조회해보자
SELECT * FROM v_usertbl WHERE userID = 'HGD';

rollback;

-- 사용자별 구매 목록을 사용자 정보와 함께 출력
CREATE OR REPLACE VIEW v_user_buy AS 
SELECT * FROM usertbl AS U JOIN buytbl AS B
USING(userID);

DESC buytbl;

DESC v_user_buy;
SELECT * FROM v_user_buy;

-- 검색쿼리 안에서 가상의 뷰를 생성하는 것 
-- inline view(인라인 뷰)
-- FROM 절에서 사용되는 서브쿼리
-- 서브쿼리에서 조회한 결과를 하나의 테이블처럼 사용하고 싶을 때 사용
-- 테이블에서 조회한 컬럼만 조회가 가능

/*
	#Sub Query
    - 스칼라 서브쿼리(Scalar Sub Query) : 하나의 컬럼처럼 사용(표현 용도)
    SELECT col1, (SELECT ...) FROM tbl ....
    
    - 인라인 뷰(Inline View) : 하나의 테이블처럼 사용(테이블 대체 용도)
    SELECT ... FROM (SELECT ...)
    
    - 일반 Sub Query : 하나의 변수 처럼 사용(결과에 영향을 주는 조건절)
    WHERE col1 = (SELECT ...)
    
    INLINE VIEW(인라인 뷰)
    - VIEW를 미리 정의하지 않고 검색 쿼리 내에서 정의해서 사용하는 VIEW
    - sub query가 FROM절에서 table을 대체하는 경우
    - 검색된 결과를 하나의 테이블처럼 사용
    
*/

USE develop_sql;

-- 인라인 뷰를 이용해서 부서별 평균 급여가 2500 이상인 부서의
-- 부서 번호, 평균 급여 검색
-- 인라인뷰를 사용할 때는 무조건 AS 별칭을 지정해줘야 한다. 
SELECT * FROM
(SELECT deptno, avg(sal) AS 평균급여 FROM emp GROUP BY deptno) AS temp
WHERE 평균급여 >= 2500;

-- 부서별 평균급여와 평균급여등급을 인라인 뷰를 이용해서 출력
SELECT E.avgSal, salgrade.grade FROM
(SELECT deptno, avg(sal) AS avgSal FROM emp GROUP BY deptno) AS E
JOIN salgrade ON E.avgSal BETWEEN salgrade.losal and salgrade.hisal;

-- Question 
-- 부서별 평균 급여와 급여등급을 부서이름, 평균급여, 평균급여등급 형식으로 출력
SELECT D.dname, E.deptno, E.avgSal, S.grade FROM
(SELECT deptno, avg(sal) AS avgSal FROM emp GROUP BY deptno) 
AS E NATURAL JOIN dept D, salgrade S ;
-- WHERE E.deptno = D.deptno
select
D.dname, E.deptno, E.avgSal, S.grade
from avg_group_emp E natural join dept D JOIN salgrade S
ON E.avgSal Between S.losal and s.hisal;

-- 스카라 서브쿼리 사용 예
-- emp table에서 사원의 이름과 해당 사원을 관리하는 매니저 이름 출력
select
	ename AS 사원이름
    (SELECT ename FROM emp AS B WHERE )
from emp AS A ORDER BY empno DESC;











