-- id: shoppingmall
-- pwd: ora123

-- 회원 테이블
CREATE TABLE member(
  id VARCHAR2(20) PRIMARY KEY, /* 아이디 */ 
  pwd VARCHAR2(20), /* 비밀번호 */
  name VARCHAR2(40), /* 이름 */
  email VARCHAR2(40), /* 이메일 */
  zip_num VARCHAR2(7), /* 주소번호 */
  address VARCHAR2(100), /* 주소 */
  phone VARCHAR2(20), /* 전화번호 */
  useyn CHAR(1) DEFAULT 'y', /* 탈퇴여부 */
  regDate DATE DEFAULT SYSDATE /* 가입일 */
);

SELECT * FROM member ORDER BY regDate DESC;
DROP TABLE member;
commit;

-- 상품 테이블
CREATE TABLE product(
  pseq NUMBER(5) PRIMARY KEY, /* 등록번호 */
  name VARCHAR2(100), /* 상품명 */
  kind CHAR(1), /* 종류 1:힐, 2:부츠, 3:샌달, 4:슬리퍼, 5:스니커즈 */
  price1 NUMBER(7) DEFAULT 0, /* 원가 */
  price2 NUMBER(7) DEFAULT 0, /* 판매가 */
  price3 NUMBER(7) DEFAULT 0, /* 판매가 - 원가 */
  content VARCHAR2(1000) DEFAULT NULL, /* 내용 */
  image VARCHAR2(50) DEFAULT 'default.jpg', /* 이미지 */
  useyn CHAR(1) DEFAULT 'y', /* 신상품 여부 y:신상품 n:신상품 아님*/ 
  bestyn CHAR(1) DEFAULT 'n', /* 베스트상품 여부 y:베스트상품 n:베스트상품 아님 */
  regDate DATE DEFAULT SYSDATE /* 등록일 */
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

-- 관리자 테이블
CREATE TABLE admin(
  id  VARCHAR2(20) PRIMARY KEY, /* 아이디 */
  pwd VARCHAR2(20), /* 비밀번호 */
  name VARCHAR2(40), /* 이름 */
  phone VARCHAR2(20) /* 전화번호 */
);

SELECT * FROM admin;
DROP TABLE admin;
commit;

-- 장바구니 테이블
CREATE TABLE cart(
  cseq NUMBER(10) PRIMARY KEY, /* 장바구니번호 */
  id  VARCHAR2(20), /* 회원 아이디 */
  pseq NUMBER(5), /* 상품번호 */
  quantity NUMBER(5) DEFAULT 1, /* 수량 */
  result CHAR(1) DEFAULT '1', /* 처리여부 1:미처리, 2:처리*/
  indate DATE DEFAULT SYSDATE, /* 저장일 */
  FOREIGN KEY(id) REFERENCES member(id),
  FOREIGN KEY(pseq) REFERENCES product(pseq)
);

CREATE SEQUENCE cart_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM cart ORDER BY indate DESC;
DROP TABLE cart;
commit;

-- 주문 테이블
CREATE TABLE orders(
  oseq NUMBER(10) PRIMARY KEY, /* 주문번호 */
  id VARCHAR2(20), /* 이름 */
  indate DATE DEFAULT SYSDATE, /* 주문일 */
  FOREIGN KEY(id) REFERENCES member(id)
);

CREATE SEQUENCE orders_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM orders ORDER BY indate DESC;
DROP TABLE orders;
commit;

-- 주문상세 테이블
CREATE TABLE order_detail(
  odseq NUMBER(10) PRIMARY KEY, /* 주문상세번호 */
  oseq NUMBER(10), /* 주문번호 */
  pseq NUMBER(5), /* 상품번호 */
  quantity NUMBER(5) DEFAULT 1, /* 주문수량 */
  result CHAR(1) DEFAULT '1', /* 처리여부 1:미처리, 2:처리 */
  FOREIGN KEY(oseq) REFERENCES orders(oseq),
  FOREIGN KEY(pseq) REFERENCES product(pseq)
);

CREATE SEQUENCE order_detail_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM order_detail ORDER BY odseq DESC;
DROP TABLE order_detail;
commit;

-- QnA 테이블
CREATE TABLE qna(
  qseq NUMBER(5) PRIMARY KEY, /* 글번호 */
  subject VARCHAR2(30), /* 제목 */
  content VARCHAR2(1000), /* 내용 */
  reply VARCHAR2(1000), /* 답변 */
  id VARCHAR2(20), /* 아이디 */
  rep CHAR(1) DEFAULT '1', /* 답변유무 */
  indate DATE DEFAULT SYSDATE, /* 작성일 */
  FOREIGN KEY(id) REFERENCES member(id)
);

CREATE SEQUENCE qna_seq
START WITH 1
INCREMENT BY 1;

SELECT * FROM qna ORDER BY qseq DESC;
DROP TABLE qna;
commit;

---- 샘플 데이터 ----
-- 관리자
INSERT INTO worker VALUES('admin', 'admin', '홍관리', '010-777-7777');
INSERT INTO worker VALUES('soonshin', '1234', '이순신', '010-999-9696');
commit;

-- 사용자
INSERT INTO member(id, pwd, name, zip_num, address, phone) 
     VALUES ('one', '1111', '김나리', '133-110', '서울시성동구성수동1가 1번지21호', '017-777-7777');
INSERT INTO member(id, pwd, name, zip_num, address, phone)
     VALUES ('two', '2222', '이백합', '130-120', '서울시송파구잠실2동 리센츠 아파트 201동 505호', '011-123-4567');
commit;

-- 상품
INSERT INTO product(pseq, name, kind, price1, price2, price3, content, image)
     VALUES (product_seq.NEXTVAL, '크로커다일부츠', '2', '40000', '50000', '10000', '오리지날 크로커다일부츠 입니다.', 'w2.jpg');
INSERT INTO product(pseq, name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '롱부츠', '2', '40000', '50000', '10000','따뜻한 롱부츠 입니다.', 'w-28.jpg', 'n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '힐', '1', '10000', '12000', '2000', '여성용전용 힐', 'w-26.jpg', 'n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '슬리퍼', '4', '5000', '5500', '500', '편안한 슬리퍼입니다.', 'w-25.jpg', 'y');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '회색힐', '1', '10000', '12000', '2000', '여성용전용 힐', 'w9.jpg', 'n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image)
     VALUES (product_seq.NEXTVAL, '여성부츠', '2', '12000', '18000', '6000', '여성용 부츠', 'w4.jpg');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL,  '핑크샌달', '3', '5000', '5500', '500', '사계절용 샌달입니다.', 'w-10.jpg', 'y');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL, '슬리퍼', '3', '5000', '5500', '500', '편안한 슬리퍼입니다.', 'w11.jpg', 'y');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image)
     VALUES (product_seq.NEXTVAL,  '스니커즈', '4', '15000', '20000', '5000', '활동성이 좋은 스니커즈입니다.', 'w1.jpg');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL,  '샌달', '3', '5000', '5500', '500', '사계절용 샌달입니다.', 'w-09.jpg','n');
