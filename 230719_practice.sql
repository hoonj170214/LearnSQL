/**
    신규 database(Schema 생성)
    database 명 : develop_sql
    develop_sql 생성 후 develop_sql database에
    emp, dept, salgrade sample data 추가
*/
USE develop_sql;

SELECT * FROM emp;  -- 사원 테이블
SELECT * FROM dept; -- 부서 테이블
SELECT * FROM salgrade; -- 급여 등급 테이블

-- 1. 실습에 사용될 EMP 테이블의 구조를 검색하라

-- 2. 부서의 부서코드와 부서명을 검색하라
	SELECT deptno, dname FROM dept;
-- 3. 부서의 부서명과 지역을 검색하라
SELECT dname, loc FROM dept;
-- 4. 사원들의 급여와 커미션을 검색하라
SELECT sal, comm FROM emp;
-- 5. 사원들의 입사일자를 중복을 제거하고 검색하라
SELECT distinct hiredate FROM emp;
-- 6. 사원들의 매니저를 중복을 제거하고 검색하라
SELECT distinct mgr FROM emp;
-- 7. 사원들의 입사일자를 중복을 제거하고 검색하라
SELECT distinct hiredate FROM emp;
-- 8. 사원들의 부서번호를 중복을 제거하고 검색하라
SELECT distinct deptno FROM emp;
-- 9. 사원들의 6개월 급여의 합을 구하라 - 전체 사원의 6개월치 급여의 총합
SELECT SUM(sal*6) FROM emp;
-- 10. 사원의 이름을 'Name'으로, 사원의 급여를 'Salary'로 열의 이름을 부여하여 검색하라
SELECT ename AS 'Name', sal AS 'Salary' FROM emp;
-- 11. 사원의 사원번호, 이름, 부서번호, 입사일자를 제목을 한글로 변경하여 검색하라
SELECT empno AS '사원번호', ename AS '이름', depno AS '부서번호', hiredate AS '입사일자' FROM emp;
-- 12. 부서테이블에서 부서번호, 부서명, 지역을 한글 제목으로 검색하라
SELECT deptno AS '부서번호', dname AS '부서명', loc AS '지역' FROM dept;
 -- 13. 10번 부서에 근무하는 사원들의 이름을 검색하라
