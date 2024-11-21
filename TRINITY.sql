--테이블 초기화----------------------------------------------------------------------------------------------------------

DROP TABLE HOSPITAL_ACCOUNT CASCADE CONSTRAINTS;
DROP TABLE HOSPITAL_INFO CASCADE CONSTRAINTS;
DROP TABLE MEDICAL_FIELD CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE DOCTOR_REVIEW CASCADE CONSTRAINTS;
DROP TABLE GENERAL_RESERVATION CASCADE CONSTRAINTS;
DROP TABLE VACCINE_RESERVATION CASCADE CONSTRAINTS;
DROP TABLE HEALTH_RESERVATION CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE FILE_TABLE CASCADE CONSTRAINTS;
DROP TABLE COMMENTS CASCADE CONSTRAINTS;
DROP TABLE GUEST CASCADE CONSTRAINTS;
DROP TABLE H_SUBJECT CASCADE CONSTRAINTS;
DROP TABLE LIKES_TABLE CASCADE CONSTRAINTS;

--시퀀스 초기화----------------------------------------------------------------------------------------------------------

DROP SEQUENCE SEQ_HOS_NO;
DROP SEQUENCE SEQ_HOS_ACCOUNT_NO;
DROP SEQUENCE SEQ_USER_NO;
DROP SEQUENCE SEQ_BOARD_NO;
DROP SEQUENCE SEQ_REVIEW_NO;
DROP SEQUENCE SEQ_FILE_NO;
DROP SEQUENCE SEQ_MED_NO;
DROP SEQUENCE SEQ_REVIEW_VIEWS;
DROP SEQUENCE SEQ_GST_NO;
DROP SEQUENCE SEQ_G_RES_NO;
DROP SEQUENCE SEQ_V_RES_NO;
DROP SEQUENCE SEQ_H_RES_NO;
DROP SEQUENCE SEQ_SUB_KEY;
DROP SEQUENCE SEQ_COMMENT_NO;

-- 시퀀스 생성----------------------------------------------------------------------------------------------------------

CREATE SEQUENCE SEQ_HOS_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_HOS_ACCOUNT_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_G_RES_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_V_RES_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_H_RES_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_USER_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_BOARD_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_REVIEW_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_FILE_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_MED_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_REVIEW_VIEWS START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_GST_NO START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_SUB_KEY START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_COMMENT_NO START WITH 1 INCREMENT BY 1 NOCACHE;


-- 테이블 생성 ----------------------------------------------------------------------------------------------------------

CREATE TABLE HOSPITAL_INFO (
    HOS_NO VARCHAR2(10) PRIMARY KEY,
    HOS_NAME VARCHAR2(250),
    HOS_ADDRESS VARCHAR2(250),
    HOS_TEL VARCHAR2(20),
    DEPARTMENT VARCHAR2(250),
    HOS_START_TIME1 VARCHAR2(20),
    HOS_CLOSE_TIME1 VARCHAR2(20),
    HOS_START_TIME2 VARCHAR2(20),
    HOS_CLOSE_TIME2 VARCHAR2(20),
    HOS_LATITUDE NUMBER,
    HOS_LONGITUDE NUMBER
);

CREATE TABLE HOSPITAL_ACCOUNT (
    HOS_ACCOUNT_NO VARCHAR2(10) PRIMARY KEY,
    HOS_NO VARCHAR2(10) NOT NULL,
    HOS_ID VARCHAR2(20) NOT NULL,
    HOS_PWD VARCHAR2(20) NOT NULL,
    HOS_INFO VARCHAR2(2000),
    HOS_ONDUTY VARCHAR2(20),
    HOS_PARKING VARCHAR2(100),
    FOREIGN KEY (HOS_NO) REFERENCES HOSPITAL_INFO (HOS_NO)
);

CREATE TABLE MEDICAL_FIELD (
    MED_NO VARCHAR2(10) PRIMARY KEY,
    JOB VARCHAR2(50) NOT NULL,
    MEDICAL_FIELD_ID VARCHAR2(20) NOT NULL
);