INSERT INTO product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
     VALUES (product_seq.NEXTVAL,  '스니커즈', '5', '15000', '20000', '5000', '활동성이 좋은 스니커즈입니다.', 'w-05.jpg','n');
commit;
DELETE product;

-- 장바구니
INSERT INTO cart(cseq,id, pseq, quantity)
     VALUES (cart_seq.NEXTVAL, 'one', 1, 1);
commit;
DELETE product WHERE pseq=8;

-- 주문
INSERT INTO orders(oseq, id)
     VALUES (orders_seq.NEXTVAL, 'one');
INSERT INTO orders(oseq, id)
     VALUES (orders_seq.NEXTVAL, 'one');
INSERT INTO orders(oseq, id)
     VALUES (orders_seq.NEXTVAL, 'two');     
commit;

-- 주문 상세
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
     VALUES (qna_seq.nextval, '테스트', '질문내용1', 'one');
UPDATE qna SET reply='답변내용', rep='2';
INSERT INTO qna (qseq, subject, content, id)
     VALUES (qna_seq.nextval, '테스트2', '질문내용2', 'one');     
commit;

-- 상품평
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

-- 주소 테이블 생성 및 삽입
@zip
SELECT * 
  FROM (SELECT *
          FROM address
      ORDER BY zipcode DESC)
 WHERE ROWNUM = 1;

