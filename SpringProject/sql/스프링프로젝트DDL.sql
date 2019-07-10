
SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

SELECT 'DROP SEQUENCE "' || SEQUENCE_NAME || '";' FROM user_sequences;

SELECT 'CREATE SEQUENCE "' || TABLE_NAME || '_SEQ";' FROM user_tables;

/* 사용자 */
CREATE TABLE tbl_member (
	member_seq NUMBER NOT NULL, /* 사용자 시퀀스 */
	username VARCHAR2(50) NOT NULL, /* 아이디 */
	password VARCHAR2(100) NOT NULL, /* 비밀번호 */
	enabled NUMBER(1) DEFAULT 1 NOT NULL, /* 사용여부 */
	name VARCHAR2(50) NOT NULL, /* 이름 */
	birth DATE NOT NULL, /* 생일 */
	gender NUMBER(1) NOT NULL, /* 성별 */
	image VARCHAR2(1000) /* 프로필이미지 */
);

ALTER TABLE tbl_member
	ADD
		CONSTRAINT PK_tbl_member
		PRIMARY KEY (
			member_seq
		);

ALTER TABLE tbl_member
	ADD
		CONSTRAINT UK_tbl_member
		UNIQUE (
			username
		);

/* 사용자 권한 */
CREATE TABLE tbl_auth (
	member_seq NUMBER NOT NULL, /* 아이디 */
	authority VARCHAR2(20) DEFAULT 'ROLE_USER' NOT NULL /* 권한명 */
);

ALTER TABLE tbl_auth
	ADD
		CONSTRAINT PK_tbl_auth
		PRIMARY KEY (
			member_seq
		);

/* 설문항목테이블 */
CREATE TABLE tbl_survey_item (
	survey_item_seq NUMBER NOT NULL, /* 설문항목시퀀스 */
	survey_seq NUMBER(4) NOT NULL, /* 설문 시퀀스 */
	content VARCHAR2(2000) NOT NULL /* 내용 */
);

ALTER TABLE tbl_survey_item
	ADD
		CONSTRAINT PK_tbl_survey_item
		PRIMARY KEY (
			survey_item_seq
		);

/* 설문테이블 */
CREATE TABLE tbl_survey (
	survey_seq NUMBER(4) NOT NULL, /* 설문 시퀀스 */
	member_seq NUMBER NOT NULL, /* 작성자 */
	title VARCHAR2(500) NOT NULL, /* 제목 */
	content VARCHAR2(4000), /* 내용 */
	reg_date DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	end_date DATE DEFAULT sysdate+10 NOT NULL, /* 마감일 */
	progressing NUMBER(1) DEFAULT 1 NOT NULL, /* 상태 */
	image VARCHAR2(1000) /* 설문사진 */
);

ALTER TABLE tbl_survey
	ADD
		CONSTRAINT PK_tbl_survey
		PRIMARY KEY (
			survey_seq
		);

/* 설문결과테이블 */
CREATE TABLE tbl_survey_result (
	survey_result_seq NUMBER NOT NULL, /* 설문결과시퀀스 */
	survey_item_seq NUMBER NOT NULL, /* 설문항목시퀀스 */
	member_seq NUMBER NOT NULL, /* 참여자 */
	reg_date DATE DEFAULT sysdate NOT NULL /* 참여일 */
);

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT PK_tbl_survey_result
		PRIMARY KEY (
			survey_result_seq
		);

ALTER TABLE tbl_auth
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_auth
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_survey_item
	ADD
		CONSTRAINT FK_tbl_sur_TO_tbl_sur_item
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_survey
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_survey
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT FK_sur_it_TO_sur_re
		FOREIGN KEY (
			survey_item_seq
		)
		REFERENCES tbl_survey_item (
			survey_item_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT FK_tbl_mem_TO_tbl_sur_result
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);
        
CREATE SEQUENCE "SEQ_MEMBER";
CREATE SEQUENCE "SEQ_AUTH";
CREATE SEQUENCE "SEQ_SURVEY_ITEM";
CREATE SEQUENCE "SEQ_SURVEY";
CREATE SEQUENCE "SEQ_SURVEY_RESULT";

desc tbl_auth;

CREATE OR REPLACE TRIGGER tri_insert_auth
AFTER
    INSERT ON tbl_member
    FOR EACH ROW -- 행트리거 필수 선언
BEGIN
    INSERT INTO tbl_auth(member_seq) VALUES
    (:new.member_seq);
END;