CREATE TABLE MEMBER (
    USER_NO VARCHAR2(10) PRIMARY KEY,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(100) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(50) NOT NULL,
    PHONE VARCHAR2(20) NOT NULL,
    BIRTHDAY DATE NOT NULL,
    GENDER CHAR(1) DEFAULT 'M' CHECK (GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(200),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    STATUS CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
    ISADMIN CHAR(1) DEFAULT 'N',
    MED_KEY VARCHAR2(10),
    HOS_NO VARCHAR2(10),
    USERPROFILE VARCHAR2(255),
    FOREIGN KEY (MED_KEY) REFERENCES MEDICAL_FIELD (MED_NO),
    FOREIGN KEY (HOS_NO) REFERENCES HOSPITAL_INFO (HOS_NO)
);

CREATE TABLE GUEST (
    GST_NO VARCHAR2(10) PRIMARY KEY,
    GST_NAME VARCHAR2(20) NOT NULL,
    GST_EMAIL VARCHAR2(50) NOT NULL,
    GST_PHONE VARCHAR2(20) NOT NULL,
    GST_BIRTH NUMBER NOT NULL,
    GST_GENDER CHAR(1) DEFAULT 'M',
    GST_ADDRESS VARCHAR(200),
    CONSTRAINT chk_guest_gender CHECK (GST_GENDER IN ('M', 'F'))
);

CREATE TABLE DOCTOR_REVIEW (
    REVIEW_NO VARCHAR2(10) PRIMARY KEY,
    USER_NO VARCHAR2(10) NOT NULL,
    REVIEW_TITLE VARCHAR2(200) NOT NULL,
    REVIEW_CONTENT VARCHAR2(2000) NOT NULL,
    REVIEW_CREATED_AT DATE DEFAULT SYSDATE,
    REVIEW_UPDATED_AT DATE DEFAULT SYSDATE,
    REVIEW_VIEWS VARCHAR2(10),
    REVIEW_RATING NUMBER,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO)
);

CREATE TABLE GENERAL_RESERVATION (
    G_RES_NO VARCHAR2(10) PRIMARY KEY,
    USER_NO VARCHAR2(10),
    HOS_NO VARCHAR2(10) NOT NULL,
    GST_NO VARCHAR2(10),
    G_PATIENT_NAME VARCHAR2(20) NOT NULL,
    G_PATIENT_BIRTHDAY NUMBER NOT NULL,
    G_RES_DATE DATE NOT NULL,
    G_RES_TIME VARCHAR2(20) NOT NULL,
    G_RES_SUBJECT VARCHAR2(20) NOT NULL,
    G_RES_CONTENT VARCHAR2(3000),
    G_RES_GENDER CHAR(1) NOT NULL,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO),
    FOREIGN KEY (HOS_NO) REFERENCES HOSPITAL_INFO (HOS_NO),
    FOREIGN KEY (GST_NO) REFERENCES GUEST (GST_NO)
);

CREATE TABLE VACCINE_RESERVATION (
    V_RES_NO VARCHAR2(10) PRIMARY KEY,
    USER_NO VARCHAR2(10),
    HOS_NO VARCHAR2(10) NOT NULL,
    GST_NO VARCHAR2(10),
    PATIENT_NAME VARCHAR2(20) NOT NULL,
    PATIENT_BIRTHDAY VARCHAR2(10) NOT NULL,
    V_RES_DATE DATE NOT NULL,
    V_RES_TIME VARCHAR2(20) NOT NULL,
    V_TYPE VARCHAR2(20) NOT NULL,
    RES_CONTENT VARCHAR2(300),
    FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO),
    FOREIGN KEY (HOS_NO) REFERENCES HOSPITAL_INFO (HOS_NO),
    FOREIGN KEY (GST_NO) REFERENCES GUEST (GST_NO)
);

CREATE TABLE HEALTH_RESERVATION (
    H_RES_NO VARCHAR2(10) PRIMARY KEY,
    USER_NO VARCHAR2(10),
    GST_NO VARCHAR2(10),
    HOS_NO VARCHAR2(10) NOT NULL,
    PATIENT_NAME VARCHAR2(20) NOT NULL,
    PATIENT_RESULT VARCHAR2(50) NOT NULL,
    RES_DATE DATE DEFAULT SYSDATE NOT NULL,
    RES_TIME VARCHAR2(20) NOT NULL,
    RES_CATEGORY VARCHAR2(100) NOT NULL,
    PATIENT_BIRTH VARCHAR2(20) NOT NULL,
    PATIENT_EMAIL VARCHAR2(50),
    PATIENT_GENDER CHAR(1) NOT NULL,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO),
    FOREIGN KEY (HOS_NO) REFERENCES HOSPITAL_INFO (HOS_NO),
    FOREIGN KEY (GST_NO) REFERENCES GUEST (GST_NO)
);

