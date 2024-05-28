sudo apt-get update
sudo apt-get install redis-server
redis-server --version

# 레디스 접속
# cli : commandline interface
redis-cli

# redis는 0~15번까지의 database 구성
# 데이터베이스 선택
# default = 0
select 번호 

# 데이터베이스 내 모든 키 조회
keys *

# 일반 String 자료구조
# key:value 값 세팅
# key는 중복되면 안됨
SET key(키) value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# set할 때 key값이 이미 존재하면 덮어쓰기 되는 것이 기본
# 맵저장소에서 key값은 유일하게 관리가 되므로

# nx : not exist
# 덮어쓰기가 되지 않음
set user:email:1 hongildong2@naver.com nx

# ex(만료시간-초단위) - ttl(time to live)
# 20초 뒤에 사라짐
set user:email:2 hong2@naver.com ex 20

# get을 통해 value값 얻기
get test_key1

# 특정 key 삭제
del user:email:1

# 현재 데이터베이스 모든 key값 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0
# 특정 keye값의 value를 1만큼 증가
incr likes:posting:1
# 특정 keye값의 value를 1만큼 감소
decr likes:posting:1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock

# bash쉘을 활용하여 재고감소 프로그램 작성

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}" ex 10

# list
# redis의 list는 javadml deque와 같은 구조
# 즉, double_ended queue 구조
# 데이터 왼쪽 삽입
LPUSH key value
# 데이터 오른쪽 삽입
LPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key
# 데이터 오른쪽부터 꺼내기
RPOP key

lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3

lpop hongildongs

# 꺼내서 없애는게 아니라, 꺼내서 보기만 하는 방법
lrange hongildongs -1 -1

# 데이터 개수 조회
llen key
llen hongildongs

#start부터 end까지 조회
lrange hongildongs start end
# list의 요소 조회시에는 범위지정
lrange hongildongs 0 -1 #처음부터 끝까지

# TTL 적용
expire hongildongs 30
# TTL 조회 (몇 초 남았는지 조회)
ttl hongildons

# POP과 PUSH동시에
rpoplpush back front



# 최근 방문한 페이지
# 10개 정도 데이터 PUSH
# 최근 방문한 페이지 3개 정도만 보여주는
rpush mypages www.google.com
rpush mypages www.naver.com
rpush mypages www.google.com
rpush mypages www.daum.net
rpush mypages www.github.com
lrange mypages 2 -1

# set 자료구조
sadd members member1
sadd members member2
sadd members member3

# set 조회
smembers members
# set에서 멤버 삭제
srem members member2
#set 멤버 개수 반환
scard members
#특정 멤버가 set안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산, 좋아요 수 집계(중복 제거)
sadd visit:2024-05-27 hong1@naver.com
sadd visit:2024-05-27 hong1@naver.com
sadd visit:2024-05-27 hong2@naver.com
scard visit:2024-05-27
출력: (integer) 2 #중복은 카운트 되지 않음

# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1
# score 기준 내림차순 정렬
zrevrange zmembers 0 -1
#zset 삭제
zrem zmembers member2
# zrank는 해당 멤버의 index를 출력
zrank zmembers member2

# 최근 본 상품목록 => sorted set (zset) 을 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192417 orange
zadd recent:products 192425 apple
zadd recent:products 192430 apple

# hashes 객체형 자료구조
# 문자와 숫자가 구분됨
hset poduct:1 name "apple" price 1000 stock 50
#모든 객체값 get
hgetall product:1
# 하나씩 get
hget product:1 name
hget product:1 price
hget product:1 stock
# 특정 요소값 수정
hset product:1 stock 40

#특정 요소의 값을 증가
hincrby product:1 stock 5
hget product:1 stock
#특정 요소의 값을 감소
hincrby product:1 stock -5
hget product:1 stock
