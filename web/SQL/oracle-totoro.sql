-- member
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

-- board
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

select * from tab;
select * from seq;
select * from board;

select * from (select ROWNUM rnum, board.* from (select * from TOTORO.BOARD order by NUM desc) board) where rnum between 10 and 20;
-- select * from (select * from TOTORO.BOARD ORDER BY NUM desc) offset 9 row fetch next 10 rows only;
-- offset : startRow - 1
-- next : endRow - startRow

-- reBoard
create table reboard( num number primary key,
                      writer varchar2(20) not null,
                      email varchar2(30),
                      subject varchar2(50) not null,
                      passwd varchar2(20) not null,
                      reg_date timestamp not null,
                      readcount number default 0,
                      ref number not null,
                      re_step number not null,
                      re_level number not null,
                      content varchar2(2000) not null,
                      ip varchar2(20) not null );
create sequence reboard_seq
    start with 1
    increment by 1
    nocache;

commit;

select num, subject, ref, re_level, re_step from reboard;

-- upload-board
create table upload( num number primary key,
                     writer varchar2(20) not null,
                     email varchar2(30),
                     subject varchar2(50) not null,
                     passwd varchar2(20) not null,
                     reg_date timestamp not null,
                     readcount number default 0,
                     content varchar2(2000) not null,
                     ip varchar2(20) not null,
                     upload varchar2(30) ); --첨부파일명
create sequence upload_seq
    start with 1
    increment by 1
    nocache;