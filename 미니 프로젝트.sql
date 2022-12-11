-- 사용자 테이블
CREATE TABLE userTable(
  seq NUMBER(5) PRIMARY KEY, /* 일련번호 */
  id VARCHAR2(10) UNIQUE, /* 아이디 */ 
  pwd VARCHAR2(15), /* 비밀번호 */
  name VARCHAR2(10), /* 이름 */
  jumin VARCHAR2(14), /* 주민번호 */
  regDate DATE DEFAULT SYSDATE, /* 가입일 */
  role VARCHAR(5) DEFAULT 'user' /* 관리자여부 */
);
ALTER TABLE userTable RENAME COLUMN admin TO role;
ALTER TABLE userTable MODIFY role VARCHAR2(5);
UPDATE userTable SET role='admin' WHERE seq=1;

CREATE SEQUENCE userTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM userTable ORDER BY seq desc;
DROP TABLE userTable;
DROP SEQUENCE userTable_seq;

INSERT INTO userTable(seq, id, pwd, name, jumin, user)
VALUES(userTable_seq.NEXTVAL, 'admin', '1234', '관리자', '000000-0000000', 'admin');

-- 메인화면 테이블
CREATE TABLE mainBoardTable(
  seq NUMBER(5), /* foreignkey 지정, user의 일련번호 */
  entranceTime TIMESTAMP DEFAULT SYSDATE, /* 입실시간 */
  outingTime TIMESTAMP DEFAULT SYSDATE, /* 외출시간 */
  comebackTime TIMESTAMP DEFAULT SYSDATE, /* 복귀시간 */
  leavingTime TIMESTAMP DEFAULT SYSDATE, /* 퇴실시간 */
  attendance VARCHAR2(3),  /* 출석 */
  tardy VARCHAR2(3), /* 지각 */
  earlyLeaving VARCHAR2(3),/* 조퇴 */
  outing VARCHAR2(3), /* 외출 */
  absence  VARCHAR2(3), /* 결석 */
  CONSTRAINT userSeq_FK FOREIGN KEY (seq) REFERENCES userTable(seq)
);

CREATE SEQUENCE mainBoardTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM mainBoardTable ORDER BY seq desc;
DROP TABLE mainBoardTable;

-- 건의 게시판 테이블
CREATE TABLE requestBoardTable(
 seq NUMBER(10) PRIMARY KEY, /* 일련번호 */
 title VARCHAR(30), /* 제목 */
 writer VARCHAR2(10), /* 작성자 */
 content VARCHAR(100), /* 내용 */
 regDate DATE DEFAULT SYSDATE, /* 작성일 */
 readCount NUMBER(10) /* 조회수 */
);

CREATE SEQUENCE requestBoardTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM requestBoardTable ORDER BY seq DESC;
DROP TABLE requestBoardTable;

-- 출석관리 시스템 테이블
CREATE TABLE entranceManager(
  seq NUMBER(5), /* foreignkey 지정, user의 일련번호 */
  entranceTime TIMESTAMP DEFAULT SYSDATE, /* 출석시간 */
  CONSTRAINT userSeq_FK2 FOREIGN KEY (seq) REFERENCES userTable(seq)
);

SELECT * FROM entranceManager ORDER BY seq DESC;
DROP TABLE attendanceManager;

-- 퇴실관리 시스템 테이블
CREATE TABLE leavingManager(
  seq NUMBER(5), /* foreignkey 지정, user의 일련번호 */
  leavingTime TIMESTAMP DEFAULT SYSDATE, /* 퇴실시간 */
  CONSTRAINT userSeq_FK3 FOREIGN KEY (seq) REFERENCES userTable(seq)
);

SELECT * FROM leavingManager ORDER BY seq DESC;
DROP TABLE leavingManager;

commit;