CREATE TABLE BOARD (
    BOARD_NO VARCHAR2(10) PRIMARY KEY,
    BOARD_TYPE NUMBER,
    USER_NO VARCHAR2(10) NOT NULL,
    BOARD_TITLE VARCHAR2(200) NOT NULL,
    BOARD_CONTENT VARCHAR2(4000),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    MODIFIED_DATE DATE DEFAULT SYSDATE,
    BOARD_VIEWS VARCHAR2(10),
    BOARD_CATEGORY VARCHAR2(20),
    STATUS CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
    FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO)
);

CREATE TABLE FILE_TABLE (
    FILE_NO VARCHAR2(10) PRIMARY KEY,         -- 파일 고유 번호
    BOARD_NO VARCHAR2(10) NOT NULL,           -- 연관된 게시글 번호
    USER_NO VARCHAR2(10) NOT NULL,            -- 연관된 사용자 번호
    ORIGIN_NAME VARCHAR2(255 BYTE),     -- 원본 파일 이름
    CHANGE_NAME VARCHAR2(255 BYTE),     -- 서버에 저장된 파일 이름
    CONSTRAINT FK_FILE_BOARD FOREIGN KEY (BOARD_NO)
        REFERENCES BOARD (BOARD_NO)
        ON DELETE CASCADE,              -- 게시글 삭제 시 관련 파일 삭제
    CONSTRAINT FK_FILE_MEMBER FOREIGN KEY (USER_NO)
        REFERENCES MEMBER (USER_NO)     -- 사용자 삭제 시 연관된 파일 삭제 가능
);


CREATE TABLE COMMENTS (
    COMMENT_NO VARCHAR2(10) PRIMARY KEY,
    BOARD_NO VARCHAR2(10) NOT NULL,
    USER_NO VARCHAR2(10) NOT NULL,
    CONTENT VARCHAR2(2000),
    CREATED_AT DATE DEFAULT SYSDATE,
    FOREIGN KEY (BOARD_NO) REFERENCES BOARD (BOARD_NO),
    FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO)
);

CREATE TABLE H_SUBJECT (
    SUB_KEY NUMBER PRIMARY KEY,
    HOS_NO VARCHAR2(10) NOT NULL,
    HOS_SUBJECT VARCHAR2(50),
    SUBJECT_CODE VARCHAR2(50),
    FOREIGN KEY (HOS_NO) REFERENCES HOSPITAL_INFO (HOS_NO)
);

CREATE TABLE LIKES_TABLE (
    COMMENT_NO VARCHAR2(10) NOT NULL,
    USER_NO VARCHAR2(10) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    PRIMARY KEY (COMMENT_NO, USER_NO),
    FOREIGN KEY (COMMENT_NO) REFERENCES COMMENTS (COMMENT_NO),
    FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO)
);

ALTER TABLE FILE_TABLE ADD ALLOW_DOWNLOAD CHAR(1) DEFAULT 'Y'; -- Y: 허용, N: 비허용

