-- ����� ���̺�
CREATE TABLE userTable(
  seq NUMBER(5) PRIMARY KEY, /* �Ϸù�ȣ */
  id VARCHAR2(10) UNIQUE, /* ���̵� */ 
  pwd VARCHAR2(15), /* ��й�ȣ */
  name VARCHAR2(10), /* �̸� */
  jumin VARCHAR2(14), /* �ֹι�ȣ */
  regDate DATE DEFAULT SYSDATE, /* ������ */
  role VARCHAR(5) DEFAULT 'user' /* �����ڿ��� */
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
VALUES(userTable_seq.NEXTVAL, 'admin', '1234', '������', '000000-0000000', 'admin');

-- ����ȭ�� ���̺�
CREATE TABLE mainBoardTable(
  seq NUMBER(5), /* foreignkey ����, user�� �Ϸù�ȣ */
  entranceTime TIMESTAMP DEFAULT SYSDATE, /* �Խǽð� */
  outingTime TIMESTAMP DEFAULT SYSDATE, /* ����ð� */
  comebackTime TIMESTAMP DEFAULT SYSDATE, /* ���ͽð� */
  leavingTime TIMESTAMP DEFAULT SYSDATE, /* ��ǽð� */
  attendance VARCHAR2(3),  /* �⼮ */
  tardy VARCHAR2(3), /* ���� */
  earlyLeaving VARCHAR2(3),/* ���� */
  outing VARCHAR2(3), /* ���� */
  absence  VARCHAR2(3), /* �Ἦ */
  CONSTRAINT userSeq_FK FOREIGN KEY (seq) REFERENCES userTable(seq)
);

CREATE SEQUENCE mainBoardTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM mainBoardTable ORDER BY seq desc;
DROP TABLE mainBoardTable;

-- ���� �Խ��� ���̺�
CREATE TABLE requestBoardTable(
 seq NUMBER(10) PRIMARY KEY, /* �Ϸù�ȣ */
 title VARCHAR(30), /* ���� */
 writer VARCHAR2(10), /* �ۼ��� */
 content VARCHAR(100), /* ���� */
 regDate DATE DEFAULT SYSDATE, /* �ۼ��� */
 readCount NUMBER(10) /* ��ȸ�� */
);

CREATE SEQUENCE requestBoardTable_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM requestBoardTable ORDER BY seq DESC;
DROP TABLE requestBoardTable;

-- �⼮���� �ý��� ���̺�
CREATE TABLE entranceManager(
  seq NUMBER(5), /* foreignkey ����, user�� �Ϸù�ȣ */
  entranceTime TIMESTAMP DEFAULT SYSDATE, /* �⼮�ð� */
  CONSTRAINT userSeq_FK2 FOREIGN KEY (seq) REFERENCES userTable(seq)
);

SELECT * FROM entranceManager ORDER BY seq DESC;
DROP TABLE attendanceManager;

-- ��ǰ��� �ý��� ���̺�
CREATE TABLE leavingManager(
  seq NUMBER(5), /* foreignkey ����, user�� �Ϸù�ȣ */
  leavingTime TIMESTAMP DEFAULT SYSDATE, /* ��ǽð� */
  CONSTRAINT userSeq_FK3 FOREIGN KEY (seq) REFERENCES userTable(seq)
);

SELECT * FROM leavingManager ORDER BY seq DESC;
DROP TABLE leavingManager;

commit;
