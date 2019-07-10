CREATE SEQUENCE seq_member;

SELECT * FROM tbl_member;

INSERT INTO tbl_member VALUES
(seq_member.nextval, 'kouzie', 'kouzie', 1, '고지용', '1996-09-18', 1, null);

INSERT INTO tbl_member VALUES
(seq_member.nextval, 'gridLake', 'gridLake', 1, '함치영', '1996-09-18', 1, null);

INSERT INTO tbl_member VALUES
(seq_member.nextval, 'mmrileymm', 'mmrileymm', 1, '문소민', '1996-09-18', 0, null);

INSERT INTO tbl_member VALUES
(seq_member.nextval, 'yea-na', 'yea-na', 1, '신예나', '1996-09-18', 0, null);



INSERT INTO tbl_auth VALUES
(1, 'ROLE_ADMIN');
INSERT INTO tbl_auth VALUES
(2, 'ROLE_ADMIN');
INSERT INTO tbl_auth VALUES
(3, 'ROLE_ADMIN');
INSERT INTO tbl_auth VALUES
(4, 'ROLE_ADMIN');

commit;



desc tbl_survey;

INSERT INTO tbl_survey ( survey_seq, member_seq, title, content, progressing )VALUES
( SEQ_MEMBER.nextval, 1, '현재 진행형 설문', 'content', 1 );

INSERT INTO tbl_survey ( survey_seq, member_seq, title, content, progressing )VALUES
( SEQ_MEMBER.nextval, 1, '마감된 설문', 'content', 0 );

commit;


desc tbl_survey_item;
desc tbl_survey_result;


insert into tbl_survey_item VALUES (SEQ_SURVEY_ITEM.nextval, 5, '전지현');
insert into tbl_survey_item VALUES (SEQ_SURVEY_ITEM.nextval, 5, '고아라');
insert into tbl_survey_item VALUES (SEQ_SURVEY_ITEM.nextval, 5, '한예슬');
insert into tbl_survey_item VALUES (SEQ_SURVEY_ITEM.nextval, 5, '김지원');

select * from tbl_survey_item;

insert into tbl_survey_result VALUES (SEQ_SURVEY_RESULT.nextval, 1, 1, sysdate);
insert into tbl_survey_result VALUES (SEQ_SURVEY_RESULT.nextval, 2, 2, sysdate);
insert into tbl_survey_result VALUES (SEQ_SURVEY_RESULT.nextval, 3, 3, sysdate);
insert into tbl_survey_result VALUES (SEQ_SURVEY_RESULT.nextval, 4, 4, sysdate);

SELECT COUNT(*)
FROM tbl_survey_item tsi
JOIN tbl_survey_result tsr ON tsr.survey_item_seq = tsi.survey_item_seq
JOIN tbl_member tm ON tsr.member_seq = tm.member_seq
GROUP BY (
    TRUNC (
        EXTRACT(YEAR FROM TO_DATE(tm.birth)) - EXTRACT(YEAR FROM TO_DATE(sysdate)), 
        -1
    )
);