--흐름제어 : case문
SELECT 컬럼1, 컬럼2, 컬럼3
CASE 컬럼4
    WHEN 비교값1 THEN 결과값1
    WHEN 비교값2 THEN 결과값2
    ELSE 결과값3
END
FROM 테이블명;

-- POST 테이블에서  1번 USER는 first author, 2번 user는 second author
select id, title, contents,
    case author_id
        when 1 then 'first author'
        when 2 then 'second author'
        else 'others'
    END
from post;

--author_id가 있으면 그대로 출력 else author_id, 
--없으면 '익명사용자'로 출력되도록 post테이블 조회
select id, title, contents,
    case author_id
        when 1 then 'first author'
        when 2 then 'second author'
        else 'others'
    END as author_id
from post;

-- 위 CASE문을 IFNULL 구문으로 변환
select id, title, contents, ifnull(author_id, 'others') AS author_id
from post;

-- if문 구문으로 변환
select id, title, contents, if(author_id, author_id, 'others') as author_id
from post;