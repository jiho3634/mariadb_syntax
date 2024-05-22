-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id int bigint auto_increment;

-- author.id에 제약조건 추가시 fk로 인해 문제 발생시
-- fk 먼저 제거 이후에 author.id에 제약조건 추가.
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
ALTER TABLE post DROP FOREIGN KEY post_ibfk_1;
alter table author modify column id bigint auto_increment;
alter table post modify column author_id bigint;
--삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

--uuid
alter table post add column user_id char(36) default (UUID());

--unique 제약조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모테이블의 id를 수정하면? 수정안됨
-- fk 먼저 제거 이후에 author.id에 제약조건 추가.
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
ALTER TABLE post DROP FOREIGN KEY post_author_fk;
--삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;
-- author의 데이터를 삭제하면 post에서 같이 삭제된다.
delete from author where id=8;
-- 삭제
ALTER TABLE post DROP FOREIGN KEY post_author_fk;
--삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update cascade;
--post의 author_id가 같이 바뀐다. 
update author set id=11 where id=10;

-- (실습) delete는 set null, update cascade
ALTER TABLE post DROP FOREIGN KEY post_author_fk;
--삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;
