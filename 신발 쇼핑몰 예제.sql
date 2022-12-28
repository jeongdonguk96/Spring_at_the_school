-- id: shoppingmall
-- pwd: ora123

-- ȸ�� ���̺�
CREATE TABLE member(
  id VARCHAR2(20) PRIMARY KEY, /* ���̵� */ 
  pwd VARCHAR2(20), /* ��й�ȣ */
  name VARCHAR2(40), /* �̸� */
  email VARCHAR2(40), /* �̸��� */
  zip_num VARCHAR2(7), /* �ּҹ�ȣ */
  address VARCHAR2(100), /* �ּ� */
  phone VARCHAR2(20), /* ��ȭ��ȣ */
  useyn CHAR(1) DEFAULT 'y', /* Ż�𿩺� */
  regDate DATE DEFAULT SYSDATE /* ������ */
);

SELECT * FROM member ORDER BY regDate DESC;
DROP TABLE member;
commit;

-- ��ǰ ���̺�
CREATE TABLE product(
  pseq NUMBER(5) PRIMARY KEY, /* ��Ϲ�ȣ */
  name VARCHAR2(100), /* ��ǰ�� */
  kind CHAR(1), /* ���� 1:��, 2:����, 3:����, 4:������, 5:����Ŀ�� */
  price1 NUMBER(7) DEFAULT 0, /* ���� */
  price2 NUMBER(7) DEFAULT 0, /* �ǸŰ� */
  price3 NUMBER(7) DEFAULT 0, /* �ǸŰ� - ���� */
  content VARCHAR2(1000) DEFAULT NULL, /* ���� */
  image VARCHAR2(50) DEFAULT 'default.jpg', /* �̹��� */
  useyn CHAR(1) DEFAULT 'y', /* �Ż�ǰ ���� y:�Ż�ǰ n:�Ż�ǰ �ƴ�*/ 
  bestyn CHAR(1) DEFAULT 'n', /* ����Ʈ��ǰ ���� y:����Ʈ��ǰ n:����Ʈ��ǰ �ƴ� */
  regDate DATE DEFAULT SYSDATE /* ����� */
);

CREATE SEQUENCE product_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM product ORDER BY pseq DESC;
DROP TABLE product;
commit;
    
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY name) rn, pseq, regDate, name, price1, price2, useyn, bestyn
	      FROM product
	     WHERE name LIKE '%'||''||'%')
 WHERE rn <= 1*10
   AND rn > 0*10;

-- ������ ���̺�
CREATE TABLE admin(
  id  VARCHAR2(20) PRIMARY KEY, /* ���̵� */
  pwd VARCHAR2(20), /* ��й�ȣ */
  name VARCHAR2(40), /* �̸� */
  phone VARCHAR2(20) /* ��ȭ��ȣ */
);

SELECT * FROM admin;
DROP TABLE admin;
commit;

-- ��ٱ��� ���̺�
CREATE TABLE cart(
  cseq NUMBER(10) PRIMARY KEY, /* ��ٱ��Ϲ�ȣ */
  id  VARCHAR2(20), /* ȸ�� ���̵� */
  pseq NUMBER(5), /* ��ǰ��ȣ */
  quantity NUMBER(5) DEFAULT 1, /* ���� */
  result CHAR(1) DEFAULT '1', /* ó������ 1:��ó��, 2:ó��*/
  indate DATE DEFAULT SYSDATE, /* ������ */
  FOREIGN KEY(id) REFERENCES member(id),
  FOREIGN KEY(pseq) REFERENCES product(pseq)
);

CREATE SEQUENCE cart_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM cart ORDER BY indate DESC;
DROP TABLE cart;
commit;

-- �ֹ� ���̺�
CREATE TABLE orders(
  oseq NUMBER(10) PRIMARY KEY, /* �ֹ���ȣ */
  id VARCHAR2(20), /* �̸� */
  indate DATE DEFAULT SYSDATE, /* �ֹ��� */
  FOREIGN KEY(id) REFERENCES member(id)
);

CREATE SEQUENCE orders_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM orders ORDER BY indate DESC;
DROP TABLE orders;
commit;

-- �ֹ��� ���̺�
CREATE TABLE order_detail(
  odseq NUMBER(10) PRIMARY KEY, /* �ֹ��󼼹�ȣ */
  oseq NUMBER(10), /* �ֹ���ȣ */
  pseq NUMBER(5), /* ��ǰ��ȣ */
  quantity NUMBER(5) DEFAULT 1, /* �ֹ����� */
  result CHAR(1) DEFAULT '1', /* ó������ 1:��ó��, 2:ó�� */
  FOREIGN KEY(oseq) REFERENCES orders(oseq),
  FOREIGN KEY(pseq) REFERENCES product(pseq)
);

