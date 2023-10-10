create table member(
                       id varchar2(20) primary key,
                       passwd varchar2(20) not null,
                       name varchar2(20) not null,
                       jumin1 varchar2(6) not null,
                       jumin2 varchar2(7) not null,
                       mailid varchar2(30),
                       domain varchar2(30),
                       tel1 varchar2(5),
                       tel2 varchar2(5),
                       tel3 varchar2(5),
                       phone1 varchar2(5),
                       phone2 varchar2(5),
                       phone3 varchar2(5),
                       post varchar2(10),
                       address varchar2(200),
                       gender varchar2(20),
                       hobby varchar2(50),
                       intro varchar2(2000),
                       register timestamp );


create table board(
                      num number primary key,
                      writer varchar2(20) not null,
                      email varchar2(30),
                      subject varchar2(50) not null,
                      passwd varchar2(20) not null,
                      reg_date timestamp not null,
                      readcount number default 0,
                      content varchar2(2000) not null,
                      ip varchar2(20) not null );

create sequence board_seq
    start with 1
    increment by 1
    nocache;

-- insert into TOTORO.BOARD values (BOARD_SEQ.nextval, 'jun', 'sjhgd107@naver.com', 'introduce', 'pass', sysdate, 0, 'hi', '172.30.1.60');

select * from tab;
select * from seq;
select * from board;

-- select * from (select * from TOTORO.BOARD ORDER BY NUM asc) where ROWNUM between 1 and 10;
-- select * from (select ROWNUM rnum, board.* from (select * from TOTORO.BOARD order by NUM desc) board) where rnum between 10 and 20;

commit;