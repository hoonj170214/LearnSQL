-- DML (Data Manipulation Language) 데이터 조작어
-- sqldb에 명령문 실행 database changed
USE sqldb;

DESC usertbl;

-- db.테이블 이름 하는 건 외부 데이터 베이스에서 원하는 데이터베이스의 테이블을 보고 싶을 때 사용
SELECT * FROM sqldb.userTbl;
-- userTbl에 저장된 모든 속성을 행단위로 검색 
SELECT * FROM userTbl;
-- sqlDB의 userTbl테이블에서 name 속성만 검색
SELECT name FROM userTbl;

-- usertbl에서 mDate, name, userId열을 순서대로 나오게 검색
DESC userTbl;
SELECT mDate, name, userID From userTbl;
-- userID는 '아이디'로 name은 '이름'으로 mDate는 ','가입일'로 검색
SELECT 
userID AS '아이디',name AS'이름', mDate AS '가입일' 
From userTbl;

/*
	지정한 테이블에 지정한 속성별로
    행정보를 추가(삽입)하는 insert문
*/
SELECT *FROM buytbl;
DESC buyTbl;
SElECT * FROM userTbl;
-- userTbl에 사용자 추가하기
INSERT INTO userTbl(userID, name, birthyear, addr, height, mdate)
VALUES('HGD', '홍길동', 1000, '한양', 176, 20230712);

-- buyTbl에 값 추가하기
INSERT INTO buyTbl VALUES(null, 'HGD', '책', null, 50, 1);
INSERT INTO buyTbl (userID, prodName, price, amount) 
VALUES('HGD', '책', 30, 5);

-- 삽입될 속성을 지정하지 않으면 모든 속성을 순서대로 나열
-- num field의 기본 키 값이 중복됨으로 오류가 발생
INSERT INTO buyTbl 
VALUE(1, 'KBS','티셔츠','의류',50, 1);
-- IGNORE 키가 중복이 되면 현재 INSERT 문을 실행하지 않고 무시한다.
INSERT IGNORE INTO buyTbl 
VALUES(1, 'KBS', '티셔츠', '의류',30, 1);

-- REPLACE INTO 
-- 키가 중복이 되면 기존 데이터를 삭제하고, 새로운 데이터 추가
-- 키가 중복되지 않으면 새로운 행을 추가 
REPLACE INTO buyTbl VALUE(1, 'KBS', '티셔츠', '의류',30, 1);
SELECT*FROM buyTbl;

-- 다중행 삽입
INSERT INTO buyTbl (userId, prodName, groupName, price, amount)
VALUES('KBS','모니터','전자',150,1),
	('JYP','노트북','전자',200,2);
SELECT * FROM buyTbl;

/*
	저장된 데이터(TABLE)에서 필요한 정보 조건에 따라 추출
    SELECT ~ FROM ~WHERE 조건절
*/

-- userTbl 에서 이름이 '김경호'인 회원을 검색하세요
SELECT * FROM userTbl WHERE (name='김경호');

-- 1970년 이후에 출생하고 키가 182이상인 사람의 아이디와 이름을 검색하세요 .
SELECT userId, name, birthYear, height FROM userTbl 
WHERE (birthYear >= 1970 AND height >= 182);

-- 1970년 이후에 출생했거나 키가 182 이상인 사람의 아이디와 이름을 검색하세요.
SELECT userId, name, birthYear, height FROM userTbl
WHERE birthYear >=1970 OR height >= 182;

-- userTbl에서 키가 180이상, 183이하인 사람을 검색하세요.
SELECT * FROM userTbl
WHERE height >= 180 AND height <=183;
-- 위와 아래 값은 같은 결과
-- WHERE 속성이름 BETWEEN 값 AND 값 == 범위 검색
SELECT *FROM userTbl
WHERE height BETWEEN 180 AND 183;

