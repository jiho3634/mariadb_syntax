author 테이블에 post_count라고 컬럼(int) 추가
alter table author add column post_count int;

--post에 글 쓴 후에, author 테이블에 post_count 값에 +1 => 트랜잭션
start transaction;
update author set post_count = post_count + 1 where id = 1;
insert into post(title, author_id) values('hello world java', 5);
commit; --또는  rollback;

--stroed 프로시저를 활용한 트랜잭션
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 where id = 1;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world java', 5);
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;
-- 프로시저 호출
CALL InsertPostAndUpdateAuthor();