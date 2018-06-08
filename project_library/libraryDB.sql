create table STUDYROOM (
	sr_num		number(20)		primary key,
	sr_title	varchar2(100),
	l_id		number(20)	not null references library(l_id),
	sr_content	varchar2(100),
	m_id		varchar2(100)	not null references l_member(m_id),
	sr_pw		varchar2(100),
	sr_date		date,
	sr_cate		varchar2(30),
	sr_view_num	number(20)
);

create table sr_comment (
	sr_num 					number(20)		not null references studyroom(sr_num),
	sr_comment_num			number(20)		primary key,
	sr_comment_id 			varchar2(100),
	sr_comment_date			date,		
	sr_comment_content		varchar2(100),
	sr_recomment_flag		number(2)		
);
recoment일 경우에는 sr_comment_num/ 그냥 댓글의 경우에는 0
select * from sr_comment;
alter table sr_comment add (sr_recomment_flag number(2) default -1);

update sr_comment set sr_recomment_flag=1 where sr_num=29 and sr_comment_num=3;

alter table sr_comment drop column sr_comment_recomment;
alter table sr_recomment add (sr_num number(20) not null references studyroom(sr_num));

create table sr_recomment (
	sr_num 						number(20)	not null references studyroom(sr_num),
	sr_comment_num				number(20)	not null references sr_comment(sr_comment_num),
	sr_recomment_num			number(20)	primary key,
	sr_recomment_id 			varchar2(100),
	sr_recomment_date			date,
	sr_recomment_content		varchar2(100)
);
drop table sr_recomment;

select * from sr_comment;
select * from sr_comment where sr_num=29 order by sr_comment_date asc;

select *  
from (
	select rownum r, imsi_t.*   
	from (
		select * from sr_comment where sr_num=29 order by sr_comment_date asc
	) imsi_t
	)
where r between 1 and 20;

		
desc sr_comment;

create table library (
	l_id varchar2(100) primary key

);

alter table studyroom modify sr_cate varchar2(30);

create table l_member(
	m_id	varchar2(100) primary key
);

drop table studyroom;

alter table studyroom modify sr_cate number(20);

select * from studyroom;

delete from studyroom where sr_num=0;
delete from library where l_id='0';

alter table library modify (l_id number(20));

delete from studyroom  where sr_view_num=0;

insert into STUDYROOM values (0,'스터딩',0,'구함','yhg1yhg1','qwe123',sysdate,'중학생',0);
insert into STUDYROOM values (1,'스터딩1',0,'구함1','yhg1yhg1','qwe123',sysdate,'중학생',0);
insert into STUDYROOM values (2,'스터딩2',0,'구함2','yhg1yhg1','qwe123',sysdate,'고등학생',0);
insert into STUDYROOM values (3,'스터딩3',0,'구함3','yhg1yhg1','qwe123',sysdate,'대학생',0);
insert into STUDYROOM values (4,'스터딩4',0,'구함4','yhg1yhg1','qwe123',sysdate,'고등학생',0);
insert into STUDYROOM values (5,'스터딩5',0,'구함5','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (6,'스터딩6',0,'구함6','yhg1yhg1','qwe123',sysdate,'직장인',0);
insert into STUDYROOM values (7,'스터딩7',0,'구함7','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (8,'스터딩8',0,'구함8','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (9,'스터딩9',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (10,'스터딩10',0,'구함10','yhg1yhg1','qwe123',sysdate,'기타',0);
insert into STUDYROOM values (11,'스터딩11',0,'구함11','yhg1yhg1','qwe123',sysdate,'기타',0);
insert into STUDYROOM values (12,'스터딩12',0,'구함12','yhg1yhg1','qwe123',sysdate,'고등학생',0);
insert into STUDYROOM values (13,'스터딩13',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (14,'스터딩14',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (15,'스터딩15',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (16,'스터딩16',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (17,'스터딩17',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (18,'스터18',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (19,'스터딩19',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (20,'스터딩20',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (21,'스터딩21',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);
insert into STUDYROOM values (22,'스터딩22',0,'구함9','yhg1yhg1','qwe123',sysdate,'취업준비생',0);


select sr_num, sr_cate, sr_title, m_name, sr_date, sr_view_num from l_member m, studyroom s where s.m_id=m.m_id;

select count(*) from studyroom where sr_title like '%스터딩%' and sr_cate=1 and (to_date(to_char(sysdate, 'YY/MM/DD'))-to_date(sr_date)) between 0 and 1;
select * from studyroom where sr_title like '%스터딩%' and sr_cate=1 and (to_date(to_char(sysdate, 'YY/MM/DD'))-to_date(sr_date)) between 0 and 1;


		select l_id, sr_num, sr_title, m_name, sr_date, sr_cate, sr_view_num 
		from (select rownum r, imsi_t.* 
			from (select l_id, sr_num, sr_cate, sr_title, m_name, sr_date, sr_view_num 
					from l_member m, studyroom s 
					where s.m_id=m.m_id and l_id like 0 and sr_title like '%스터%' and sr_cate=3 and (to_date(to_char(sysdate, 'YY/MM/DD'))-to_date(sr_date)) between 0 and 1
					order by sr_date desc) imsi_t) 
		where r between 1 and 2 


		select l_id, sr_num, sr_title, m_name, sr_date, sr_cate, sr_view_num 
		from (select rownum r, imsi_t.* 
			from (select l_id, sr_num, sr_cate, sr_title, m_name, sr_date, sr_view_num 
					from l_member m, studyroom s 
					where s.m_id=m.m_id and l_id like 0 and sr_title like '%스터%' and (to_date(to_char(sysdate, 'YY/MM/DD'))-to_date(sr_date)) between 0 and 1
					order by sr_date desc) imsi_t) 
		where r between 1 and 2 

		select l_id, sr_num, sr_title, m_name, sr_date, sr_cate, sr_view_num 
		from (select rownum r, imsi_t.* 
			from (select l_id, sr_num, sr_cate, sr_title, m_name, sr_date, sr_view_num 
					from l_member m, studyroom s 
					where s.m_id=m.m_id and l_id like 0 and sr_cate=3 and (to_date(to_char(sysdate, 'YY/MM/DD'))-to_date(sr_date)) between 0 and 1
					order by sr_date desc) imsi_t) 
		where r between 1 and 2 
		
		select l_id, sr_num, sr_title, m_name, sr_date, sr_cate, sr_view_num 
		from (select rownum r, imsi_t.* 
			from (select l_id, sr_num, sr_cate, sr_title, m_name, sr_date, sr_view_num 
					from l_member m, studyroom s 
					where s.m_id=m.m_id and l_id=0 and (to_date(to_char(sysdate, 'YY/MM/DD'))-to_date(sr_date)) between 0 and 1
					order by sr_date desc) imsi_t) 
		where r between 1 and 2 and m_name like '%희%'
		

select sr_num, sr_cate, sr_title, m_name, sr_date, sr_view_num 
		from (select rownum r, imsi_t.* 
			from (select sr_num, sr_cate, sr_title, m_name, sr_date, sr_view_num 
					from l_member m, studyroom s 
					where s.m_id=m.m_id and l_id like '0'
					order by sr_date desc) imsi_t) 
		where r between 1 and 10
		
	
		
		
		
		