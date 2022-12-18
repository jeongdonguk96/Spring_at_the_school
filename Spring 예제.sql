
-- 사용자 테이블
CREATE TABLE users(
  id VARCHAR2(15) PRIMARY KEY, /* 아이디 */
  pwd VARCHAR2(15), /* 비밀번호 */
  name VARCHAR2(15), /* 이름 */
  regDate DATE DEFAULT SYSDATE, /* 가입일 */
  role VARCHAR2(15) DEFAULT 'user' /* 권한 */
);

SELECT * FROM users ORDER BY regDate DESC;
DROP TABLE users;

INSERT INTO users VALUES('admin', '1234', '정동욱', sysdate, 'admin');
INSERT INTO users VALUES('jk', '1234', '구슬', sysdate, 'admin');

-- 게시판 테이블
CREATE TABLE board(
  seq VARCHAR2(7) PRIMARY KEY, /* 글번호 */
  tab VARCHAR2(20), /* 탭 */
  title VARCHAR2(50), /* 제목 */
  writer VARCHAR2(50), /* 작성자 */
  content VARCHAR2(1000), /* 내용 */
  regDate DATE DEFAULT SYSDATE, /* 등록일 */
  count VARCHAR2(50) DEFAULT 0, /* 조회수 */
  recommendation VARCHAR2(50) DEFAULT 0, /* 추천수 */
  uploadFile VARCHAR2(100) /* 첨부파일 */
);

CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1;

INSERT
  INTO board(seq, tab, title, writer, content, uploadFile)
VALUES (board_seq.NEXTVAL, '공지', '안녕', '판리자', '안녕1', 'nothing.jsp');
INSERT
  INTO board(seq, tab, title, writer, content, uploadFile)
VALUES (board_seq.NEXTVAL, '유머', '안녕2', '판리자', '안녕2', 'nothing.jsp');
INSERT
  INTO board(seq, tab, title, writer, content, uploadFile)
VALUES (board_seq.NEXTVAL, '정보', '안녕3', '판리자', '안녕3', 'nothing.jsp');
    
SELECT * FROM board ORDER BY seq DESC;
DROP TABLE board;

-- 강의 테이블
CREATE TABLE lecture(
  seq VARCHAR2(3) PRIMARY KEY, /* 강의번호 */
  academy VARCHAR2(50), /* 학원명 */
  title VARCHAR2(50), /* 강의명 */
  teacher VARCHAR2(50), /* 강사 */
  content VARCHAR2(1000), /* 내용 */
  period VARCHAR2(50), /* 기간 */
  location VARCHAR2(50), /* 위치 */
  call VARCHAR2(50), /* 전화번호 */
  regDate DATE DEFAULT SYSDATE, /* 등록일 */
  count VARCHAR2(50) DEFAULT 0, /* 조회수 */
  recommendation VARCHAR2(50) DEFAULT 0, /* 추천수 */
  uploadFile VARCHAR(100) /* 첨부파일 */
);