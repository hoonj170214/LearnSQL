SHOW DATABASES;
-- 현재 서버에 존재하는 database or schema 목록 확인

CREATE DATABASE sqlDB;

CREATE SCHEMA IF NOT EXISTS sqlDB;
-- SQL database 가 존재하지 않으면 생성 

USE sqlDB;

-- COMMENT 는 다른 사람이 알아볼 수 있게 코멘트 남기는 것
CREATE TABLE userTbl(
userID CHAR(8) PRIMARY KEY COMMENT '사용자 구분 pk',
name VARCHAR(10) NOT NULL COMMENT '회원 이름',
birthyear INT NOT NULL COMMENT '생년월일',
addr CHAR(2) NOT NULL COMMENT '주소',
mobile1 CHAR(3) COMMENT '전화번호 1',
mobile2 CHAR(8),
height SMALLINT COMMENT'키',
mDate DATE 
)COMMENT = '테스트용 사용자 테이블';

/*
	tinyint : 1byte
    smallint : 2byte
    mediumint : 3byte
    int : 4byte
    bigint : 8byte
*/

-- 테이블 정보 확인하는 코드 describe
DESCRIBE userTbl;

-- 
SHOW COLUMNS FROM userTbl;

-- 상세 정보 확인
SHOW FULL COLUMNS FROM userTbl;

CREATE TABLE prodTbl(
num INT PRIMARY KEY,
userID CHAR(8) NOT NULL,
prodName CHAR(6) NOT NULL COMMENT '상품이름',
groupName CHAR(4),
price CHAR(5),
count SMALLINT NOT NULL
);

/*
	ALTER(변경)
    ALTER TABLE 대상 이름
		MODIFY : 존재하는 열에 대한 정보를 수정
        CHANGE : 열이름 변경 OR 열이름과 데이터 타입 제약조건 수정
        RENAME : 테이블 OR  열 이름 변경,
        ADD : 제약 조건 , 열 추가
        DROP : 제약 조건 , 열 삭제
*/

-- prodTbl 테이블의 이름을  buyTbl로 변경 
ALTER TABLE prodTbl RENAME buyTbl; 
-- RENAME TABLE BUYTBL TO prodTbl; 두 개가 같은 의미

-- buyTbl 의 속성 중 price 속성을 char(5)에서 INT 타입으로 변경
DESC buyTbl;
ALTER TABLE buyTbl MODIFY price INT COMMENT '판매금액';

DESCRIBE buyTbl;

-- 컬럼의 상세정보 확인
SHOW FULL COLUMNS FROM buyTbl;

ALTER TABLE buyTbl COMMENT = '구매 테이블';

-- 테이블의 상세정보 확인
SHOW TABLE STATUS;

-- buyTbl 에 부여된 PK 제거
DESC buyTbl;
ALTER TABLE buyTbl DROP PRIMARY KEY;

-- 지정된 테이블 COLUMN에 제약조건 추가 - primary key
ALTER TABLE buyTbl ADD PRIMARY KEY(num);

-- buyTbl의 속성 중 num 에 auto_increment를 적용
ALTER TABLE buyTbl MODIFY num INT NOT NULL AUTO_INCREMENT;

-- buyTbl table에 count 속성 이름을 amount로 변경
ALTER TABLE buyTbl RENAME COLUMN count TO amount;

-- 기존의 COLUMN 을 새로운 COLUMN으로 변경 
ALTER TABLE buyTbl CHANGE AMOUNT count INT NOT NULL;

DESC buyTbl;
DESC userTbl;
-- USERTBL 의 USERID 속성에 저장된 데이터만 올 수 있도록
-- 참조 무결성 - 참조키 제약 조건 추가
ALTER TABLE buyTbl 
ADD CONSTRAINT fk_userID FOREIGN KEY(userID)departmentsusertbl
REFERENCES userTbl(userID);

-- 부여된 외래키 정보 확인
SHOW INDEX FROM buyTbl;

-- 필요없어진 column 삭제
ALTER TABLE buyTbl DROP COLUMN groupName;

DESC buyTbl;

DROP DATABASE IF EXISTS sqlDB;