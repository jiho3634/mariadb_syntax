-- 사용자관리
-- 사용자 목록 조회
select * from mysql.user;

--사용자 생성
--'test1'@'%'는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321';

-- 사용자에게 권한 부여
grant select on board.author to 'test1'@'localhost';
-- 환경설정을 변경 후 확정
flush privileges;

--test1으로 로그인 후에
select * from board.author;

-- 사용자 계정 삭제
drop user 'test1'@'localhost';

-- 권한 조회
show grants for 'test1'@'localhost';

-- VIEW
-- VIEW 생성
CREATE VIEW author_for_marketing_team as
SELECT name from author;

-- test 계정 view select 권한부여
grant select on board.author_for_marketing_team TO 'test1'@'localhost';
SELECT * FROM board2.author_for_marketing_team;

-- view 변경(대체)
create or replace view author_for_marketing_team as
SELECT name, email, from author;

-- view 삭제
drop view author_for_marketing_team;

-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE 프로시저명
BEGIN
    SELECT 'HELLO WORD';
END
// DELIMITER;

-- 프로시저 호출
CALL test_procedure();

--프로시저 삭제
DROP PROCEDURE test_procedure();

-- 게시글목록조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN
    SELECT * FROM post;
END
// DELIMITER ;

CALL 게시글목록조회();

-- 게시글 단건 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 저자id int, in 제목 varchar(255))
BEGIN
    select * from post where author_id = 저자id and title=제목;
END
// DELIMITER ;
CALL 게시글단건조회(4, 'hello');

-- 글쓰기 : title, contents, 저자ID
DELIMITER //
CREATE PROCEDURE 글쓰기(IN new_title varchar(255), IN new_contents varchar(3000), IN new_author_id int)
BEGIN
    insert into post(title, contents, author_id) values(new_title, new_contents, new_author_id);
END
// DELIMITER ;
CALL 글쓰기('PROCEDURE TEST', 'TITLE, CONTENTS, 1');

-- 글쓰기2 : title, contents, 저자ID
DELIMITER //
CREATE PROCEDURE 글쓰기2(IN titleInput varchar(255), IN contentsInput varchar(3000), IN authorId int)
BEGIN
    declare authorId int;
    select id into authorId from author where email = emailInput;
    insert into post(title, contents, author_id) values(titleInput, contentsInput, authorId);
END
// DELIMITER ;
CALL 글쓰기2('PROCEDURE TEST', 'TITLE, CONTENTS, 1');

-- sql에서 문자열 합치는 concat('hello','world')
-- 글상세조회 : input 값이 postId
-- title, contents, '홍길동' + '님'
DELIMITER //
CREATE PROCEDURE 글상세조회(IN postId int)
BEGIN
    DECLARE authorName varchar(255);
    SELECT name INTO authorName FROM author 
    WHERE id = (SELECT author_id FROM post WHERE id=postId);
    SET authorName = concat(authorName, '님');
    SELECT title, contents, authorName FROM post WHERE id = postId;
END
// DELIMITER ;
CALL 글상세조회(1);

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 10개이상 100개 미만이면 중수입니다. 
-- 그외는 초보입니다. 
-- 그 외는 초보입니다. 
-- input 값 : email 값.
DELIMITER //
CREATE PROCEDURE 등급조회(IN emailInput varchar(255))
BEGIN
    DECLARE authorId int;
    SELECT id INTO authorId FROM author WHERE email=emailInput;
    SELECT count(*) INTO count FROM post WHERE author_id = authorId;
    IF count >= 100 then
        select '고수입니다.';
    ELSEIF count >= 10 and count < 100 then
        select '중수입니다.'
    ELSE
        SELECT '초보입니다.'
    END IF
END
// DELIMITER ;

-- 반복을 통해 post 대량생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요'

DELIMITER //
CREATE PROCEDURE 글도배(in i int)
BEGIN
    declare countValue int default 0;
    while countValue < count DO
        insert into post(title) values('안녕하세요');
        set countValue = countValue + 1;
    end while;
END
// DELIMITER ;

-- 프로시저 생성문 조회
SHOW CREATE PROCEDURE 프로시저명;

--프로시저 권한 부여
GRANT EXCUTE ON board.글도배 TO 'test1'@'localhost';