-- 트리거 생성----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER trg_guest_id
BEFORE INSERT ON GUEST
FOR EACH ROW
BEGIN
    :NEW.GST_NO := 'G' || TO_CHAR(SEQ_GST_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_hospital_info_id
BEFORE INSERT ON HOSPITAL_INFO
FOR EACH ROW
BEGIN
    :NEW.HOS_NO := 'H' || TO_CHAR(SEQ_HOS_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_hospital_account_id
BEFORE INSERT ON HOSPITAL_ACCOUNT
FOR EACH ROW
BEGIN
    :NEW.HOS_ACCOUNT_NO := 'HA' || TO_CHAR(SEQ_HOS_ACCOUNT_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_general_reservation_id
BEFORE INSERT ON GENERAL_RESERVATION
FOR EACH ROW
BEGIN
    :NEW.G_RES_NO := 'GR' || TO_CHAR(SEQ_G_RES_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER TRG_VACCINE_RESERVATION_ID
BEFORE INSERT ON VACCINE_RESERVATION
FOR EACH ROW
BEGIN
    -- V_RES_NO가 NULL일 경우에만 값을 생성
    IF :NEW.V_RES_NO IS NULL THEN
        :NEW.V_RES_NO := 'VR' || TO_CHAR(SEQ_V_RES_NO.NEXTVAL);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_health_reservation_id
BEFORE INSERT ON HEALTH_RESERVATION
FOR EACH ROW
BEGIN
    :NEW.H_RES_NO := 'HR' || TO_CHAR(SEQ_H_RES_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_member_id
BEFORE INSERT ON MEMBER
FOR EACH ROW
BEGIN
    :NEW.USER_NO := 'U' || TO_CHAR(SEQ_USER_NO.NEXTVAL);
END;
/



CREATE OR REPLACE TRIGGER trg_board_id
BEFORE INSERT ON BOARD
FOR EACH ROW
BEGIN
    :NEW.BOARD_NO := 'B' || TO_CHAR(SEQ_BOARD_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_doctor_review_id
BEFORE INSERT ON DOCTOR_REVIEW
FOR EACH ROW
BEGIN
    :NEW.REVIEW_NO := 'RV' || TO_CHAR(SEQ_REVIEW_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_file_table_id
BEFORE INSERT ON FILE_TABLE
FOR EACH ROW
BEGIN
    :NEW.FILE_NO := 'F' || TO_CHAR(SEQ_FILE_NO.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_medical_field_id
BEFORE INSERT ON MEDICAL_FIELD
FOR EACH ROW
BEGIN
    :NEW.MED_NO := 'M' || TO_CHAR(SEQ_MED_NO.NEXTVAL);
END;
/


CREATE OR REPLACE TRIGGER trg_review_views_id
BEFORE INSERT ON DOCTOR_REVIEW
FOR EACH ROW
BEGIN
    :NEW.REVIEW_VIEWS := TO_CHAR(SEQ_REVIEW_VIEWS.NEXTVAL);
END;
/

CREATE OR REPLACE TRIGGER trg_h_subject_id
BEFORE INSERT ON H_SUBJECT
FOR EACH ROW
BEGIN
    :NEW.SUB_KEY := SEQ_SUB_KEY.NEXTVAL;
END;
/

-- 더미데이터 --------------------------------------------------------------------------------------------------------
INSERT INTO MEMBER (user_no,user_id, user_pwd, user_name, email, phone, birthday, address, gender, isadmin) 
VALUES ('U1','admin1', 'pass1', '관리자', 'admin@example.com', '010-1111-1111',  TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Seoul, Korea', 'M', 'Y');

INSERT INTO MEMBER (user_no,user_id, user_pwd, user_name, email, phone, birthday, address, gender) 
VALUES ('U2','user01', 'pwd01', 'Alice', 'alice@example.com', '010-1234-5678', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Seoul, Korea', 'F');

INSERT INTO MEMBER (user_no,user_id, user_pwd, user_name, email, phone, birthday, address, gender) 
VALUES ('U3','user02', 'pwd02', 'Bob', 'bob@example.com', '010-2345-6789', TO_DATE('1992-02-02', 'YYYY-MM-DD'), 'Busan, Korea', 'M');

INSERT INTO MEMBER (user_no,user_id, user_pwd, user_name, email, phone, birthday, address, gender) 
VALUES ('U4','user03', 'pwd03', 'Charlie', 'charlie@example.com', '010-3456-7890', TO_DATE('1985-03-03', 'YYYY-MM-DD'), 'Incheon, Korea', 'M');

INSERT INTO MEMBER (user_no,user_id, user_pwd, user_name, email, phone, birthday, address, gender) 
VALUES ('U5','user04', 'pwd04', 'Diana', 'diana@example.com', '010-4567-8901', TO_DATE('1995-04-04', 'YYYY-MM-DD'), 'Daegu, Korea', 'F');

INSERT INTO MEMBER (user_no,user_id, user_pwd, user_name, email, phone, birthday, address, gender) 
VALUES ('U6','user05', 'pwd05', 'Evan', 'evan@example.com', '010-5678-9012', TO_DATE('1988-05-05', 'YYYY-MM-DD'), 'Gwangju, Korea', 'M');

INSERT INTO HOSPITAL_INFO (
    HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, 
    HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, 
    HOS_LATITUDE, HOS_LONGITUDE
) VALUES 
('H1', '서울 소아청소년과', '123 서울로, 서울', '02-123-4567', '소아청소년과', 900, 1800, 1300, 1700, 37.5665, 126.9780);

INSERT INTO HOSPITAL_INFO (
    HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, 
    HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, 
    HOS_LATITUDE, HOS_LONGITUDE
) VALUES 
('H2', '부산 어린이 건강센터', '456 부산로, 부산', '051-234-5678', '소아청소년과', 800, 1700, 1200, 1600, 35.1796, 129.0756);

INSERT INTO HOSPITAL_INFO (
    HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, 
    HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, 
    HOS_LATITUDE, HOS_LONGITUDE
) VALUES 
('H3', '인천 소아과센터', '789 인천로, 인천', '032-345-6789', '소아청소년과', 830, 1800, 1230, 1730, 37.4563, 126.7052);

INSERT INTO HOSPITAL_INFO (
    HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, 
    HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, 
    HOS_LATITUDE, HOS_LONGITUDE
) VALUES 
('H4', '대구 소아청소년과', '101 대구로, 대구', '053-456-7890', '소아청소년과', 900, 1900, 1400, 1800, 35.8714, 128.6014);

INSERT INTO HOSPITAL_INFO (
    HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, 
    HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, 
    HOS_LATITUDE, HOS_LONGITUDE
) VALUES 
('H5', '광주 소아청소년과의원', '202 광주로, 광주', '062-567-8901', '소아청소년과', 830, 1730, 1230, 1630, 35.1595, 126.8526);

INSERT INTO HOSPITAL_INFO (
    HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, 
    HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, 
    HOS_LATITUDE, HOS_LONGITUDE
) VALUES 
('H6', '대전 어린이병원', '303 대전로, 대전', '042-678-9012', '소아청소년과', 900, 1800, 1300, 1700, 36.3504, 127.3845);

INSERT INTO HOSPITAL_INFO (
    HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, 
    HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, 
    HOS_LATITUDE, HOS_LONGITUDE
) VALUES 
('H7', '울산 소아병원', '404 울산로, 울산', '052-789-0123', '소아청소년과', 800, 1700, 1200, 1600, 35.5384, 129.3114);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE)
VALUES ('H8', '세종 어린이 건강센터', '505 세종로, 세종', '044-890-1234', '소아청소년과', 830, 1830, 1230, 1730, 36.4808, 127.2896);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE)
VALUES ('H9', '전주 소아청소년과의원', '606 전주로, 전주', '063-901-2345', '소아청소년과', 800, 1700, 1200, 1600, 35.8251, 127.1457);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H10', '춘천 소아청소년과', '707 춘천로, 춘천', '033-012-3456', '소아청소년과', 900, 1900, 1400, 1800, 37.8813, 127.7298);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H11', '안양 소아청소년과', '11 Anyang Road, Anyang', '031-111-1111', '소아청소년과', 900, 1800, 1300, 1700, 37.3943, 126.9568);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H12', '김해 어린이 건강센터', '12 Gimhae Road, Gimhae', '055-222-2222', '소아청소년과', 800, 1700, 1200, 1600, 35.2341, 128.8891);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H13', '평택 소아센터', '13 Pyeongtaek Road, Pyeongtaek', '031-333-3333', '소아청소년과', 830, 1800, 1230, 1730, 36.9907, 127.0883);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H14', '수원 소아청소년과', '14 Suwon Road, Suwon', '031-444-4444', '소아청소년과', 900, 1900, 1400, 1800, 37.2635, 127.0286);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H15', '제주 소아클리닉', '15 Jeju Road, Jeju', '064-555-5555', '소아청소년과', 830, 1730, 1230, 1630, 33.4996, 126.5312);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H16', '포항 어린이병원', '16 Pohang Road, Pohang', '054-666-6666', '소아청소년과', 900, 1800, 1300, 1700, 36.0190, 129.3435);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H17', '경주 소아병원', '17 Gyeongju Road, Gyeongju', '054-777-7777', '소아청소년과', 800, 1700, 1200, 1600, 35.8562, 129.2248);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H18', '아산 어린이 건강센터', '18 Asan Road, Asan', '041-888-8888', '소아청소년과', 830, 1830, 1230, 1730, 36.7895, 127.0048);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H19', '천안 소아청소년과', '19 Cheonan Road, Cheonan', '041-999-9999', '소아청소년과', 900, 1800, 1300, 1700, 36.8151, 127.1139);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H20', '구리 어린이병원', '20 Guri Road, Guri', '031-100-1000', '소아청소년과', 800, 1700, 1200, 1600, 37.5985, 127.1390);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H21', '안양 클리닉', '21 Anyang Road, Anyang', '031-111-1111', '소아청소년과', 900, 1800, 1300, 1700, 37.3943, 126.968);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H22', '김해 건강병원', '22 Gimhae Road, Gimhae', '055-222-2222', '소아청소년과', 800, 1700, 1200, 1600, 35.2341, 128.891);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H23', '평택 소아센터', '23 Pyeongtaek Road, Pyeongtaek', '031-333-3333', '소아청소년과', 830, 1800, 1230, 1730, 36.997, 127.0883);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H24', '수 소아청소년과', '24 Suwon Road, Suwon', '031-444-4444', '소아청소년과', 900, 1900, 1400, 1800, 37.2635, 127.026);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H25', '제주 소아클리닉', '25 Jeju Road, Jeju', '064-555-5555', '소아청소년과', 830, 1730, 1230, 1630, 33.4996, 126.512);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H26', '포항 어린이 클리닉', '26 Pohang Road, Pohang', '054-666-6666', '소아청소년과', 900, 1800, 1300, 1700, 36.0190, 129.335);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H27', '경주 소아병원', '27 Gyeongju Road, Gyeongju', '054-777-7777', '소아청소년과', 800, 1700, 1200, 1600, 35.862, 129.2248);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H28', '아산 어린이센터', '28 Asan Road, Asan', '041-888-8888', '소아청소년과', 830, 1830, 1230, 1730, 36.7895, 17.0048);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H29', '천안 소아클리닉', '29 Cheonan Road, Cheonan', '041-999-9999', '소아청소년과', 900, 1800, 1300, 1700, 36.851, 127.1139);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H30', '구리 소아과', '30 Guri Road, Guri', '031-100-1000', '소아청소년과', 800, 1700, 1200, 1600, 37.5985, 127.190);


INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H31', '안성 소아청소년과', '31 Anyang Road, Anyang', '031-111-1111', '소아청소년과', 900, 1800, 1300, 1700, 37.3943, 126.9568);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H32', '김해 어린이병원', '32 Gimhae Road, Gimhae', '055-222-2222', '소아청소년과', 800, 1700, 1200, 1600, 35.2341, 128.8891);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H33', '평택 소아과센터', '33 Pyeongtaek Road, Pyeongtaek', '031-333-3333', '소아청소년과', 830, 1800, 1230, 1730, 36.9907, 127.0883);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H34', '수원 소아청소년과', '34 Suwon Road, Suwon', '031-444-4444', '소아청소년과', 900, 1900, 1400, 1800, 37.2635, 127.0286);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H35', '제주 어린이 건강센터', '35 Jeju Road, Jeju', '064-555-5555', '소아청소년과', 830, 1730, 1230, 1630, 33.4996, 126.5312);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H36', '포항 소아과병원', '36 Pohang Road, Pohang', '054-666-6666', '소아청소년과', 900, 1800, 1300, 1700, 36.0190, 129.3435);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H37', '경주 소아병원', '37 Gyeongju Road, Gyeongju', '054-777-7777', '소아청소년과', 800, 1700, 1200, 1600, 35.8562, 129.2248);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H38', '아산 소아청소년과', '38 Asan Road, Asan', '041-888-8888', '소아청소년과', 830, 1830, 1230, 1730, 36.7895, 127.0048);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H39', '천안 소아청소년과', '39 Cheonan Road, Cheonan', '041-999-9999', '소아청소년과', 900, 1800, 1300, 1700, 36.8151, 127.1139);