-- 신상품 조회하는 뷰 생성
CREATE OR REPLACE VIEW new_pro_view 
                    AS 
                SELECT pseq, name, price2, image
                  FROM (SELECT row_number() OVER(ORDER BY regDate DESC) rn, pseq, name, price2, image
                          FROM product
                         WHERE useyn = 'y')
                 WHERE rn <=4;

SELECT * FROM new_pro_view;

-- 베스트상품 조회하는 뷰 생성
CREATE OR REPLACE VIEW best_pro_view 
                    AS 
                SELECT pseq, name, price2, image
                  FROM (SELECT row_number() OVER(ORDER BY regDate DESC) rn, pseq, name, price2, image
                          FROM product
                         WHERE bestyn = 'y')
                 WHERE rn <=4;

SELECT * FROM best_pro_view;

DROP VIEW new_pro_view;

-- 장바구니를 조회하는 뷰 생성
CREATE OR REPLACE VIEW cart_view 
                    AS 
                SELECT c.cseq, c.id, m.name mname, c.pseq, p.name pname, p.price2, c.quantity, c.indate, c.result
                  FROM cart c, member m, product p
                 WHERE c.id = m.id 
                   AND c.pseq = p.pseq
                   AND c.result = '1';

-- 주문번호 생성
SELECT NVL2(MAX(oseq), MAX(oseq)+1, 1)
  FROM orders;
  
-- 주문정보 뷰 생성
CREATE OR REPLACE VIEW order_view 
                    AS 
                SELECT od.odseq, od.oseq, m.id, m.name mname, od.pseq, p.name pname, od.quantity, p.price2, od.result, o.indate, m.address, m.phone, m.zip_num
                  FROM order_detail od, orders o, member m, product p
                 WHERE od.oseq = o.oseq 
                   AND o.id = m.id 
                   AND od.pseq = p.pseq;
                   
--상품 목록 페이징 조회              
<![CDATA[
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY name) rn, pseq, regDate, name, price1, price2, useyn, bestyn
	      FROM product
	     WHERE name LIKE '%'?'%')
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;
]]>

-- 상품별 댓글 목록 페이징 조회
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY regDate DESC) rn, comment_seq, pseq, content, writer, regDate, modDate
          FROM product_comment
         WHERE pseq=4)
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;
   
-- [관리자] 사용자별 전체 주문 페이징 조회
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY result, oseq DESC) rn, odseq, oseq, id, mname, pseq, pname, quantity, price2, result, indate, address, phone, zip_num
		  FROM order_view
		 WHERE mname LIKE '%'||'다서이'||'%')
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;
   
-- [관리자] 전체 회원 조회
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY regDate DESC) rn, id, pwd, name, email, zip_num, address, phone, useyn, regDate
		  FROM member
		 WHERE name LIKE '%'||'이'||'%')
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;   

-- [관리자] QnA 목록 조회
SELECT *
  FROM (SELECT row_number() OVER (ORDER BY indate DESC) rn, qseq, subject, content, reply, id, rep, indate
		  FROM qna)
 WHERE rn <= 1 * 10
   AND rn > 0 * 10;    
   
-- [관리자] 주문완료 조회
SELECT pname, sum(quantity) 
  FROM order_view
 WHERE result='2'
GROUP BY pname;















 

