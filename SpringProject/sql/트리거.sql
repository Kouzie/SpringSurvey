create or replace TRIGGER TRI_INSERT_AUTH -- 사용자 추가시 auth에 자동으로 ROLE_USER로 추가되도록 설정
AFTER
    INSERT ON tbl_member
    FOR EACH ROW -- 행트리거 필수 선언
BEGIN
    INSERT INTO tbl_auth(member_seq) VALUES
    (:new.member_seq);
END;

-- 1일경우엔 등록한 설문조사에 댓글이 추가될 경우 tbl_notice에 알림 등록
-- 2일경우엔 등록한 설문조사에 누군가 참여할 경우 tbl_notice에 알림 등록

CREATE OR REPLACE TRIGGER TRI_INSERT_NOTICE_SURVEY_REPLY
AFTER
    INSERT ON tbl_reply
    FOR EACH ROW -- 행트리거 필수 선언
DECLARE    
    receive_member NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT member_seq 
            INTO receive_member
        FROM tbl_survey 
        WHERE survey_seq = :new.survey_seq;
        
        INSERT INTO tbl_notice
        (notice_seq, recieve_member_seq, notice_member_seq, survey_seq, reply_seq, survey_result_seq, notice_message, notice_type, notice_regdate, notice_readdate)
        VALUES
        (seq_notice.nextval, receive_member, :new.member_seq, :new.survey_seq, :new.reply_seq, null, '%s'||'님이'|| '%s'||'설문에 댓글을 남기셨습니다.', 1, sysdate, null);
    END IF;
END;



--tbl_survey의 작성자를 알기위해 투표한 번호의 tbl_survey를 join해서 작성자를 찾는다. (res는 트리거 이름이 30글자 넘어가면 안되서 짜름)

CREATE OR REPLACE TRIGGER TRI_INSERT_NOTICE_SURVEY_RES
AFTER
    INSERT ON tbl_survey_result
    FOR EACH ROW -- 행트리거 필수 선언
DECLARE    
    receive_member NUMBER;
    var_survey_seq NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT tbl_survey.member_seq, tbl_survey.survey_seq  
            INTO receive_member, var_survey_seq
        FROM tbl_survey_item
        JOIN tbl_survey ON tbl_survey.survey_seq = tbl_survey_item.survey_seq
        WHERE survey_item_seq = :new.survey_item_seq;
        
        INSERT INTO tbl_notice
        (notice_seq, recieve_member_seq, notice_member_seq, survey_seq, reply_seq, survey_result_seq, notice_message, notice_type, notice_regdate, notice_readdate)
        VALUES
        (seq_notice.nextval, receive_member, :new.member_seq, var_survey_seq, null, :new.survey_result_seq, '%s'||'님이 '||'%s'||'설문에 참여하였습니다.', 2, sysdate, null);
    END IF;
END;