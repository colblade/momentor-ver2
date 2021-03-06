--테이블 드롭
DROP TABLE KEYWORD_STATS;
DROP TABLE RECOMMEND_INFO;
DROP TABLE EXERCISE_CART;
DROP TABLE EXERCISE_PLANNER;
DROP TABLE EXERCISE_PLANNERCONTENT;
DROP TABLE EXERCISE_URL;
DROP TABLE MEMBER_IMG;
DROP TABLE MEMBER_REPLY;
DROP TABLE MEMBER_BOARD;
DROP TABLE EXERCISE_IMG;
DROP TABLE EXERCISE_BOARD;
DROP TABLE NOTICE_BOARD;
DROP TABLE QNA_BOARD;
DROP TABLE FAQ_BOARD;
DROP TABLE MOMEMTOR_MEMBER_PHYSICAL;
DROP TABLE EXERCISE;
DROP TABLE MOMENTOR_MEMBER CASCADE CONSTRAINTS;

--게시물 테이블에 해당하는 seq 드롭
DROP SEQUENCE NOTICE_SEQ;
DROP SEQUENCE EXERCISE_SEQ;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE REPLY_SEQ;
DROP SEQUENCE FAQ_BOARD_SEQ;
DROP SEQUENCE QNA_SEQ;

--운동
CREATE TABLE EXERCISE(
EXERCISENAME VARCHAR2(100) PRIMARY KEY,
EXERCISEBODY VARCHAR2(100) NOT NULL
);

--모멘토 멤버
CREATE TABLE MOMENTOR_MEMBER(
MEMBERID VARCHAR2(100) PRIMARY KEY,
MEMBERPASSWORD VARCHAR2(100) NOT NULL,
MEMBERNAME VARCHAR2(100) NOT NULL,
BIRTHYEAR NUMBER NOT NULL,
BIRTHMONTH NUMBER NOT NULL,
BIRTHDAY NUMBER NOT NULL,
NICKNAME VARCHAR2(200) NOT NULL,
MEMBEREMAIL VARCHAR2(200) NOT NULL,
GENDER VARCHAR2(20) NOT NULL, -- M: MALE F:FEMALE
MEMBERADDRESS VARCHAR2(1000) NOT NULL,
AUTH NUMBER DEFAULT 2  NOT NULL, -- 1일때 관리자 2일때 일반유저
INFO_PUBLIC NUMBER NOT NULL
);

--멤버 신체 정보
CREATE TABLE MOMEMTOR_MEMBER_PHYSICAL(
MEMBERWEIGHT NUMBER NOT NULL,
MEMBERHEIGHT NUMBER NOT NULL,
AGE NUMBER NOT NULL,
BMI NUMBER NOT NULL,
MEMBERID VARCHAR2(100) PRIMARY KEY,
CONSTRAINT FK_ID_M_P FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)
);

--관리자 공지사항 게시판 
CREATE TABLE NOTICE_BOARD(
NOTICE_NO NUMBER PRIMARY KEY,
MEMBERID VARCHAR2(100) NOT NULL,
TITLE VARCHAR2(1000) NOT NULL,
NOTICE_DATE DATE NOT NULL,
CONTENT CLOB NOT NULL,
CONSTRAINT FK_ID_M_NB FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)
);

--공지사항 시퀀스
CREATE SEQUENCE NOTICE_SEQ NOCACHE;

--관리자 운동 게시판
CREATE TABLE EXERCISE_BOARD(
EXERCISENAME VARCHAR2(100) PRIMARY KEY,
EXERCISE_NO NUMBER NOT NULL,
MEMBERID VARCHAR2(100) NOT NULL,
TITLE VARCHAR2(1000) NOT NULL,
EXERCISE_DATE DATE NOT NULL,
CONTENT CLOB NOT NULL,
EXERCISE_HITS NUMBER DEFAULT 0,
CONSTRAINT FK_ID_M_EB FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_ID_E_EB FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE(EXERCISENAME)
);

--관리자 운동 시퀀스
CREATE SEQUENCE EXERCISE_SEQ NOCACHE;

--관리자 운동 게시판 이미지
CREATE TABLE EXERCISE_IMG(
EXERCISENAME VARCHAR2(100) NOT NULL,
IMGNAME VARCHAR2(300) NOT NULL,
IMGPATH VARCHAR2(1000) NOT NULL,
CONSTRAINT FK_ID_E_EI FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE_BOARD(EXERCISENAME),
PRIMARY KEY(EXERCISENAME,IMGNAME)
);

--관리자 운동 게시판 URL
CREATE TABLE EXERCISE_URL(
EXERCISENAME VARCHAR2(100) NOT NULL,
URLPATH VARCHAR2(1000) NOT NULL,
CONSTRAINT FK_ID_E_EU FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE_BOARD(EXERCISENAME)
);