CREATE SEQUENCE order_detail_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM order_detail ORDER BY odseq DESC;
DROP TABLE order_detail;
commit;

-- QnA ���̺�
CREATE TABLE qna(
  qseq NUMBER(5) PRIMARY KEY, /* �۹�ȣ */
  subject VARCHAR2(30), /* ���� */
  content VARCHAR2(1000), /* ���� */
  reply VARCHAR2(1000), /* �亯 */
  id VARCHAR2(20), /* ���̵� */
  rep CHAR(1) DEFAULT '1', /* �亯���� */
  indate DATE DEFAULT SYSDATE, /* �ۼ��� */
  FOREIGN KEY(id) REFERENCES member(id)
);

CREATE SEQUENCE qna_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM qna ORDER BY qseq DESC;
DROP TABLE qna;
commit;

---- ���� ������ ----
-- ������
INSERT INTO worker VALUES('admin', 'admin', 'ȫ����', '010-777-7777');
INSERT INTO worker VALUES('soonshin', '1234', '�̼���', '010-999-9696');
commit;

-- �����
INSERT INTO member(id, pwd, name, zip_num, address, phone) 
     VALUES ('one', '1111', '�質��', '133-110', '����ü�����������1�� 1����21ȣ', '017-777-7777');
INSERT INTO member(id, pwd, name, zip_num, address, phone)
     VALUES ('two', '2222', '�̹���', '130-120', '����ü��ı����2�� ������ ����Ʈ 201�� 505ȣ', '011-123-4567');
commit;

-- ��ǰ
INSERT INTO product(pseq, name, kind, price1, price2, price3, content, image)
     VALUES (product_seq.NEXTVAL, 'ũ��Ŀ���Ϻ���', '2', '40000', '50000', '10000', '�������� ũ��Ŀ���Ϻ��� �Դϴ�.', 'w2.jpg');
INSERT INTO product(pseq, name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '�պ���', '2', '40000', '50000', '10000','������ �պ��� �Դϴ�.', 'w-28.jpg', 'n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '��', '1', '10000', '12000', '2000', '���������� ��', 'w-26.jpg', 'n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '������', '4', '5000', '5500', '500', '����� �������Դϴ�.', 'w-25.jpg', 'y');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, 'ȸ����', '1', '10000', '12000', '2000', '���������� ��', 'w9.jpg', 'n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image)
     VALUES (product_seq.NEXTVAL, '��������', '2', '12000', '18000', '6000', '������ ����', 'w4.jpg');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL,  '��ũ����', '3', '5000', '5500', '500', '������� �����Դϴ�.', 'w-10.jpg', 'y');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '������', '3', '5000', '5500', '500', '����� �������Դϴ�.', 'w11.jpg', 'y');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image)
     VALUES (product_seq.NEXTVAL,  '����Ŀ��', '4', '15000', '20000', '5000', 'Ȱ������ ���� ����Ŀ���Դϴ�.', 'w1.jpg');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL,  '����', '3', '5000', '5500', '500', '������� �����Դϴ�.', 'w-09.jpg','n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL,  '����Ŀ��', '5', '15000', '20000', '5000', 'Ȱ������ ���� ����Ŀ���Դϴ�.', 'w-05.jpg','n');
commit;
DELETE product;

-- ��ٱ���
INSERT INTO cart(cseq,id, pseq, quantity)
     VALUES (cart_seq.NEXTVAL, 'one', 1, 1);
commit;
DELETE product WHERE pseq=8;

-- �ֹ�
INSERT INTO orders(oseq, id)
     VALUES (orders_seq.NEXTVAL, 'one');
INSERT INTO orders(oseq, id)
     VALUES (orders_seq.NEXTVAL, 'one');
INSERT INTO orders(oseq, id)
     VALUES (orders_seq.NEXTVAL, 'two');     
commit;

-- �ֹ� ��
INSERT INTO order_detail(odseq, oseq, pseq, quantity)
     VALUES (order_detail_seq.NEXTVAL, 1, 1, 1);
INSERT INTO order_detail(odseq, oseq, pseq, quantity)
     VALUES (order_detail_seq.NEXTVAL, 1, 2, 5);
INSERT INTO order_detail(odseq, oseq, pseq, quantity)
     VALUES (order_detail_seq.NEXTVAL, 2, 4, 3);
INSERT INTO order_detail(odseq, oseq, pseq, quantity)
     VALUES (order_detail_seq.NEXTVAL, 3, 3, 1);
INSERT INTO order_detail(odseq, oseq, pseq, quantity)
     VALUES (order_detail_seq.NEXTVAL, 3, 2, 1);
INSERT INTO order_detail(odseq, oseq, pseq, quantity)
     VALUES (order_detail_seq.NEXTVAL, 3, 6, 2);
