-- 기존 테이블 및 시퀀스 삭제
    DROP SEQUENCE SEQ_USER_NO;
    DROP TABLE HOSPITAL CASCADE CONSTRAINTS;
    DROP TABLE MEDICAL_FIELD CASCADE CONSTRAINTS;
    DROP TABLE USER_TABLE CASCADE CONSTRAINTS;
    DROP TABLE MEMBER CASCADE CONSTRAINTS;
    DROP TABLE BOARD CASCADE CONSTRAINTS;
    DROP TABLE FILE_TABLE CASCADE CONSTRAINTS;
    DROP TABLE COMMENTS_TABLE CASCADE CONSTRAINTS;
    DROP TABLE TREATMENT CASCADE CONSTRAINTS;
    DROP TABLE RESERVATION CASCADE CONSTRAINTS;
    DROP TABLE DOCTOR_REVIEW CASCADE CONSTRAINTS;
    DROP TABLE HOSPITAL_KID CASCADE CONSTRAINTS;

-- Drop sequences
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_HNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_MNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_UNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_RNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_BNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_FNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_CNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_TNO';
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_RESNO';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- 시퀀스 생성
CREATE SEQUENCE SEQ_USER_NO
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- HOSPITAL 테이블 생성
CREATE TABLE HOSPITAL (
    HOS_NO VARCHAR2(2000) NOT NULL PRIMARY KEY,
    HOS_ID VARCHAR2(20) NOT NULL,
    HOS_PWD VARCHAR2(20) NOT NULL,
    HOS_NAME VARCHAR2(50) NOT NULL,
    HOS_ADDRESS VARCHAR2(50) NOT NULL,
    HOS_TEL VARCHAR2(20) NOT NULL,
    HOS_YEAR DATE DEFAULT SYSDATE,
    HOS_TIME VARCHAR2(20) NOT NULL,
    HOS_INFO VARCHAR2(2000),
    HOS_LATITUDE NUMBER,
    HOS_LONGITUDE NUMBER,
    HOS_ONDUTY VARCHAR2(20),
    HOS_PARKING VARCHAR2(100)
);

COMMENT ON COLUMN HOSPITAL.HOS_NO IS '병원 고유 번호';
COMMENT ON COLUMN HOSPITAL.HOS_ID IS '병원 아이디';
COMMENT ON COLUMN HOSPITAL.HOS_PWD IS '병원 비밀번호';
COMMENT ON COLUMN HOSPITAL.HOS_NAME IS '병원 이름';
COMMENT ON COLUMN HOSPITAL.HOS_ADDRESS IS '병원 주소';
COMMENT ON COLUMN HOSPITAL.HOS_TEL IS '병원 전화번호';
COMMENT ON COLUMN HOSPITAL.HOS_YEAR IS '병원 개설일자';
COMMENT ON COLUMN HOSPITAL.HOS_TIME IS '병원 진료시간';
COMMENT ON COLUMN HOSPITAL.HOS_INFO IS '병원 정보';
COMMENT ON COLUMN HOSPITAL.HOS_LATITUDE IS '병원 위도';
COMMENT ON COLUMN HOSPITAL.HOS_LONGITUDE IS '병원 경도';
COMMENT ON COLUMN HOSPITAL.HOS_ONDUTY IS '병원 당직';
COMMENT ON COLUMN HOSPITAL.HOS_PARKING IS '주차 정보';

