CREATE DATABASE `product tbl`;
/* 
DDL - 데이터 정의어
CREATE, ALTER, DROP

--규칙을 생성하는 CREATE

*/

USE `product tbl`;

-- 띄어쓰기 기준으로 뒤를 언더바로 구분 / 띄어쓰기 기준으로 뒤 글자를 대문자로 구분
CREATE TABLE sqldb.deptmember_tbl(
-- 속성 이름    데이터_형식    제약조건
-- PRIMARY KEY는 인덱싱이 된다.
    member_id VARCHAR(50) PRIMARY KEY, 
    member_email VARCHAR(200) NOT NULL UNIQUE,
    member_pw VARCHAR(50),
    member_name CHAR(20) NOT NULL,
    memeber_age INT NULL
);

DROP TABLE member_tbl;
DESC sqldb.member_tbl;

USE sqlDB;
show tables;
DROP SCHEMA sqldb;

