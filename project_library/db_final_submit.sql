create table library(
l_id number(10) primary key,
l_name varchar2(100),
l_location varchar2(1000),
l_holiday varchar2(100),
l_time varchar2(200),
l_phone varchar2(200),
l_website varchar2(400),
l_latitude number(10,6),       --위도
l_longtitude number(10,6)      --경도 
);


insert into library values(0001, '중구구립도서관', '서울특별시 중구 동호로 14길 18', '365일 연중무휴', '09:00-18:00', '02)2280-8470', 'https://www.e-junggu.or.kr/new/', 37.556618, 127.010869);

insert into library values(0002, '논현도서관', '서울특별시 강남구 학동로43길 17 (논현2문화센터 6층)', '"둘째(넷째)화요일,일요일을 제외한법정공휴일"', '06:00-22:00', '02-3443-7650', 'http://library.gangnam.go.kr/', 37.5172779093, 127.037187914);

insert into library values(0003, '금천구립가산도서관', '서울특별시 금천구 가산로5길 43', '매월 둘째,넷째 월요일/법정 공휴일', '07:00-22:00', '02-865-6817', 'http://geumcheonlib.seoul.kr', 37.456797, 126.895396);

insert into library values(0004, '관악문화관도서관', '서울특별시 관악구 신림로3길 35(신림동)', '매주 화요일/국가지정공휴일', '09:00-22:00', '02-828-5700', 'http://lib.gwanak.go.kr/', 37.467135, 126.944735);

create table member(
l_id  number(10) constraint mem_l_id_fk references library(l_id),
m_id varchar2(50) primary key,
m_pw varchar2(50),
m_phone varchar2(50),
m_name varchar2(100),
m_pic varchar2(30)    --회원 아바타
);

insert into member values(0001, 'dohye777', '123456', '010-222-8555', '김도혜', 'no image');

select m_id from member where l_id = '0001' and m_id = 'dohye77'
select * from member;


create table store(
l_id number(10)  constraint st_l_id_fk references library(l_id),
st_num varchar2(100) primary key,
st_title varchar2(100),
st_context varchar2(1000),
st_m_id varchar2(50),
st_pw varchar2(100),
st_date date,
constraint st_m_id_fk foreign key(st_m_id) references member(m_id)
);


create sequence st_num_seq;

create table member_store(
ms_m_id varchar2(50) constraint ms_m_id_fk references member(m_id),
ms_st_num varchar2(100) constraint ms_st_num_fk references store(st_num),
send_id varchar2(50) constraint ms_send_m_id_fk references member(m_id),
flag number(2)
)

create table store_comment(
c_st_num varchar2(100) constraint stcom_st_num_fk references store(st_num),
c_m_id varchar2(50),
c_content varchar2(1000)
)

create table free(
l_Id number(10) constraint fr_l_id_fk references library(l_id),
f_Title varchar2(20),
f_Content varchar2(100),
f_m_Id varchar2(50) constraint fr_m_id_fk references member(m_id),
f_Pw varchar2(20),
f_Date date,
f_Num number(20) primary key
);

create table freereply(
fr_num Number(10) primary key,
fr_free_num Number(20) constraint frrep_f_num_fk references free(f_num),
fr_m_Id varchar2(50) constraint frrep_m_id_fk references member(m_id),
fr_content varchar2(1000),
m_Pic varchar2(30),
fr_Pw varchar2(30)
);


create sequence sr_eb_num;
create sequence sr_num;
create sequence sr_comment_num;
create sequence sr_recomment_num;
create sequence sr_eb_comment_num;
create sequence sr_eb_recomment_num;

create table STUDYROOM (
	sr_num		number(20)		primary key,
	sr_title	varchar2(100),
	l_id		number(10)	not null references library(l_id),
	sr_content	varchar2(1000),
	m_id		varchar2(50)	not null references member(m_id),
	sr_pw		varchar2(100),
	sr_date		date,
	sr_cate		varchar2(30),
	sr_view_num	number(20)
);

create table studyroomJoinList(
	l_id		number(10)	not null references library(l_id),
	sr_num		number(20)	not null references studyroom(sr_num),
	m_id		varchar2(50)	not null references member(m_id),
	sr_join_flag number(2)	not null,			
	sr_join_content varchar2(500)
)

create table sr_comment (
 sr_num  number(20) constraint srcom_m_id_fk references studyroom(sr_num),
 sr_comment_num number(20)  primary key,
 sr_comment_id  varchar2(100),
 sr_comment_date  date,      
 sr_comment_content  varchar2(100),
 sr_recomment_flag  number(2)      
);

create table sr_recomment (
   sr_num                   number(20)   constraint srrecom_sr_num_fk references studyroom(sr_num),
   sr_comment_num            number(20)  constraint srrecom_sr_com_fk references sr_comment(sr_comment_num),
   sr_recomment_num         number(20)   primary key,
   sr_comment_id          varchar2(100),
   sr_comment_date         date,
   sr_comment_content      varchar2(100)
);


create table sr_eb_comment (
	sr_eb_num				number(20)		not null references studyroomeachboard(sr_eb_num),
	sr_num 					number(20)		not null references studyroom(sr_num),
	sr_comment_num			number(20)		primary key,
	sr_comment_id 			varchar2(100),
	sr_comment_date			date,
	sr_comment_content		varchar2(100),
	sr_recomment_flag  number(2)  
);

create table sr_eb_recomment (
	sr_eb_num					number(20)	not null references studyroomeachboard(sr_eb_num),
	sr_num 						number(20)	not null references studyroom(sr_num),
	sr_comment_num				number(20)	not null references sr_eb_comment(sr_comment_num),
	sr_recomment_num			number(20)	primary key,
	sr_comment_id 			varchar2(100),
	sr_comment_date			date,
	sr_comment_content		varchar2(100)
);

create table studyroomeachBoard(
	sr_eb_num 	number(20)	 primary key,				스터디룸 게시판 글 번호
	sr_num		number(20)		not null references studyroom(sr_num),
	sr_title	varchar2(100),
	l_id		number(10)	not null references library(l_id),
	sr_content	varchar2(100),
	m_id		varchar2(50)	not null references member(m_id),
	sr_pw		varchar2(100),
	sr_date		date,
	sr_cate		varchar2(30),
	sr_view_num	number(20),
	sr_file_name1 varchar2(100),	
	sr_file_name2 varchar2(100),
	sr_file_name3 varchar2(100)
);










