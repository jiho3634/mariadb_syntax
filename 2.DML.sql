-- insert into : 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);

-- id, name, email -> author 1건 추가
insert into author(id, name, email) values(1, 'hongildong', 'hong@naver.com');

-- select : 데이터 조회, * : 모든 컬럼 조회
select * from author;

-- id, title, content, author_id -> post에 1건 추가
insert into posts(id, title, content) values(1, 'hello', 'hello world');
select * from posts;

--테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';

--외래키 제약조건 조회
SELECT
    CONSTRAINT_NAME,
    UNIQUE_CONSTRAINT_NAME,
    UPDATE_RULE,
    DELETE_RULE
FROM
    information_schema.REFERENTIAL_CONSTRAINTS
WHERE
    CONSTRAINT_SCHEMA = 'board' AND
    TABLE_NAME = 'post';

-- insert문을 통해 author 데이터 4개정도 추가, post 데이터 5개 추가(1개정도는 익명)
insert into author(id, name, email) values(6, 'hongildong2', 'hong@naver.com2');
insert into author(id, name, email) values(7, 'hongildong3', 'hong@naver.com3');
insert into author(id, name, email) values(8, 'hongildong4', 'hong@naver.com4');
insert into author(id, name, email) values(9, 'hongildong5', 'hong@naver.com5');
insert into post(id, title, contents, author_id) values(6, 'hello2', 'hello word2', 6);
insert into post(id, title, contents, author_id) values(7, 'hello3', 'hello word3', 7);
insert into post(id, title, contents, author_id) values(8, 'hello4', 'hello word4', 8);
insert into post(id, title, contents, author_id) values(9, 'hello5', 'hello word5', 9);


-- update 테이블명 set 컬럼명=데이터 where id=1;
-- where 문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의.
update author set name='abc', email='abc@test.com' where id=1;
update author set email='abc2@test.com' where id=2;

-- delete from 테이블명 where 조건
-- where 조건이 생략될 경우 모든 데이터가 삭제됨에 유의.
delete from author where id = 5;

-- select의 다양한 조회방법
select * from author;
select * from author where id = 1;
select * from author where id > 2;
select * from author where id > 2 and name='hongildong3';

-- 특정 컬럼만을 조회할 떄
select name, email from author where id = 3;

-- 중복제거하고 조회
select title from post;
select distinct title from post;

--정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
--아무런 정렬조건 없이 조회할 경우에는 pk기준을 오름차순 정렬
-- asc : dhfmacktns, desc : 내림차순
select * from author order by name asc;

--멀티 order by : 여러 컬럼으로 정렬
select * from post order by title; --asc/desc 생략시 오름차순
select * from post order by title, id desc;

-- limit number : 특정숫자로 결과값 개수 제한
select * from author order by id desc limit 1;

-- alias(별칭)을 이용한 select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name as 이름, a.email as 이메일 from author as a;

-- null을 조회조건으로
select * from post where author_id is not null;
insert into author(id, email, age) 
select * from post where author_id is not null;