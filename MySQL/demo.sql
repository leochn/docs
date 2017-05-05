	create table PERSON (
	  XH int, 
	  XM varchar(10)
	);

   insert into PERSON values(1, 'A');
   insert into PERSON values(2, 'B');
   insert into PERSON values(3, 'C');
   insert into PERSON values(4, 'D');
   commit;
   
   create table ADDRESS (XH int, ZZ varchar(20));
   
   insert into ADDRESS values(2, '北京');
   insert into ADDRESS values(1, '广州');
   insert into ADDRESS values(3, '上海');
   insert into ADDRESS values(4, '西安');
   commit;
   select * from PERSON;
   select * from ADDRESS;
   alter table PERSON add ZZ char(10);
   
   
  select * from PERSON   
   
  insert into PERSON(XH,XM) values(5, 'E');
  insert into PERSON(XH,XM) values(6, 'F');
  
  insert into PERSON(XH,XM) values(1, '1A');
  insert into PERSON(XH,XM) values(2, '2B');
  insert into PERSON(XH,XM) values(1, '1AA');
  insert into PERSON(XH,XM) values(3, '1AB');
  
 #### 
declare 
   V_XH int;
   V_ZZ varchar(10);
   cursor MYCURSOR 
   is
   select XH, ZZ from ADDRESS;
begin
   open MYCURSOR;
   loop
        fetch MYCURSOR into V_XH, V_ZZ;
        exit when MYCURSOR%NOTFOUND;
        update PERSON set ZZ = V_ZZ where XH = V_XH;
   end loop;
   close MYCURSOR;
end; 
   
###
update PERSON P set P.ZZ = (select A.ZZ from ADDRESS A where A.XH = P.XH);

# 通过游标来操作，把上海的改为上海AA

delimiter
declare 
   MYCURSOR03 cursor 
   for
   select XH, ZZ from ADDRESS;
begin
   open MYCURSOR03;
   loop
        fetch MYCURSOR03 into XH, ZZ;
        # exit when MYCURSOR01%NOTFOUND;
        # update PERSON set ZZ = V_ZZ where XH = V_XH;
        select * from PERSON;
   end loop;
   close MYCURSOR03;
end; 



drop procedure if exists useCursor ;  
delimiter //  
create procedure useCursor()  
  begin  
    declare V_XH int default '';  
    declare V_ZZ varchar(10) default ''; 
    declare curl cursor for select XH as V_XH, ZZ as V_ZZ from ADDRESS;    
    open curl;  
    loop
        fetch curl into V_XH, V_ZZ;
        # fetch curl into XH, ZZ;
        # update PERSON set ZZ = V_ZZ where XH = V_XH;
        # select now();   
    end loop;  
    close curl;   
    select V_XH;
  end;// 
  
call useCursor();   




























