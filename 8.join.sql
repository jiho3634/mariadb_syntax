-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
SELECT * FROM author inner join post on author.id=post.author_id;
SELECT * FROM author a inner join post p on a.id=p.author_id;

--글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author

-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
p.id, p.title, p.contents, a.email from post p left outer join author a on p.author = a.id;

--JOIN된 상황에서의 WHERE 조건 : ON 뒤에 WHERE 조건이 나옴
---1) 글쓴이가 있는 글중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상인 글만
select p.title, a.email 
from post p 
inner join author a 
on p.author_id = a.id 
where a.age >= 25;

-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 
--2024-05-01이후에 만들어진 글만 출력
select p.title a.email
from post
left outer join author a
on p.author_id = a.id
where created_time > '2024-05-01';

-- 조건에 맞는 도서와 저자 리스트 출력

-- 컬럼의 개수와 타입이 같아야 함에 유의
-- union all : 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from talbe2;
--author 테이블의 name, email 그리고 post 테이블이ㅡ title, contents union
select name, email from author union select title, contents from post;

--서브쿼리 : select 문 안에 또다른 리리elect 문을 서브쿼리라 한다. 

-- select 절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id) as count from author a;

-- from절 안에 서브쿼리

-- where 절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post)

--집계함수
select count(*) from author;
select sum(price) frome post;
select round(avg(price), 0) from post;

-- group by와 집계함수
select author_id, count(*), sum(price), round(avg(price), 0), min(price), max(price) 
from post 
group by author_id;

--저자 email, 해당저자가 작성한 글 수를 출력
select a.id, if(p.di is null, 0, count(*)) from author a
left join post p on a.id = p.author_id group by a.id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select year(created_time) as 연도, count(*) from post where 연도 is not null group by 연도 ;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
-- 입양 시각 구하기(1)
-- HAVING : GROUP BY를 통해 나온 통계에 대한 조건
SELECT AUTHOR_ID, COUNT(*) FROM POST GROUP BY AUTHOR_ID;
SELECT AUTHOR_ID, COUNT(*) FROM POST GROUP BY AUTHOR_ID HAVING COUNT >= 2;
-- (실습) 포스팅 PRICE가 3000원 이상인 글을 작성자별로 몇건인지와 평균 PRICE를 구하되, 
--평균 PRICE가 3000원 이상인 데이터를 대상으로만 통계 출력
SELECT AUTHOR_ID, COUNT(AUTHOR_ID) AS COUNT, AVG(PRICE) FROM POST WHERE PRICE >= 3000
GROUP BY AUTHOR_ID HAVING AVG_PRICE>=3000;

--동명 동물 수 찾기

-- (실습) 1건 이상의 글을 쓴 사람의 EMAIL과 글 구할건데,
-- 나이는 25세 이상인 사람만 통계에 사용하고,
-- 가장 나이 많은 사람 1명의 통계만 출력

SELECT A.ID, COUNT(A.ID) AS COUNT 
FROM AUTHOR A 
INNER JOIN POST p
ON A.ID = P.AUTHOR_ID
WHERE A.AGE >= 25
GROUP BY A.ID HAVING COUNT>=2
ORDER BY A.AGE DESC
LIMIT 1;

-- 다중열 GROUP BY
SELECT AUTHOR_ID, TITLE, COUNT(*) FROM POST GROUP BY AUTHOR_ID, TITLE;