--멤버 커뮤니티 게시판
CREATE TABLE MEMBER_BOARD(
MEMBER_NO NUMBER PRIMARY KEY,
MEMBERID VARCHAR2(200) NOT NULL,
TITLE VARCHAR2(1000) NOT NULL,
MEMBER_DATE DATE NOT NULL,
CONTENT CLOB NOT NULL,
MEMBER_HITS NUMBER DEFAULT 0,
RECOMMEND NUMBER DEFAULT 0,
NOTRECOMMEND NUMBER DEFAULT 0,
CONSTRAINT FK_ID_M_MB FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)--???
);

--멤버 커뮤니티 시퀀스
CREATE SEQUENCE MEMBER_SEQ NOCACHE;

--멤버 커뮤니티 게시판 답글
CREATE TABLE MEMBER_REPLY(
REPLY_NO NUMBER PRIMARY KEY,
Member_no NUMBER not null,
MEMBERID VARCHAR2(100) NOT NULL,
CONTENT CLOB NOT NULL,
REPLY_DATE DATE,
CONSTRAINT FK_ID_M_MR FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_NO_M_MR FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER_BOARD(MEMBER_NO)
);

--멤버 커뮤니티 답글 시퀀스
CREATE SEQUENCE REPLY_SEQ NOCACHE;

--멤버 커뮤니티 이미지
CREATE TABLE MEMBER_IMG(
MEMBER_NO NUMBER NOT NULL,
IMGNAME VARCHAR2(300) NOT NULL,
IMGPATH VARCHAR2(1000) NOT NULL,
CONSTRAINT FK_NO_M_MB FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER_BOARD(MEMBER_NO),
PRIMARY KEY (MEMBER_NO, IMGNAME)
);

-- 멤버 플래너
CREATE TABLE EXERCISE_PLANNER(
MEMBERID VARCHAR2(100) NOT NULL,
EXERCISENAME VARCHAR2(100) NOT NULL,
PLANNER_DATE DATE NOT NULL,
TARGETSET NUMBER NOT NULL,
ACHIEVEMENT NUMBER DEFAULT 0,
CONSTRAINT FK_ID_M_EP FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_ID_E_EP FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE(EXERCISENAME),
PRIMARY KEY(MEMBERID, EXERCISENAME, PLANNER_DATE)
);

-- 멤버 플래너 코멘트
CREATE TABLE EXERCISE_PLANNERCONTENT(
MEMBERID VARCHAR2(100) NOT NULL,
PLANNER_DATE DATE NOT NULL,
PLANNERCONTENT CLOB,
CONSTRAINT FK_ID_M_EPC FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
PRIMARY KEY(MEMBERID, PLANNER_DATE)
);

--찜하기
CREATE TABLE EXERCISE_CART(
MEMBERID VARCHAR2(100) NOT NULL,
EXERCISENAME VARCHAR2(100) NOT NULL,
CONSTRAINT FK_ID_M_EC FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_ID_E_EC FOREIGN KEY(EXERCISENAME) REFERENCES EXERCISE(EXERCISENAME),
PRIMARY KEY (MEMBERID,EXERCISENAME)
);

--추천, 비추천 기록
CREATE TABLE RECOMMEND_INFO(
MEMBER_NO NUMBER NOT NULL,
MEMBERID VARCHAR2(100) NOT NULL,
RECOMMEND varchar2(10) DEFAULT 'N'  NOT NULL,
NOTRECOMMEND varchar2(10) DEFAULT 'N'  NOT NULL,
CONSTRAINT FK_ID_M_RI FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID),
CONSTRAINT FK_NO_M_RI FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER_BOARD(MEMBER_NO),
PRIMARY KEY (MEMBER_NO,MEMBERID)
);

--검색어 랭킹
CREATE TABLE KEYWORD_STATS(
KEYWORD VARCHAR2(1000) PRIMARY KEY,
COUNT NUMBER DEFAULT 0
);


--QNA 게시판 
CREATE TABLE QNA_BOARD(
QNA_NO NUMBER PRIMARY KEY,
MEMBERID VARCHAR2(100) NOT NULL,
TITLE VARCHAR2(1000) NOT NULL,
QNA_DATE DATE NOT NULL,
CONTENT CLOB NOT NULL,
QNA_HITS NUMBER DEFAULT 0 NOT NULL,
REF NUMBER NOT NULL,
RESTEP NUMBER NOT NULL,
RELEVEL NUMBER NOT NULL,
REF_MEMBERID VARCHAR2(100) NOT NULL,
CONSTRAINT FK_ID_M_QB FOREIGN KEY(MEMBERID) REFERENCES MOMENTOR_MEMBER(MEMBERID)
);

--QNA 시퀀스
CREATE SEQUENCE QNA_SEQ NOCACHE;

--FAQ 테이블
CREATE TABLE FAQ_BOARD(
FAQ_NO NUMBER PRIMARY KEY,
TITLE VARCHAR2(1000) NOT NULL,
CONTENT CLOB NOT NULL
);

--FAQ 테이블 시퀀스
CREATE SEQUENCE FAQ_BOARD_SEQ NOCACHE;