SELECT * FROM userTbl
WHERE addr = '경남' OR addr = '전남' OR addr = '경북';
-- 위 아래 같은 결과 
-- WHERE 속성이름 IN 값, 값, 값 -> 지정한 속성에 IN으로 전달된 값과 일치하는 값이면 범위에 포함
SELECT * FROM userTbl
WHERE addr IN('경남','전남','경북');

-- :userTbl에서 1970생의 정보를 검색 
-- 1970년부터 1979년까지 검색하면 됨.
SELECT * FROM userTbl
WHERE birthyear BETWEEN 1970 AND 1979;
-- 197x 가 반복된다. LIKE 써서 쉽게 할 수 있다.
/*
	WHERE LIKE 절 : 특정 글자 또는 문자가 포함되어 있는 패턴을 만족하는 다수의 정보를 검색
    % : 글자 수 상관없이 검색(없거나 많거나)
    _ : 한개의 문자 (한 자리)
*/
SELECT * FROM userTbl
WHERE birthYear LIKE '197_';

-- userTbl에서 성이 '김'씨인 모든 사용자 정보 검색
SELECT * FROM userTbl
WHERE name LIKE '김%';

-- usertbl table 에서 등록된 사용자 중에 이름이 '수'가 포함이 된 사용자 검색
SELECT * FROM userTbl
WHERE name LIKE '%수%';

-- 2013년 이전에 가입한 사용자 정보를 검색
SELECT * FROM userTbl WHERE mdate < '2013-01-01';

-- Null 값 비교
-- userTbl 에서 mobile1 - 핸드폰 번호가 없는 사용자 목록 검색
-- SELECT * FROM userTbl WHERE mobile1 = NULL;
-- NULL 을 비교할 수 없으므로 검색 결과가 없음
SELECT * FROM userTbl WHERE mobile1 IS NULL;

-- userTbl 에서 mobile1 - 핸드폰 번호가 존재하는 사용자 목록 검색
-- SELECT * FROM userTbl WHERE mobile1 IS != NULL;
SELECT * FROM userTbl WHERE mobile1 IS NOT NULL;
SELECT * FROM userTbl WHERE NOT mobile1 IS NULL;

-- 거주지(주소 : addr)이 서울이 아닌 사용자 검색
SELECT * FROM userTbl WHERE NOT addr='서울';
-- 값이니까 비교 연산자 사용할 수 있다
SELECT * FROM userTbl WHERE addr !='서울';
SELECT * FROM userTbl WHERE NOT name LIKE '%수%';
SELECT * FROM userTbl WHERE addr <> '서울';

-- 전화번호 시작(mobile1)이 016, 018, 019인 사람 검색
SELECT * FROM userTbl WHERE mobile1 IN('016', '018', '019'); 
-- 전화번호 시작(mobile1)이 016, 018, 019인 사람 검색
SELECT * FROM userTbl WHERE NOT mobile1 IN('016', '018', '019'); 
SELECT * FROM userTbl WHERE mobile1 NOT IN('016', '018', '019'); 

-- 정렬, 검색된 행의 정보를 정렬해주는 명령어
-- ORDER BY 검색기준 열 ASC OR DESC
-- ASC 오름차순 정렬 (default)
-- DESC 내림차순 정렬
-- userTbl에 사용자들을 거주 지역(addr) 별로 정렬
SELECT * FROM userTbl ORDER BY addr ASC;
SELECT * FROM userTbl ORDER BY addr DESC;

-- 가장 최근에 가입한 순서부터 출력되게 정렬
SELECT * FROM userTbl ORDER BY mdate DESC;
-- 가입한 시간이 가장 오래된 사용자부터 출력되게 정렬
-- 정렬은 기본이 ASC(오름차순), 정렬방법을 생략하면 ASC
SELECT * FROM userTbl ORDER BY mdate;

-- 거주 지역 순으로 오름 차순으로 정렬하고
-- 거주 지역이 동일하면 나이순으로 역순으로 정렬 
-- 쉼표로 구분해서 적용하면 된다(개수 제한 없음). 
SELECT * FROM userTbl 
ORDER BY addr, birthYear DESC;

