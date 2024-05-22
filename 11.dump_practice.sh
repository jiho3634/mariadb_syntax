# local에서 sql 덤프파일 생성
mysqldump -u root -p --default-charactor-set=utf8mb4 board > dumpfile.sql

# 한글 깨질 때
mysqldump -u root -p board -r dumpfile.sql

# dump 파일을 github에 업로드
git add .
git  commit -m "mariadb syntax"
git push origin main
