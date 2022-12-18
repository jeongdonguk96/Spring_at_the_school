
-- ����� ���̺�
CREATE TABLE users(
  id VARCHAR2(15) PRIMARY KEY, /* ���̵� */
  pwd VARCHAR2(15), /* ��й�ȣ */
  name VARCHAR2(15), /* �̸� */
  regDate DATE DEFAULT SYSDATE, /* ������ */
  role VARCHAR2(15) DEFAULT 'user' /* ���� */
);

SELECT * FROM users ORDER BY regDate DESC;
DROP TABLE users;

INSERT INTO users VALUES('admin', '1234', '������', sysdate, 'admin');
INSERT INTO users VALUES('jk', '1234', '����', sysdate, 'admin');

-- �Խ��� ���̺�
CREATE TABLE board(
  seq VARCHAR2(7) PRIMARY KEY, /* �۹�ȣ */
  tab VARCHAR2(20), /* �� */
  title VARCHAR2(50), /* ���� */
  writer VARCHAR2(50), /* �ۼ��� */
  content VARCHAR2(1000), /* ���� */
  regDate DATE DEFAULT SYSDATE, /* ����� */
  count VARCHAR2(50) DEFAULT 0, /* ��ȸ�� */
  recommendation VARCHAR2(50) DEFAULT 0, /* ��õ�� */
  uploadFile VARCHAR2(100) /* ÷������ */
);

CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1;

INSERT
  INTO board(seq, tab, title, writer, content, uploadFile)
VALUES (board_seq.NEXTVAL, '����', '�ȳ�', '�Ǹ���', '�ȳ�1', 'nothing.jsp');
INSERT
  INTO board(seq, tab, title, writer, content, uploadFile)
VALUES (board_seq.NEXTVAL, '����', '�ȳ�2', '�Ǹ���', '�ȳ�2', 'nothing.jsp');
INSERT
  INTO board(seq, tab, title, writer, content, uploadFile)
VALUES (board_seq.NEXTVAL, '����', '�ȳ�3', '�Ǹ���', '�ȳ�3', 'nothing.jsp');
    
SELECT * FROM board ORDER BY seq DESC;
DROP TABLE board;

-- ���� ���̺�
CREATE TABLE lecture(
  seq VARCHAR2(3) PRIMARY KEY, /* ���ǹ�ȣ */
  academy VARCHAR2(50), /* �п��� */
  title VARCHAR2(50), /* ���Ǹ� */
  teacher VARCHAR2(50), /* ���� */
  content VARCHAR2(1000), /* ���� */
  period VARCHAR2(50), /* �Ⱓ */
  location VARCHAR2(50), /* ��ġ */
  call VARCHAR2(50), /* ��ȭ��ȣ */
  regDate DATE DEFAULT SYSDATE, /* ����� */
  count VARCHAR2(50) DEFAULT 0, /* ��ȸ�� */
  recommendation VARCHAR2(50) DEFAULT 0, /* ��õ�� */
  uploadFile VARCHAR(100) /* ÷������ */
);