-- userTbl에서 회원들이 거주 지역이 몇 군데인지 세어보자
-- DISTINCT : 중복 제거한 결과만 추려서 사용가능, 검색 결과 내에서 중복 데이터 제거
SELECT DISTINCT addr FROM userTbl ORDER BY addr DESC;

-- 키가 175 이상인 사용자가 거주하는 지역이 어디인지 중복을 제거하고 검색
SELECT * FROM userTbl WHERE height >= 175;
-- 두 가지 속성을 distinct로 지정하면, 두가지 속성이 모두 일치해야 중복으로 인정되고 중복이 제거됨.
-- 검색 속성이 다수면, 검색할 속성의 값이 모두 일치해야 중복으로 인정된다. 
-- 중복으로 인정돼야 distinct 로 제거된다. 
SELECT addr, height FROM userTbl WHERE height >= 175;
SELECT distinct addr, height FROM userTbl WHERE height >= 175;

-- 검색 결과내에서 정렬된 목록에서 0에서 부터 시작하는 인덱스 번호를 기준으로
-- 검색할 행의 개수를 제한하는 명령어
-- LIMIT 개수; (시작인덱스 번호를 0으로 지정한 것과 같음)
-- LIMIT 시작인덱스 번호, 개수;
-- LIMIT 개수 OFFSET 시작인덱스;
SELECT * FROM userTbl
ORDER BY mDate DESC LIMIT 5;
-- ORDER BY mDate DESC LIMIT 0, 5; 랑 같다.
SELECT * FROM userTbl
ORDER BY mDate DESC LIMIT 0, 5;

SELECT * FROM userTbl
ORDER BY mDate DESC LIMIT 5, 5;

SELECT * FROM userTbl
ORDER BY mDate DESC LIMIT 6 OFFSET 5;

-- 데이터 변경 작업을 수행할 SAMPLE TABLE 생성
CREATE TABLE buyTbl2(
	SELECT * FROM buyTbl
);

SELECT * FROM buyTbl2;
DESC buyTbl2;

CREATE TABLE buyTbl3 LIKE buyTbl;
DESC buyTbl3;
SELECT * FROM buyTbl3;

INSERT INTO buytbl3 SELECT * FROM buytbl;
/*
	테이블의 행의 속성 값을 변경 (수정)
    update 문
    UPDATE 'table명' SET '수정할 열이름'=값, '수정할 열이름'=값
    WHERE '수정할 행을 구분지을 열이름' = 수정할 행 구분 열 값
*/

-- buytbl2 테이블의 price 속성 값을 0으로 수정
UPDATE buytbl2 SET price = 0;
SELECT * FROM buytbl2;
SELECT * FROM buytbl3;

-- buytbl2 테이블의 상품중에 모니터 가격을 250으로 수정
UPDATE buytbl2 SET price = 250 WHERE prodname='모니터';
-- buytbl2에서 모든 물품의 가격을 50 인상
UPDATE buytbl2 SET price = price + 50;

-- buytbl3 의 상품 중 '청바지'의 가격을 60으로, 판매개수를 5로 변경
UPDATE buytbl3 SET price = 60, amount= 5 WHERE prodname='청바지';

SELECT * FROM buytbl3;

/*
	DELETE 문
    table에 삽입되어있는 행의 정보를 삭제 - 제거 하는 명령
    DELETE FROM '삭제작업을 진행할 테이블'
    OPTIONAL 
    WHERE '조건 열' = 비교값;
*/

-- table 전체가 삭제 되는 것
DELETE FROM buytbl2;
Select * FROM buytbl2;

DELETE FROM buytbl3 WHERE userID = 'BBK';
SELECT * FROM buytbl3;

-- table 에 저장된 모든 행 정보를 삭제
TRUNCATE buytbl3;