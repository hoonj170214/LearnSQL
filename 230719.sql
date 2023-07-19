use sqldb;
show databases;
-- userTbl 에서 '김경호'보다 키가 크거나 같은 사람을 검색하세요.
SELECT height FROM sqldb.usertbl WHERE name = '김경호';

-- 김경호 키 == 177
SELECT * FROM usertbl WHERE height >= 177;

-- sub query or 부 질의 -> select 문 안에 또 select 문 쓰기
SELECT * FROM userTbl WHERE height >= 
(SELECT height FROM userTbl WHERE name = '김경호');

-- userTbl에서 주소가 '경남'인 사람의 키보다 크거나 같은 사람을 검색하세요
SELECT * FROM userTbl WHERE addr = '경남';
-- 170, 173
-- 두가지 값이 나오기 때문에 어떤 것으로 비교해야 할지 몰라서 오류가 난다.
-- 서브쿼리로 나온 값으로 비교하기 위해서는 어떤 값으로 비교해야 할지 정해줘야 한다.
-- any, all
SELECT * FROM usertbl WHERE height >= 
(SELECT height FROM userTbl WHERE addr ='경남');

/*
서브쿼리 가능한 곳 

1. SELECT 절

2. FROM 절

3. WHERE 절

4. HAVING 절

5. ORDER BY 절

6. INSERT 문의 VALUES 절

7. UPDATE 문의 SET 절


서브쿼리 사용시 주의사항

1. 서브쿼리를 괄호로 감싸서 사용한다.

2. 서브쿼리는 단일 행 또는 복수 행 비교 연산자와 함께 사용 가능하다.

3. 서브쿼리에서는 ORDER BY 를 사용하지 못한다.
*/

-- sub query에서 검색된 모든 결과값 중 하나라도 만족하면 검색에 포함
-- 둘 중에 하나라도 만족하면 결과를 띄워주는 것 -> any
-- 170 이상인 사람을 조회
SELECT * FROM usertbl WHERE height >= any
(SELECT height FROM userTbl WHERE addr ='경남')
ORDER BY height ASC;

-- sub query에서 검색된 모든 결과값을 만족하는 행 검색
-- 둘 다 만족해야 하는 결과를 띄워주는 것 -> all
-- 173 이상인 사람을 조회
SELECT * FROM usertbl WHERE height >= all
(SELECT height FROM userTbl WHERE addr ='경남')
ORDER BY height ASC;

-- userTbl table에서 경남에 사는 사람과 키가 일치하는 사용자 정보 검색
-- 1. 경남에 사는 사람의 키 검색
SELECT height FROM userTbl WHERE addr='경남';
-- 2. 경남에 사는 사람의 키와 일치하는 사람을 검색
SELECT name, height, addr FROM userTbl
WHERE height = 170 OR height =173;
-- 위랑 아래 같은 결과 -> in 뒤에 나열한 조건들 중 일치하는 row 검색
SELECT name, height, addr FROM userTbl
WHERE height in(170,173);
-- 값을 지정해주면 경남 사용자가 추가되었을 때, 값을 변경해줘야 하는 단점있음.

-- 한꺼번에 합쳐서 검색
-- 사용자가 추가되었을 때, 실시간 데이터를 가져오기 때문에 수정하지 않아도 되서 좋음.
SELECT name, height, addr FROM userTbl
WHERE height IN(
	SELECT height FROM userTbl WHERE addr = '경남'
);

-- userTbl에 등록된 회원의 상품 구매 정보를 저장하는 table
SELECT * FROM buytbl;

-- 집계함수
/*
여러행으로부터 하나의 결과값을 반환하는 함수
SUM() : 합계
AVG() : 평균
MIN() : 최솟값
MAX() : 최댓값
COUNT() : 행의 개수
COUNT(DISTINCT ) : 행의 개수(중복 1개로 처리)
STDEV(), STD() : 표준편차
VARIANCE(), VAR_SAMP() : 분산
*/

-- buytbl table의 전체 판매개수
SELECT sum(amount) AS '구매개수' FROM buyTbl;
-- buyTbl table의 평균 판매개수
SELECT AVG(amount) AS '평균 구매개수' FROM buyTbl;
-- 구매자 테이블에서 행별 판매 금액 출력
SELECT *, (price*amount)  AS '판매금액' FROM buyTbl;

-- buyTbl 테이블에서 판매된 총 판매금액 출력
SELECT SUM(price*amount) AS '총 판매금액' FROM buyTbl;  

-- count() table에 의미있는 값이 존재하는 행의 개수를 검색
SELECT * FROM buyTbl;
-- 하나라도 유효한 데이터를 가지고 있으면 개수에 포함
-- 전체 행의 개수를 출력하는 것과 동일
SELECT count(*) FROM buyTbl;

-- mobile1 속성에 의미있는 데이터를 저장하고 있는 행의 개수
SELECT * FROM userTbl;
SELECT count(mobile1) FROM userTbl;

-- null이 아닌 것만 출력(의미있는 것만 출력)
SELECT * FROM userTbl WHERE mobile1 IS NOT NULL;

