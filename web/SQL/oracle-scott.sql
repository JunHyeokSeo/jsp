-- member1 table 생성
create  table  member1( id varchar2(20) primary key,
                        passwd varchar2(20) not null,
                        name varchar2(20) not null,
                        reg_date timestamp not null );

create  table  member2(
                          id varchar2(12) primary key,
                          passwd varchar2(12) not null,
                          name varchar2(10) not null,
                          jumin1 varchar2(6) not null,
                          jumin2 varchar2(7) not null,
                          email varchar2(30),
                          blog varchar2(50),
                          reg_date date not null);

commit;