INSERT INTO HOSPITAL_INFO (HOS_NO, HOS_NAME, HOS_ADDRESS, HOS_TEL, DEPARTMENT, HOS_START_TIME1, HOS_CLOSE_TIME1, HOS_START_TIME2, HOS_CLOSE_TIME2, HOS_LATITUDE, HOS_LONGITUDE) 
VALUES ('H40', '구리 소아과의원', '40 Guri Road, Guri', '031-100-1000', '소아청소년과', 800, 1700, 1200, 1600, 37.5985, 127.1390);



INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H1', 'hos1', 'pwd1', 'Y', '10');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H2', 'hos2', 'pwd2', 'N', '15');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H3', 'hos3', 'pwd3', 'Y', '20');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H4', 'hos4', 'pwd4', 'Y', '12');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H5', 'hos5', 'pwd5', 'N', '8');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H6', 'hos6', 'pwd6', 'Y', '25');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H7', 'hos7', 'pwd7', 'N', '30');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H8', 'hos8', 'pwd8', 'Y', '18');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H9', 'hos9', 'pwd9', 'Y', '22');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H10', 'hos10', 'pwd10', 'N', '16');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H11', 'hos11', 'pwd11', 'Y', '12');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H12', 'hos12', 'pwd12', 'N', '8');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H13', 'hos13', 'pwd13', 'Y', '10');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H14', 'hos14', 'pwd14', 'Y', '14');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H15', 'hos15', 'pwd15', 'N', '6');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H16', 'hos16', 'pwd16', 'Y', '10');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H17', 'hos17', 'pwd17', 'N', '20');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H18', 'hos18', 'pwd18', 'Y', '15');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H19', 'hos19', 'pwd19', 'Y', '18');
INSERT INTO HOSPITAL_ACCOUNT (HOS_NO, HOS_ID, HOS_PWD, HOS_ONDUTY, HOS_PARKING) VALUES ('H20', 'hos20', 'pwd20', 'N', '12');



INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M1', '의사', '소아과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M2', '의사', '내과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M3', '의사', '정형외과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M4', '의사', '신경외과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M5', '의사', '치과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M6', '의사', '안과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M7', '의사', '이비인후과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M8', '의사', '피부과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M9', '의사', '비뇨기과');

INSERT INTO MEDICAL_FIELD (MED_NO, JOB, MEDICAL_FIELD_ID)
VALUES ('M10', '의사', '산부인과');



INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1001', 'doc1', 'password1', '김의사', 'doc1@example.com', '010-1111-1111', TO_DATE('1980-01-15', 'YYYY-MM-DD'), 'M', '서울특별시 강남구', 'M1');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1002', 'doc2', 'password2', '이의사', 'doc2@example.com', '010-2222-2222', TO_DATE('1985-03-25', 'YYYY-MM-DD'), 'F', '부산광역시 해운대구', 'M2');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1003', 'doc3', 'password3', '박의사', 'doc3@example.com', '010-3333-3333', TO_DATE('1978-07-10', 'YYYY-MM-DD'), 'M', '대구광역시 중구', 'M3');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1004', 'doc4', 'password4', '최의사', 'doc4@example.com', '010-4444-4444', TO_DATE('1990-12-05', 'YYYY-MM-DD'), 'F', '인천광역시 남동구', 'M4');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1005', 'doc5', 'password5', '정의사', 'doc5@example.com', '010-5555-5555', TO_DATE('1982-02-14', 'YYYY-MM-DD'), 'M', '광주광역시 북구', 'M5');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1006', 'doc6', 'password6', '강의사', 'doc6@example.com', '010-6666-6666', TO_DATE('1988-09-20', 'YYYY-MM-DD'), 'F', '대전광역시 서구', 'M6');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1007', 'doc7', 'password7', '윤의사', 'doc7@example.com', '010-7777-7777', TO_DATE('1983-11-11', 'YYYY-MM-DD'), 'M', '울산광역시 남구', 'M7');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1008', 'doc8', 'password8', '장은사', 'doc8@example.com', '010-8888-8888', TO_DATE('1979-06-03', 'YYYY-MM-DD'), 'F', '경기도 수원시', 'M8');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1009', 'doc9', 'password9', '하의사', 'doc9@example.com', '010-9999-9999', TO_DATE('1981-04-27', 'YYYY-MM-DD'), 'M', '강원도 춘천시', 'M9');

INSERT INTO MEMBER (USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL, PHONE, BIRTHDAY, GENDER, ADDRESS, MED_KEY)
VALUES ('U1010', 'doc10', 'password10', '황의사', 'doc10@example.com', '010-1010-1010', TO_DATE('1987-08-18', 'YYYY-MM-DD'), 'F', '제주특별자치도 제주시', 'M10');

--커밋--------------------------------------------------------------------------------------------------------
COMMIT;
