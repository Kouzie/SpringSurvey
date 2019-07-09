
SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

SELECT 'DROP SEQUENCE "' || SEQUENCE_NAME || '";' FROM user_sequences;

SELECT 'CREATE SEQUENCE "' || TABLE_NAME || '_SEQ";' FROM user_tables;

/* ����� */
CREATE TABLE tbl_member (
	member_seq NUMBER NOT NULL, /* ����� ������ */
	username VARCHAR2(50) NOT NULL, /* ���̵� */
	password VARCHAR2(100) NOT NULL, /* ��й�ȣ */
	enabled NUMBER(1) DEFAULT 1 NOT NULL, /* ��뿩�� */
	name VARCHAR2(50) NOT NULL, /* �̸� */
	birth DATE NOT NULL, /* ���� */
	gender NUMBER(1) NOT NULL, /* ���� */
	image VARCHAR2(1000) /* �������̹��� */
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

/* ����� ���� */
CREATE TABLE tbl_auth (
	member_seq NUMBER NOT NULL, /* ���̵� */
	authority VARCHAR2(20) DEFAULT 'ROLE_USER' NOT NULL /* ���Ѹ� */
);

ALTER TABLE tbl_auth
	ADD
		CONSTRAINT PK_tbl_auth
		PRIMARY KEY (
			member_seq
		);

/* �����׸����̺� */
CREATE TABLE tbl_survey_item (
	survey_item_seq NUMBER NOT NULL, /* �����׸������ */
	survey_seq NUMBER(4) NOT NULL, /* ���� ������ */
	content VARCHAR2(2000) NOT NULL /* ���� */
);

ALTER TABLE tbl_survey_item
	ADD
		CONSTRAINT PK_tbl_survey_item
		PRIMARY KEY (
			survey_item_seq
		);

/* �������̺� */
CREATE TABLE tbl_survey (
	survey_seq NUMBER(4) NOT NULL, /* ���� ������ */
	member_seq NUMBER NOT NULL, /* �ۼ��� */
	title VARCHAR2(500) NOT NULL, /* ���� */
	content VARCHAR2(4000), /* ���� */
	reg_date DATE DEFAULT sysdate NOT NULL, /* �ۼ��� */
	end_date DATE DEFAULT sysdate+10 NOT NULL, /* ������ */
	progressing NUMBER(1) DEFAULT 1 NOT NULL, /* ���� */
	image VARCHAR2(1000) /* �������� */
);

ALTER TABLE tbl_survey
	ADD
		CONSTRAINT PK_tbl_survey
		PRIMARY KEY (
			survey_seq
		);

/* ����������̺� */
CREATE TABLE tbl_survey_result (
	survey_result_seq NUMBER NOT NULL, /* ������������� */
	survey_item_seq NUMBER NOT NULL, /* �����׸������ */
	member_seq NUMBER NOT NULL, /* ������ */
	reg_date DATE DEFAULT sysdate NOT NULL /* ������ */
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
    FOR EACH ROW -- ��Ʈ���� �ʼ� ����
BEGIN
    INSERT INTO tbl_auth(member_seq) VALUES
    (:new.member_seq);
END;