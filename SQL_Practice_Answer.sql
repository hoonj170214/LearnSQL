/**
    신규 databASe(Schema 생성)
    databASe 명 : develop_sql
    develop_sql 생성 후 develop_sql databASe에
    emp, dept, salgrade sample data 추가
*/

USE develop_sql;

SELECT * FROM emp;			-- 사원 테이블
SELECT * FROM dept;			-- 부서 테이블
SELECT * FROM salgrade;		-- 급여 테이블

-- 1. 실습에 사용될 EMP 테이블의 구조를 검색하라
DESC emp;
DESCRIBE dept;
DESCRIBE salgrade;

-- 2. 부서의 부서코드와 부서명을 검색하라
SELECT deptno, dname FROM dept;

-- 3. 부서의 부서명과 지역을 검색하라
SELECT dname, loc FROM dept;

-- 4. 사원들의 급여와 커미션을 검색하라
SELECT sal, comm FROM emp;

-- 5. 사원들의 입사일자를 중복을 제거하고 검색하라
SELECT DISTINCT hiredate FROM emp  ORDER BY hiredate DESC;
SELECT count(hiredate) FROM emp;
SELECT count(DISTINCT hiredate) FROM emp;
SELECT hiredate FROM emp ORDER BY hiredate DESC;

-- 6. 사원들의 매니저를 중복을 제거하고 검색하라
SELECT DISTINCT mgr FROM emp;

-- 5번 문제와 동일
-- 7. 사원들의 입사일자를 중복을 제거하고 검색하라
-- GROUP BY는 정렬도 해준다.
SELECT hiredate FROM emp GROUP BY hiredate;

-- 8. 사원들의 부서번호를 중복을 제거하고 검색하라
SELECT DISTINCT deptno FROM emp;

-- 9. 사원들의 6개월 급여의 합을 구하라
SELECT sum(sal * 6) FROM emp;

-- 10. 사원의 이름을 'Name'으로, 사원의 급여를 'Salary'로 열의 이름을 부여하여 검색하라
SELECT ename AS Name, sal AS Salary FROM emp;

-- 11. 사원의 사원번호, 이름, 부서번호, 입사일자를 제목을 한글로 변경하여 검색하라
SELECT 
	empno AS 사원번호, 
    ename AS 이름, 
    deptno AS 부서번호, 
    hiredate AS 입사일자 
FROM emp;

-- 12. 부서테이블에서 부서번호, 부서명, 지역을 한글 제목으로 검색하라
SELECT deptno AS 부서번호, dname AS 부서명, loc AS 지역 FROM dept;

-- 13. 10번 부서에 근무하는 사원들의 이름을 검색하라
SELECT ename FROM emp WHERE deptno = 10;

-- 14. 급여가 2000이상인 사원들의 사원번호, 이름을 검색하라
SELECT empno, ename FROM emp WHERE sal >= 2000;

-- 15. 직무가 'CLERK'인 사원들의 사원번호, 이름을 검색하라
SELECT empno, ename FROM emp WHERE job = 'CLERK';

-- 16. 1980년 12월 17일에 입사한 사원들의 이름을 검색하라
SELECT ename FROM emp WHERE hiredate = 19801217;

-- 17. 부서번호 30이외의 부서명과 지역을 검색하라
SELECT dname, loc FROM dept WHERE deptno =! 30;

-- 18. 급여등급 테이블에서 급여등급이 3인 급여의 최대급여와 최소급여를 검색하라
SELECT hisal, losal FROM salgrade WHERE grade=3;

-- 19. 'WARD' 사원의 모든 정보를 검색하라
SELECT * FROM emp WHERE ename='WARD';

-- 20. 10번 부서에 근무하는 MANAGER의 이름을 검색하라
SELECT ename FROM emp WHERE job = 'MANAGER' AND deptno = 10;

-- 21. 급여가 2000이상이며, 30번 부서에 근무하는 사원들의 사원번호, 이름을 검색하라
SELECT empno, ename FROM emp WHERE sal >= 2000 AND deptno = 30;

-- 22. 직무가 'CLERK'이며, 81년 이후에 입사한 사원들의 사원번호, 이름을 검색하라
SELECT empno, ename FROM emp WHERE job='CLERK' AND hiredate > 19811231;

-- 23. 20부서 외에 근무하는 MANAGER의 이름을 검색하라
SELECT ename FROM emp WHERE deptno != 20 AND job = 'MANAGER';

-- 24. BOSTON이외 지역에 있는 부서의 부서명을 검색하라
SELECT dname FROM dept WHERE loc != 'BOSTON';

-- 25. job이 'ANALYST'이며 급여가 2000 이하인 사원의 이름을 검색하라
SELECT ename FROM emp WHERE job = 'ANALYST' AND sal <= 2000;

-- 26. 급여가 1000 이상이며, 2500 이하인 사원의 사원번호와 이름을 검색하라
SELECT empno, ename FROM emp WHERE sal BETWEEN 1000 AND 2500;

-- 27. 사원번호 75XX인 사원의 사원번호와 이름, 부서번호를 검색하라
SELECT empno, ename, deptno FROM emp WHERE empno LIKE '75%';

