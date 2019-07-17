
SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

SELECT 'DROP SEQUENCE "' || SEQUENCE_NAME || '";' FROM user_sequences;

SELECT 'CREATE SEQUENCE "' || TABLE_NAME || '_SEQ";' FROM user_tables;



/* ����� */
CREATE TABLE tbl_member (
	member_seq NUMBER NOT NULL, /* ����� ������ */
	username VARCHAR2(50) NOT NULL, /* ���̵� */
	email VARCHAR2(200) NOT NULL, /* �̸��� */
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
	survey_seq NUMBER(4), /* ���� ������ */
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

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT UK_tbl_survey_result
		UNIQUE (
			survey_seq,
			member_seq
		);

/* ������̺� */
CREATE TABLE tbl_reply (
	reply_seq NUMBER NOT NULL, /* ��� ������ */
	survey_seq NUMBER(4) NOT NULL, /* ���� ������ */
	member_seq NUMBER NOT NULL, /* ����� ������ */
	reply_msg VARCHAR2(2000), /* ��� ���� */
	writetime DATE NOT NULL /* ��� �ۼ� �ð� */
);

ALTER TABLE tbl_reply
	ADD
		CONSTRAINT PK_tbl_reply
		PRIMARY KEY (
			reply_seq
		);

/* �˸����̺� */
CREATE TABLE tbl_notice (
	notice_seq NUMBER NOT NULL, /* �˸� ������ */
	recieve_member_seq NUMBER NOT NULL, /* �˸������� */
	notice_member_seq NUMBER, /* �˸��߽��� */
	survey_seq NUMBER(4), /* ���� ������ */
	reply_seq NUMBER, /* ��� ������ */
	survey_result_seq NUMBER, /* ������������� */
	notice_message VARCHAR2(200) NOT NULL, /* �˸��޼��� */
	notice_type NUMBER(2), /* �˸�Ÿ��(���, ����) */
	notice_regdate DATE NOT NULL, /* �˸����� ��¥ */
	notice_readdate DATE /* �˸�Ȯ�γ�¥ */
);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT PK_tbl_notice
		PRIMARY KEY (
			notice_seq
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

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT FK_tbl_sur_TO_tbl_sur_result
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		);

ALTER TABLE tbl_reply
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_reply
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_reply
	ADD
		CONSTRAINT FK_tbl_survey_TO_tbl_reply
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_survey_TO_tbl_notice
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_notice
		FOREIGN KEY (
			recieve_member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_notice2
		FOREIGN KEY (
			notice_member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_reply_TO_tbl_notice
		FOREIGN KEY (
			reply_seq
		)
		REFERENCES tbl_reply (
			reply_seq
		);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_survey_res_TO_tbl_not
		FOREIGN KEY (
			survey_result_seq
		)
		REFERENCES tbl_survey_result (
			survey_result_seq
		);
		
CREATE SEQUENCE "SEQ_MEMBER";
CREATE SEQUENCE "SEQ_AUTH";
CREATE SEQUENCE "SEQ_SURVEY_ITEM";
CREATE SEQUENCE "SEQ_SURVEY";
CREATE SEQUENCE "SEQ_SURVEY_RESULT";
CREATE SEQUENCE "SEQ_REPLY";
CREATE SEQUENCE "SEQ_NOTICE";