-- MEDICAL_FIELD 테이블 생성
CREATE TABLE MEDICAL_FIELD (
    MED_NO NUMBER NOT NULL PRIMARY KEY,
    JOB VARCHAR2(50) NOT NULL,
    MEDICAL_FIELD_ID VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN MEDICAL_FIELD.MED_NO IS '의사 고유 번호';
COMMENT ON COLUMN MEDICAL_FIELD.JOB IS '직업';
COMMENT ON COLUMN MEDICAL_FIELD.MEDICAL_FIELD_ID IS '전공과';

-- MEMBER 테이블 생성
CREATE TABLE MEMBER (
    USER_NO VARCHAR2(100) PRIMARY KEY,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(100) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(50) NOT NULL,
    PHONE VARCHAR2(20) NOT NULL,
    BIRTHDAY DATE NOT NULL,
    GENDER CHAR(1) DEFAULT 'M' CHECK (GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(50),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    STATUS CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
    ISADMIN VARCHAR2(10) DEFAULT 'N',
    MED_KEY NUMBER,
    HOS_NO VARCHAR2(2000),

    FOREIGN KEY (MED_KEY) REFERENCES MEDICAL_FIELD (MED_NO),
    FOREIGN KEY (HOS_NO) REFERENCES HOSPITAL (HOS_NO)
);

COMMENT ON COLUMN MEMBER.USER_NO IS '사용자 고유 번호';
COMMENT ON COLUMN MEMBER.USER_ID IS '사용자 아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '사용자 비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '사용자 이름';
COMMENT ON COLUMN MEMBER.EMAIL IS '사용자 이메일';
COMMENT ON COLUMN MEMBER.PHONE IS '사용자 전화번호';
COMMENT ON COLUMN MEMBER.BIRTHDAY IS '사용자 생일';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '등록 일자';
COMMENT ON COLUMN MEMBER.STATUS IS '사용자 상태';
COMMENT ON COLUMN MEMBER.ISADMIN IS '관리자 여부';
COMMENT ON COLUMN MEMBER.MED_KEY IS '의사 고유 번호 (외래 키)';
COMMENT ON COLUMN MEMBER.HOS_NO IS '병원 고유 번호 (외래 키)';

-- DOCTOR_REVIEW 테이블 생성
CREATE TABLE DOCTOR_REVIEW (
    REVIEW_NO NUMBER NOT NULL PRIMARY KEY,
    USER_ID VARCHAR2(20) NOT NULL,
    REVIEW_TITLE VARCHAR2(200) NOT NULL,
    REVIEW_CONTENT VARCHAR2(2000) NOT NULL,
    REVIEW_CREATED_AT DATE DEFAULT SYSDATE,
    REVIEW_UPDATED_AT DATE DEFAULT SYSDATE,
    REVIEW_VIEWS NUMBER,
    REVIEW_RATING NUMBER,
    USER_ID2 VARCHAR2(20),

    FOREIGN KEY (USER_ID) REFERENCES MEMBER (USER_ID)
);

COMMENT ON COLUMN DOCTOR_REVIEW.REVIEW_NO IS '리뷰 번호';
COMMENT ON COLUMN DOCTOR_REVIEW.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN DOCTOR_REVIEW.REVIEW_TITLE IS '리뷰 제목';
COMMENT ON COLUMN DOCTOR_REVIEW.REVIEW_CONTENT IS '리뷰 내용';
COMMENT ON COLUMN DOCTOR_REVIEW.REVIEW_CREATED_AT IS '리뷰 작성일';
COMMENT ON COLUMN DOCTOR_REVIEW.REVIEW_UPDATED_AT IS '리뷰 수정일';
COMMENT ON COLUMN DOCTOR_REVIEW.REVIEW_VIEWS IS '리뷰 조회수';
COMMENT ON COLUMN DOCTOR_REVIEW.REVIEW_RATING IS '리뷰 평점';
COMMENT ON COLUMN DOCTOR_REVIEW.USER_ID2 IS '의사 아이디';

-- RESERVATION 테이블 생성
CREATE TABLE RESERVATION (
    RES_NO NUMBER NOT NULL PRIMARY KEY,
    USER_ID VARCHAR2(20) NOT NULL,
    HOS_NO VARCHAR2(2000) NOT NULL,
    RES_DATE DATE DEFAULT SYSDATE,
    RES_TIME DATE NOT NULL,
    RES_CATEGORY VARCHAR2(20) NOT NULL,
    RES_CONTENT VARCHAR2(2000)
);

COMMENT ON COLUMN RESERVATION.RES_NO IS '예약 번호';
COMMENT ON COLUMN RESERVATION.USER_ID IS '사용자 아이디';
COMMENT ON COLUMN RESERVATION.HOS_NO IS '병원 고유 번호';
COMMENT ON COLUMN RESERVATION.RES_DATE IS '예약 일자';
COMMENT ON COLUMN RESERVATION.RES_TIME IS '진료 시간';
COMMENT ON COLUMN RESERVATION.RES_CATEGORY IS '진료 카테고리';
COMMENT ON COLUMN RESERVATION.RES_CONTENT IS '진료 내용';

-- TREATMENT 테이블 생성
CREATE TABLE TREATMENT (
    TREATMENT_NO NUMBER NOT NULL PRIMARY KEY,
    RES_NO NUMBER NOT NULL,
    VACCINE_CATEGORY VARCHAR2(20),
    HEALTH_SELECT VARCHAR2(20),
    RES_SELECT VARCHAR2(20)
);

COMMENT ON COLUMN TREATMENT.TREATMENT_NO IS '진료 번호';
COMMENT ON COLUMN TREATMENT.RES_NO IS '예약 번호';
COMMENT ON COLUMN TREATMENT.VACCINE_CATEGORY IS '백신 종류';
COMMENT ON COLUMN TREATMENT.HEALTH_SELECT IS '건강 검진 선택';
COMMENT ON COLUMN TREATMENT.RES_SELECT IS '진료 요청';

-- BOARD 테이블 생성
CREATE TABLE BOARD (
    BOARD_NO NUMBER NOT NULL PRIMARY KEY,
    USER_ID VARCHAR2(20) NOT NULL,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(2000) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    MODIFIED_DATE DATE DEFAULT SYSDATE,
    VIEWS NUMBER,
    BOARD_CATEGORY VARCHAR2(20)
);

COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN BOARD.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN BOARD.TITLE IS '게시글 제목';
COMMENT ON COLUMN BOARD.CONTENT IS '게시글 내용';
COMMENT ON COLUMN BOARD.ENROLL_DATE IS '게시글 작성일';
COMMENT ON COLUMN BOARD.MODIFIED_DATE IS '게시글 수정일';
COMMENT ON COLUMN BOARD.VIEWS IS '게시글 조회수';
COMMENT ON COLUMN BOARD.BOARD_CATEGORY IS '게시글 카테고리';


CREATE TABLE FILE_TABLE (
    FILE_NO NUMBER NOT NULL PRIMARY KEY,
    BOARD_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    ORIGIN_NAME VARCHAR2(200),
    CHANGE_NAME VARCHAR2(200)
);

COMMENT ON COLUMN FILE_TABLE.FILE_NO IS '파일 번호';
COMMENT ON COLUMN FILE_TABLE.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN FILE_TABLE.USER_ID IS '사용자 아이디';
COMMENT ON COLUMN FILE_TABLE.ORIGIN_NAME IS '파일 원본 이름';
COMMENT ON COLUMN FILE_TABLE.CHANGE_NAME IS '파일 변경 이름';

-- COMMENTS 테이블 생성 
CREATE TABLE COMMENTS_TABLE (
    COMMENT_NO NUMBER NOT NULL PRIMARY KEY,
    BOARD_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    CONTENT VARCHAR2(2000),
    CREATED_AT DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN COMMENTS_TABLE.COMMENT_NO IS '댓글 번호';
COMMENT ON COLUMN COMMENTS_TABLE.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN COMMENTS_TABLE.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN COMMENTS_TABLE.CONTENT IS '댓글 내용';
COMMENT ON COLUMN COMMENTS_TABLE.CREATED_AT IS '댓글 작성일';

INSERT INTO MEMBER
(USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS)
VALUES (SEQ_USER_NO.NEXTVAL, 'user01', 'pass01', '최경채', 'ckc980515@gmail.com', '010-8350-9121', TO_DATE('980515', 'YYMMDD'), 'M', '경기도 양주시');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS)
VALUES (SEQ_USER_NO.NEXTVAL, 'user02', 'pass02', '최민서', 'cms@gmail.com', '010-1231-4231', TO_DATE('000315', 'YYMMDD'), 'M', '경기도 수원시');


INSERT INTO MEDICAL_FIELD
VALUES (1 , '간호사', '소아과');

INSERT INTO MEDICAL_FIELD
VALUES (2 , '의사', '내과');

INSERT INTO MEDICAL_FIELD
VALUES (3, '의사', '소아과');

INSERT INTO MEDICAL_FIELD
VALUES (4, '간호사', '안과');

INSERT INTO MEDICAL_FIELD
VALUES (5, '의사', '소아과');


CREATE TABLE HOSPITAL_KID (
    name VARCHAR2(100),               -- 병원 이름
    address VARCHAR2(200),            -- 병원 주소
    division VARCHAR2(50),            -- 병원 구분 (예: 의원, 병원 등)
    department VARCHAR2(50),          -- 진료 과목
    start_time VARCHAR2(10),          -- 진료 시작 시간
    end_time VARCHAR2(10),            -- 진료 종료 시간
    hpid VARCHAR2(20) PRIMARY KEY,    -- 병원 ID, 각 병원을 구분하는 고유 식별자
    latitude NUMBER(10, 7),           -- 병원의 위도
    longitude NUMBER(10, 7)           -- 병원의 경도
);
