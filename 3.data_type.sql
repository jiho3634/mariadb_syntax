-- tinyint는 -128~127까지 표현
-- author 테이블에 age컬럼 추가.
alter table author add column age tinyint;
--insert 시에 age: 128->127
insert into author(id, email, age) values(5, 'hello@naver.com', 128);
insert into author(id, email, age) values(5, 'hello@naver.com', 127);
alter table author modify column age tinyint unsigned;
insert into author(id, email, age) values(5, 'hello@naver.com', 200);

-- decimal 실습
alter table post add column price decimal(10,3);
describe post;

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values(6, 'hello java', 3.123123);
--update : price를 1234.1
update post set price=1234.1 where id=6;

--blob 바이너리 데이터 실습
--author 테이블에 profile_image 컬럼을 blob 형식으로 추가
alter table author add column profile_image blob;
describe author;
alter table author modify column profile_image longblob;
insert into author(id, email, profile_image) values(11, 'image@gmail.com', LOAD_FILE("C:\\image.png"));

--enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
--role컬럼
alter table author add column role enum('user', 'admin') not null;
--enum컬럼 실습
--user1을 insert => 에러
--user 또는 admin insert => 정상

--date 타입
--author 테이블에 birth_day 컬럼을 date로 추가
insert into author(id, email, birth_day) values(18, 'a@b.c', '1990-05-31');

--datetime 타입
-- author, post 둘 다 datatime으로 created_time 컬럼추가가
alter table author add column created_time datetime;
insert into author(id, email, birth_day) values(18, 'a@b.c', '1990-05-31');
alter table author add column created_time datetime;
insert into author(id, email, created_time) values(19, 'd', '2024-05-17 12:22:22');
alter table author modify column created_time datetime default current_timestamp;
insert into author(id, email) values(20, 'd');

--비교연산자
--and 또는 &&
select * from post where id>=2 and id<=4;
select * from post where id>=2 && id<=4; select * from post where id between 2 and 4;
-- or 또는 ||
select * from post where id<2 or id>4; 
select * from post where id<2 || id>4; 
-- not 또는 !
select * from post where not(id<2 or id>4);
select * from post where !(id<2 or id>4);

--NULL인지 아닌지
select * from post where contents is null;
select * from where contents is not null;

-- in(리스트), not in(리스트)
select * from post where id in(1,2,3,4);

-- like
--o로 끝나는 title검색
select * from post where title like '%o' 
--h로 시작하는 title검색
select * from post where title like 'h%' 
--단어의 중간에 llo라는 키워드가 있는 경우 검색
select * from post where title like '%llo%' 
-- o로 끝나는 title이 아닌 title 검색
select * from post where title not like '%o' 

--ifnull(a,b) : 만약에 a가 null이면 b 반환, null이 아니면 a반환
select title, contents, ifnull(author_id, '익명') as writer from post;
-- 프로그래머스 문제 풀기 : 경기도에 위치한 식품창고 목록 출력하기 

-- REGEXP : 정규표현식을 활용한 조회
--영어로만 이루어진 
select * from author where name regexp '[a-z]';
--한글로만 이루어진 
select * from author where name regexp '[가-힣]';

--날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
--CAST와 CONVERT
select cast(20200101 AS DATE);
select cast('20200101' AS DATE);
select convert(20200101, DATE);
select convert('20200101', DATE);

-- datetime 조회방법
select * from post where created_time like '2024-05%';
select * from post where created_time <= '2024-12-31' and created_time>='1999-01-01';
select * from post where between created_time <= '2024-12-31' and created_time>='1999-01-01';

-- date_format
select date_format(created_time, '%Y-%m') from post;

-- 오늘 날짜
select now();
