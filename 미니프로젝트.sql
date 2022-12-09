-- 사용자 테이블
CREATE TABLE userTable(
  seq NUMBER(5), /* 일련번호 */
  id VARCHAR2(10), /* 아이디 */ 
  pwd VARCHAR2(15), /* 비밀번호 */
  name VARCHAR2(10), /* 이름 */
  jumin VARCHAR2(14), /* 주민번호 */
  regDate DATE DEFAULT SYSDATE, /* 가입일 */
  admin VARCHAR(1) DEFAULT 'N', /* 관리자여부 */
  CONSTRAINT user_PK PRIMARY KEY(seq, id)
);

CREATE SEQUENCE userTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM userTable ORDER BY seq desc;
DROP TABLE userTable;

-- 메인화면 테이블
CREATE TABLE mainBoardTable(
  seq NUMBER PRIMARY KEY, /* 일련번호 */
  entranceTime TIMESTAMP DEFAULT SYSDATE, /* 입실시간 */
  outingTime TIMESTAMP DEFAULT SYSDATE, /* 외출시간 */
  comebackTime TIMESTAMP DEFAULT SYSDATE, /* 복귀시간 */
  leaveTime TIMESTAMP DEFAULT SYSDATE, /* 퇴실시간 */
  attendance VARCHAR2(3),  /* 출석 */
  tardy VARCHAR2(3), /* 지각 */
  earlyLeave VARCHAR2(3),/* 조퇴 */
  outing VARCHAR2(3), /* 외출 */
  absence  VARCHAR2(3), /* 결석 */
  attendanceRate VARCHAR2(5), /* 출석률 */
  progressRate VARCHAR2(5) /* 진행률 */
);

CREATE SEQUENCE mainBoardTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM mainBoardTable ORDER BY seq desc;
DROP TABLE mainBoardTable;