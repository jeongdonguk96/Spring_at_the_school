-- ����� ���̺�
CREATE TABLE userTable(
  seq NUMBER(5), /* �Ϸù�ȣ */
  id VARCHAR2(10), /* ���̵� */ 
  pwd VARCHAR2(15), /* ��й�ȣ */
  name VARCHAR2(10), /* �̸� */
  jumin VARCHAR2(14), /* �ֹι�ȣ */
  regDate DATE DEFAULT SYSDATE, /* ������ */
  admin VARCHAR(1) DEFAULT 'N', /* �����ڿ��� */
  CONSTRAINT user_PK PRIMARY KEY(seq, id)
);

CREATE SEQUENCE userTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM userTable ORDER BY seq desc;
DROP TABLE userTable;

-- ����ȭ�� ���̺�
CREATE TABLE mainBoardTable(
  seq NUMBER PRIMARY KEY, /* �Ϸù�ȣ */
  entranceTime TIMESTAMP DEFAULT SYSDATE, /* �Խǽð� */
  outingTime TIMESTAMP DEFAULT SYSDATE, /* ����ð� */
  comebackTime TIMESTAMP DEFAULT SYSDATE, /* ���ͽð� */
  leaveTime TIMESTAMP DEFAULT SYSDATE, /* ��ǽð� */
  attendance VARCHAR2(3),  /* �⼮ */
  tardy VARCHAR2(3), /* ���� */
  earlyLeave VARCHAR2(3),/* ���� */
  outing VARCHAR2(3), /* ���� */
  absence  VARCHAR2(3), /* �Ἦ */
  attendanceRate VARCHAR2(5), /* �⼮�� */
  progressRate VARCHAR2(5) /* ����� */
);

CREATE SEQUENCE mainBoardTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM mainBoardTable ORDER BY seq desc;
DROP TABLE mainBoardTable;