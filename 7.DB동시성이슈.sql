-- dirty read 실습
-- 워크벤치에서 quto_commit 해제후 update 실행 -> commit이 안된상태
-- 터미널을 열어서 select 했을 때 위 변경사항이 변경됐는지 확인

--phantom read 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 2번의 select가 이뤄지고,
-- 터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 동일한지 확인
START TRANSACTION;
SELECT count(*) FROM author;
DO SLEEP(15);
SELECT count(*) FROM author;
COMMIT;

-- 터미널에서 아래 INSERT문 실행
INSERT INTO author(name, email) values('kim', 'kim@naver.com');

-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- 워크벤치에서 아래 코드 실행
START TRANSACTION;
SELECT post_count FROM author WHERE id=1 lock in share mode;
do sleep(15);
SELECT post_count from author where id=1 lock in share mode;
COMMIT;

SELECT post_count from author where id=1 lock in share mode;
UPDATE author SET post_count=0 where id=1;

--배타적 잠금(exclusive lock) : select for update
-- select 부터 lock
START TRANSACTION;
SELECT post_count FROM author WHERE id=1 for update;
do sleep(15);
SELECT post_count from author where id=1 for update;
COMMIT;

--터미널에서 실행
select post_count from author where id=1 for update;
UPDATE author SET post_count=0 where id=1;
