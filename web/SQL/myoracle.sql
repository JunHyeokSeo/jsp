-- member1 table 생성
create  table  member1( id varchar2(20) primary key,
                        passwd varchar2(20) not null,
                        name varchar2(20) not null,
                        reg_date timestamp not null );
commit;