INSERT INTO order_detail(odseq, oseq, pseq, quantity)
     VALUES (order_detail_seq.NEXTVAL, 3, 1, 2);     
commit;
DELETE order_detail;

-- QnA
INSERT INTO qna (qseq, subject, content, id)
     VALUES (qna_seq.nextval, '�׽�Ʈ', '��������1', 'one');
UPDATE qna SET reply='�亯����', rep='2';
INSERT INTO qna (qseq, subject, content, id)
     VALUES (qna_seq.nextval, '�׽�Ʈ2', '��������2', 'one');     
commit;

-- ��ǰ��
CREATE TABLE product_comment(
  comment_seq NUMBER PRIMARY KEY,
  pseq NUMBER(5,0) NOT NULL,
  content VARCHAR2(1024) NOT NULL,
  writer VARCHAR2(20) NOT NULL,
  regDate DATE DEFAULT SYSDATE,
  modDate DATE DEFAULT SYSDATE,
  CONSTRAINT prod_comment_fk FOREIGN KEY(pseq) REFERENCES product(pseq)
);

CREATE SEQUENCE prod_comment_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM product_comment;
DROP TABLE product_comment;

-- �ּ� ���̺� ���� �� ����
@zip
SELECT * 
  FROM (SELECT *
          FROM address
      ORDER BY zipcode DESC)
 WHERE ROWNUM = 1;

-- �Ż�ǰ ��ȸ�ϴ� �� ����
CREATE OR REPLACE VIEW new_pro_view 
                    AS 
                SELECT pseq, name, price2, image
                  FROM (SELECT row_number() OVER(ORDER BY regDate DESC) rn, pseq, name, price2, image
                          FROM product
                         WHERE useyn = 'y')
                 WHERE rn <=4;

SELECT * FROM new_pro_view;

-- ����Ʈ��ǰ ��ȸ�ϴ� �� ����
CREATE OR REPLACE VIEW best_pro_view 
                    AS 
                SELECT pseq, name, price2, image
                  FROM (SELECT row_number() OVER(ORDER BY regDate DESC) rn, pseq, name, price2, image
                          FROM product
                         WHERE bestyn = 'y')
                 WHERE rn <=4;

SELECT * FROM best_pro_view;

DROP VIEW new_pro_view;

-- ��ٱ��ϸ� ��ȸ�ϴ� �� ����
CREATE OR REPLACE VIEW cart_view 
                    AS 
                SELECT c.cseq, c.id, m.name mname, c.pseq, p.name pname, p.price2, c.quantity, c.indate, c.result
                  FROM cart c, member m, product p
                 WHERE c.id = m.id 
                   AND c.pseq = p.pseq
                   AND c.result = '1';

-- �ֹ���ȣ ����
SELECT NVL2(MAX(oseq), MAX(oseq)+1, 1)
  FROM orders;
  
-- �ֹ����� �� ����
CREATE OR REPLACE VIEW order_view 
                    AS 
                SELECT od.odseq, od.oseq, m.id, m.name mname, od.pseq, p.name pname, od.quantity, p.price2, od.result, o.indate, m.address, m.phone, m.zip_num
                  FROM order_detail od, orders o, member m, product p
                 WHERE od.oseq = o.oseq 
                   AND o.id = m.id 
                   AND od.pseq = p.pseq;
                   
--��ǰ ��� ����¡ ��ȸ              
<![CDATA[
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY name) rn, pseq, regDate, name, price1, price2, useyn, bestyn
	      FROM product
	     WHERE name LIKE '%'?'%')
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;
]]>

-- ��ǰ�� ��� ��� ����¡ ��ȸ
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY regDate DESC) rn, comment_seq, pseq, content, writer, regDate, modDate
          FROM product_comment
         WHERE pseq=4)
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;
   
-- [������] ����ں� ��ü �ֹ� ����¡ ��ȸ
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY result, oseq DESC) rn, odseq, oseq, id, mname, pseq, pname, quantity, price2, result, indate, address, phone, zip_num
		  FROM order_view
		 WHERE mname LIKE '%'||'�ټ���'||'%')
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;
   
-- [������] ��ü ȸ�� ��ȸ
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY regDate DESC) rn, id, pwd, name, email, zip_num, address, phone, useyn, regDate
		  FROM member
		 WHERE name LIKE '%'||'��'||'%')
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;   

-- [������] QnA ��� ��ȸ
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY indate DESC) rn, qseq, subject, content, reply, id, rep, indate
		  FROM qna)
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;    
   
-- [������] �ֹ��Ϸ� ��ȸ
SELECT pname, sum(quantity) 
  FROM order_view
 WHERE result='2'
GROUP BY pname;















 