SELECT ename FROM emp WHERE deptno='10';
-- 14. 급여가 2000이상인 사원들의 사원번호, 이름을 검색하라
SELECT deptno, ename, sal FROM emp WHERE sal >= 2000;
-- 15. 직무가 'CLERK'인 사원들의 사원번호, 이름을 검색하라
SELECT * FROM emp;
SELECT deptno, ename FROM emp WHERE job = 'CLERK'; 
-- 16. 1980년 12월 17일에 입사한 사원들의 이름을 검색하라
SELECT * FROM emp;
SELECT ename FROM emp WHERE hiredate = '1980-12-17';
-- 17. 부서번호 30이외의 부서명과 지역을 검색하라
SELECT * FROM dept;
SELECT dname, loc FROM dept WHERE deptno IN(10,20,40); 
-- 18. 급여등급 테이블에서 급여등급이 3인 급여의 최대급여와 최소급여를 검색하라
SELECT * FROM salgrade;
SELECT losal, hisal FROM salgrade WHERE grade = 3;
-- 19. 'WARD' 사원의 모든 정보를 검색하라
select * FROM emp;
SELECT * FROM emp WHERE ename = 'WARD';
-- 20. 10번 부서에 근무하는 MANAGER의 이름을 검색하라
SELECT *FROM emp;
SELECT ename FROM emp WHERE deptno = 10;
-- 21. 급여가 2000이상이며, 30번 부서에 근무하는 사원들의 사원번호, 이름을 검색하라
SELECT * FROM emp;
SELECT empno, ename FROM emp 
WHERE deptno = 30 AND sal>= 2000;
-- 22. 직무가 'CLERK'이며, 81년 이후에 입사한 사원들의 사원번호, 이름을 검색하라
SELECT * FROM emp;
SELECT deptno, ename FROM emp 
WHERE job = 'CLERK' AND hiredate>1981;
-- 23. 20부서 외에 근무하는 MANAGER의 이름을 검색하라
SELECT ename FROM emp WHERE deptno !=20 ;
-- 24. BOSTON이외 지역에 있는 부서의 부서명을 검색하라
SELECT dname FROM dept WHERE loc != 'BOSTON';
-- 25. job이 'ANALYST'이며 급여가 2000 이하인 사원의 이름을 검색하라
SELECT ename FROM emp WHERE job = 'ANALYST' AND sal <=2000;
-- 26. 급여가 1000 이상이며, 2500 이하인 사원의 사원번호와 이름을 검색하라
SELECT * FROM emp;
SELECT ename, empno FROM emp WHERE sal >= 1000 AND sal <=2500;
-- 27. 사원번호 75XX인 사원의 사원번호와 이름, 부서번호를 검색하라
SELECT * FROM emp;
SELECT ename, empno, deptno FROM emp WHERE mgr LIKE '75%'; 
-- 28. 부서번호 10 또는 30에 근무하는 사원들의 이름과 급여를 검색하라
SELECT * FROM emp;
SELECT ename, sal FROM emp WHERE deptno = 10 OR deptno =30;
-- 29. 매니저가 번호가 76xx으로 시작하는 사원들의 이름을 검색하라
SELECT * FROM emp;
SELECT ename FROM emp WHERE mgr LIKE '76%';
-- 30. 이름 중간에 'A'가 들어있는 사원의 사원번호, 이름을 검색하라
SELECT * FROM emp;
SELECT empno, ename FROM emp WHERE ename LIKE '_A%'; 
-- 31. 매니저가 NULL이 아닌 사원의 사원번호, 이름, 매니저를 검색하라
SELECT * FROM emp;
SELECT empno, ename, mgr FROM emp WHERE mgr != NULL;
-- 32. 매니저 번호가 7698 또는 7839인 사원의 사원번호, 이름을 검색하라
SELECT * FROM emp;
SELECT empno, ename FROM emp WHERE mgr = 7698 OR mgr = 7839;
-- 33. 직무가 'MANAGER' 또는 'SALESMAN'인 사원의 사원번호, 이름, 부서번호를 검색하라
SELECT * FROM emp;
SELECT empno, ename, deptno FROM emp 
WHERE job = 'MANAGER' OR job = 'SALESMAN';
-- 34. 사원들의 사원번호, 이름을 사원번호순으로 검색하라
SELECT * FROM emp;
SELECT empno, ename FROM emp ORDER BY empno ASC;
-- 35. 사원들의 사원번호, 이름을 부서번호, 이름순으로 검색하라
SELECT * FROM emp;
SELECT empno, ename FROM emp ORDER BY deptno ASC,ename ASC;
-- 36. 사원들의 정보를 부서별 급여가 많은 순으로 검색하라
SELECT * FROM emp;
SELECT * FROM emp ORDER BY sal DESC;
-- 37. 사원들의 정보를 부서별, 직무별, 급여 순으로 검색하라
SELECT * FROM emp;
SELECT * FROM emp ORDER BY deptno ASC,job ASC, sal ASC;
-- 38. 사원테이블의 전체 행 수를 검색하라
SELECT * FROM emp;
SELECT COUNT(empno) FROM emp;
-- 39. 사원테이블의 급여 평균을 구하라.
SELECT AVG(sal) FROM emp;
-- 40. 전체 사원들 중 최고 커미션을 받는 사원의 사원번호, 이름, 커미션을 구하라
SELECT empno, ename, comm FROM emp WHERE MAX(comm); 
-- 41. 전체 사원들 중 최저 커미션을 받는 사원의 사원번호, 이름, 커미션을 구하라
SELECT empno, ename, comm FROM emp WHERE MIN(comm); 
-- 42. 부서별 사원들의 평균 급여를 검색하라
SELECT AVG(sal) FROM emp GROUP BY deptno;
-- 43. 부서별 사원의 급여 합을 검색하라
SELECT SUM(sal) FROM emp GROUP BY deptno;
-- 44. 부서별 사원들의 평균 급여를 검색하라
SELECT AVG(sal) FROM emp GROUP BY deptno;
-- 45. 부서별 사원들의 입사일자의 최고값과 최저값을 검색하라
SELECT MAX(hiredate), MIN(hiredate) FROM emp GROUP BY deptno;
-- 46. 부서별 사원들의 인원수를 인원수가 많은 순으로 검색하라
SELECT SUM(deptno) FROM emp ORDER BY 
(SELECT COUNT(deptno) FROM emp)ASC;
-- 47. 부서별 사원들의 평균 급여를 평균 급여 순으로 검색하라
SELECT AVG(sal) FROM emp ORDER BY AVG(sal) ASC;
-- 48. 부서별 사원의 급여 합을 많은 순으로 검색하라

-- 49. 부서지역이 NEW YORK인 사원의 이름을 검색하라
SELECT * FROM emp;

-- 50. ADAMS 사원이 근무 중인 부서명과 지역을 검색하라