-- 열에 의미있는 데이터가 포함되어 있으면 출력
SELECT count(*) FROM userTbl;

-- 의미있는 데이터 중에서 null이 아닌 데이터만 출력
SELECT count(*) FROM userTbl WHERE mobile1 IS NOT NULL;

-- 주소값을 내림차순으로 정렬해서 출력
SELECT addr FROM userTbl ORDER BY addr DESC;

-- 주소값을 내림차순으로 정렬, 중복된 값 제외하고 출력
SELECT DISTINCT addr FROM userTbl ORDER BY addr DESC;

-- 회원들이 거주하는 거주지역 중복포함 개수
SELECT COUNT(addr) FROM userTbl;
-- 회원들이 거주하는 거주지역 개수(중복제외)
SELECT COUNT(distinct addr) FROM userTbl; 

-- 키가 175이상인 사용자의 거주지 개수를 중복을 제외하고 검색
SELECT addr, height FROM userTbl
WHERE height>=175;

SELECT DISTINCT addr, height FROM userTbl
WHERE height>=175;

-- count는 결과가 1개로 출력, 키는 여러개이므로, 개수가 맞지 않다. 
-- key를 어떤 값으로 가져와야할지 모르기 때문에 오류 발생
-- count함수랑 일반 속성값이랑 같이 출력할 수 없다.
SELECT COUNT(DISTINCT addr),height FROM userTbl WHERE height>=175;

SELECT COUNT(DISTINCT addr) FROM userTbl WHERE height>=175;

-- min(), max() - 동일 속성에 저장된 최소값과 최대값을 검색
-- userTbl에서 키가 가장 작은 사람과 키가 가장 큰 사람의 키 검색
SELECT min(height) FROM userTbl;
SELECT max(height) FROM userTbl;

-- 여러개도 한번에 조회할 수 있다.
SELECT 
	min(height) AS'작은 키', max(height)AS'큰 키' 
FROM userTbl;

-- userTbl에서 키가 가장 작은 사람과 키가 가장 큰 사람의 이름과 키 검색
-- 직접 확인하고 최단신, 최장신의 키를 조회하기
SELECT
	name, height FROM userTbl ;

SELECT
	name, height FROM userTbl 
    WHERE height= 166 or height = 186;
 -- WHERE height IN(); IN 안에 166, 186... 넣어줘도 됨.
 
-- 값을 넣어주지 않고, 실시간 값을 조회하는 방법
SELECT
	name, height FROM userTbl 
    WHERE height = (SELECT min(height) FROM userTbl)
    OR height= (SELECT max(height) FROM userTbl);
-- 위 아래 같은 식-> IN 안에 나열할 수 있음.
SELECT
	name, height FROM userTbl 
    WHERE height IN((SELECT min(height) FROM userTbl),
    (SELECT max(height) FROM userTbl));

-- avg() -평균을 구해주는 집계함수
-- 합계랑 개수를 구해서 평균을 계산할 수도 있다.
SELECT 
sum(height),count(height), (sum(height)/count(height))
FROM userTbl;

-- avg() 함수를 쓸 수도 있다.
SELECT avg(height) FROM userTbl;

SELECT avg(height) AS '평균키' FROM userTbl;

-- 분산
-- 확률변수가 기댓값으로부터 얼마나 떨어진 곳에 분표하는지를 가늠하는 숫자
-- (실제값 - 평균값) 을 제곱하여 더한 뒤 전체 행 개수로 나눔
SELECT variance(height) FROM userTbl;

SELECT avg(height) FROM userTbl;
SELECT 
	sum((height-175.8182)*(height-175.8182))
FROM userTbl;

SELECT 
	sum((height-175.8182)*(height-175.8182))/11
FROM userTbl;

-- 30.694214876364 | 30.694214876364

-- 표준편차 - 분산의 제곱근
SELECT STD(height) FROM userTbl;

SELECT * FROM buyTbl ORDER BY userID DESC;

-- buyTbl에서 각 회원 당 총 구매량을 구하세요.
SELECT userID, SUM(amount) FROM buyTbl GROUP BY userID;
-- userID로 묶었으니까(GROUP BY), 
-- userID를 검색에 포함시켜서 같이 출력할 수 있다.
-- group by 로 안묶은 속성은 같이 출력할 수 없다.

-- buyTbl에서 각 회원 당 총 구매액을 구하세요.
-- 구매액을 내림차순으로 구하고 3개만 출력
SELECT * FROM buyTbl;
	SELECT userID, SUM(PRICE*amount) AS '구매액'
FROM buyTbl GROUP BY userID ORDER BY 구매액 DESC LIMIT 3;

-- buyTbl 테이블의 상품 그룹별 판매 금액 합계 출력
SELECT groupname,SUM(PRICE * AMOUNT) AS '판매금액 합계' 
FROM buyTbl GROUP BY groupname;

-- 지역별 평균 키를 역순으로 정렬하여 출력
SELECT * FROM usertbl;
SELECT addr,AVG(height) FROM userTbl GROUP BY addr;