-- 28. 부서번호 10 또는 30에 근무하는 사원들의 이름과 급여를 검색하라
SELECT ename, sal FROM emp WHERE deptno IN(10, 30);

-- 29. 매니저가 번호가 76xx으로 시작하는 사원들의 이름을 검색하라
SELECT ename FROM emp WHERE mgr like '76%';

-- 30. 이름 중간에 'A'가 들어있는 사원의 사원번호, 이름을 검색하라
SELECT empno, ename FROM emp WHERE ename LIKE '%A%';
-- instr(확인할 문자열, 검색할 문자열)   활인할 문자열에 검색할 문자열이 포함되어있으면
-- 시작 위치를 반환 1에서 부터 시작
SELECT empno, ename FROM emp WHERE instr(ename, 'A') > 0;

-- 31. 매니저가 NULL이 아닌 사원의 사원번호, 이름, 매니저를 검색하라
SELECT empno, ename, mgr FROM emp WHERE mgr IS NOT NULL;

-- 32. 매니저 번호가 7698 또는 7839인 사원의 사원번호, 이름을 검색하라
SELECT empno, ename FROM emp WHERE mgr IN (7698, 7839);

-- 33. 직무가 'MANAGER' 또는 'SALESMAN'인 사원의 사원번호, 이름, 부서번호를 검색하라
SELECT empno, ename, deptno FROM emp WHERE job IN('MANAGER','SALESMAN');

-- 34. 사원들의 사원번호, 이름을 사원번호순으로 검색하라
SELECT empno, ename FROM emp ORDER BY empno;

-- 35. 사원들의 사원번호, 이름을 부서번호, 이름순으로 검색하라
SELECT empno, ename FROM emp ORDER BY deptno, ename;

-- 36. 사원들의 정보를 부서별, 급여가 많은 순으로 검색하라
SELECT * from emp ORDER BY deptno, sal DESC;

-- 37. 사원들의 정보를 부서별, 직무별, 급여 순으로 검색하라
SELECT * from emp ORDER BY deptno, job, sal DESC;

-- 38. 사원테이블의 전체 행 수를 검색하라
SELECT count(*) FROM EMP;

-- 39. 사원테이블의 급여 평균을 구하라.
SELECT avg(sal) AS '급여 평균' FROM emp;

-- 40. 전체 사원들 중 최고 커미션을 받는 사원의 사원번호, 이름, 커미션을 구하라
SELECT empno, ename, comm FROM emp 
WHERE comm = (SELECT min(comm) FROM emp);

-- 41. 전체 사원들 중 최저 커미션을 받는 사원의 사원번호, 이름, 커미션을 구하라
SELECT empno, ename, comm FROM emp 
WHERE comm = (SELECT max(comm) FROM emp);

-- 42. 부서별 사원들의 평균 급여를 검색하라
SELECT avg(sal) FROM emp GROUP BY deptno;

-- 43. 부서별 사원의 급여 합을 검색하라
SELECT deptno, sum(sal) FROM emp  GROUP BY deptno ORDER BY deptno;

-- 43. 부서별,직무별 사원의 급여 합을 검색하라
SELECT deptno, job, sum(sal) FROM emp  
GROUP BY deptno, job ORDER BY deptno;

-- 44. 부서별 사원들의 평균 급여를 검색하라
SELECT deptno, avg(sal) FROM emp GROUP BY deptno ORDER BY deptno;

-- 44. 부서별, 직무별 사원들의 평균 급여를 검색하라
SELECT deptno, job, avg(sal) FROM emp GROUP BY deptno, job ORDER BY deptno;

-- 45. 부서별 사원들의 입사일자의 최고값과 최저값을 검색하라
SELECT 
	deptno, 
	mIN(hiredate) AS '오래된 사원', 
	max(hiredate) AS '최근사원' 
FROM emp GROUP BY deptno;

-- 45. 부서별, 직무별 사원들의 입사일자의 최고값과 최저값을 검색하라
SELECT deptno, job, max(hiredate), min(hiredate) FROM emp GROUP BY deptno, job;

-- 46. 부서별 사원들의 인원수를 인원수가 많은 순으로 검색하라
SELECT count(empno) AS 인원수 FROM emp 
GROUP BY deptno ORDER BY 인원수 DESC;

-- 47. 부서별 사원들의 평균 급여를 평균 급여 순으로 검색하라
SELECT avg(sal) AS '평균급여' FROM emp GROUP BY deptno ORDER BY 평균급여;

-- 48. 부서별 사원의 급여 합을 많은 순으로 검색하라
SELECT deptno, sum(sal) FROM emp 
GROUP BY deptno ORDER BY sum(sal) DESC;

-- 48. 부서별, 직무별 사원의 급여 합을 많은 순으로 검색하라
SELECT deptno, job, sum(sal) FROM emp 
GROUP BY deptno, job ORDER BY sum(sal) DESC;

-- 49. 부서지역이 NEW YORK인 사원의 이름을 검색하라
SELECT ename FROM emp 
WHERE deptno = (SELECT deptno FROM dept WHERE loc='NEW YORK');

-- 50. ADAMS 사원이 근무 중인 부서명과 지역을 검색하라
SELECT dname, loc FROM dept 
WHERE deptno = (SELECT deptno FROM emp WHERE ename='ADAMS');

