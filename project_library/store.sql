-- fk 설정을 나중에
create table store(
l_id varchar2(100),
st_num varchar2(100) primary key,
st_title varchar2(100),
st_context varchar2(1000),
st_m_id varchar2(100),
st_pw varchar2(100),
st_date date,
constraint st_m_id_fk foreign key(st_m_id) references member(id)
);

create sequence st_num_seq;

insert into store values(
'test01_l_id', 'test01_st_num', 'test01_st_title', 
'test01_st_context', 'test01_st_m_id', 'test01_st_pw', sysdate);

insert into store values(
'test02_l_id', 'test02_st_num', 'test02_st_title', 
'test02_st_context', 'test02_st_m_id', 'test02_st_pw', sysdate);

insert into store values(
'test03_l_id', 'test03_st_num', 'test03_st_title', 
'test03_st_context', 'test03_st_m_id', 'test03_st_pw', sysdate);

insert into store values(
'test04_l_id', 'test04_st_num', 'test04_st_title', 
'test04_st_context', 'test04_st_m_id', 'test04_st_pw', sysdate);

--
insert into store values(
'test05_l_id', 'test05_st_num', 'test05_st_title', 
'test05_st_context', 'test05_st_m_id', 'test05_st_pw', sysdate);

insert into store values(
'test06_l_id', 'test06_st_num', 'test06_st_title', 
'test06_st_context', 'test06_st_m_id', 'test06_st_pw', sysdate);

insert into store values(
'test07_l_id', 'test07_st_num', 'test07_st_title', 
'test07_st_context', 'test07_st_m_id', 'test07_st_pw', sysdate);

insert into store values(
'test08_l_id', 'test08_st_num', 'test08_st_title', 
'test08_st_context', 'test08_st_m_id', 'test08_st_pw', sysdate);


insert into store values(
'test09_l_id', 'test09_st_num', 'test09_st_title', 
'test09_st_context', 'test09_st_m_id', 'test09_st_pw', sysdate);

insert into store values(
'test10_l_id', 'test10_st_num', 'test10_st_title', 
'test10_st_context', 'test10_st_m_id', 'test10_st_pw', sysdate);

insert into store values(
'test11_l_id', 'test11_st_num', 'test11_st_title', 
'test11_st_context', 'test11_st_m_id', 'test11_st_pw', sysdate);

insert into store values(
'test12_l_id', 'test12_st_num', 'test12_st_title', 
'test12_st_context', 'test12_st_m_id', 'test12_st_pw', sysdate);


drop table member_store;
drop table store;