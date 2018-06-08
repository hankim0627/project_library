alter table member modify(id varchar2(100));

insert into member values('test01_st_m_id', 1234, 'test01', 'test01@naver.com','010-1234-5678');
insert into member values('test02_st_m_id', 1234, 'test02', 'test02@naver.com','010-1234-5678');
insert into member values('test03_st_m_id', 1234, 'test03', 'test03@naver.com','010-1234-5678');
insert into member values('test04_st_m_id', 1234, 'test04', 'test04@naver.com','010-1234-5678');
insert into member values('test05_st_m_id', 1234, 'test05', 'test05@naver.com','010-1234-5678');

insert into member values('test06_st_m_id', 1234, 'test06', 'test06@naver.com','010-1234-5678');
insert into member values('test07_st_m_id', 1234, 'test07', 'test07@naver.com','010-1234-5678');
insert into member values('test08_st_m_id', 1234, 'test08', 'test08@naver.com','010-1234-5678');
insert into member values('test09_st_m_id', 1234, 'test09', 'test09@naver.com','010-1234-5678');
insert into member values('test10_st_m_id', 1234, 'test10', 'test10@naver.com','010-1234-5678');

insert into member values('test11_st_m_id', 1234, 'test11', 'test11@naver.com','010-1234-5678');
insert into member values('test12_st_m_id', 1234, 'test12', 'test12@naver.com','010-1234-5678');

create table member_store(
ms_m_id varchar2(100) references member(id),
ms_st_num varchar2(100) references store(st_num),
flag number(2)
)
-- flag : 0 : 거래대기
-- flag : 1 : 거래완료

select * from member_store;
SELECT DISTINCT MS_ST_NUM, FLAG, MS_M_ID, SEND_ID FROM MEMBER_STORE;

---------------------------------------
create table store_comment(
c_st_num varchar2(100) references store(st_num),
c_m_id varchar2(100),
c_content varchar2(1000)
)

insert into store_comment values('test01_st_num','test01_st_m_id','HI');
insert into store_comment values('test01_st_num','test01_st_m_id','BYE');
----------------------------------------

SELECT DISTINCT MS_ST_NUM, FLAG, MS_M_ID FROM MEMBER_STORE;

--member_store에 거래신청한 사람들 컬럼 추가
alter table member_store add (send_id varchar2(100) references member(id));

select st.* from
(select rownum as r, store.* from store) st
where st.r <= 1*5 and
st.st_title like '%'||'test'||'%'

select * from store
where st_title like '%'||'test'||'%'

select rownum as r, store.* from store
where st_title like '%'||'test'||'%'