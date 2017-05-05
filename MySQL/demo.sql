  create table PERSON (
    XH int, 
    XM varchar(50)
  );

   insert into PERSON values(1, 'A');
   insert into PERSON values(2, 'B');
   insert into PERSON values(3, 'C');
   insert into PERSON values(4, 'D');
   commit;
   
   create table ADDRESS (XH int, ZZ varchar(50));
   
   insert into ADDRESS values(2, '北京');
   insert into ADDRESS values(1, '广州');
   insert into ADDRESS values(3, '上海');
   insert into ADDRESS values(4, '西安');
   commit;
   select * from PERSON;
   select * from ADDRESS;
   alter table PERSON add ZZ varchar(50);
   
   
  select * from PERSON   
   
  insert into PERSON(XH,XM) values(5, 'E');
  insert into PERSON(XH,XM) values(6, 'F');
  
  insert into PERSON(XH,XM) values(1, '1A');
  insert into PERSON(XH,XM) values(2, '2B');
  insert into PERSON(XH,XM) values(1, '1AA');
  insert into PERSON(XH,XM) values(3, '1AB');
  
#### 
   
###
update PERSON P set P.ZZ = (select A.ZZ from ADDRESS A where A.XH = P.XH);

##### 也可以通过下面游标的方式进行修改
## 测试存储过程和游标的使用
drop procedure if exists useCursor ;  
delimiter //  
create procedure useCursor()  
  begin  
    declare V_XH int default '';  
    declare V_ZZ varchar(50) default ''; 
    declare curl cursor for select XH as V_XH, ZZ as V_ZZ from ADDRESS;    
    open curl;  
    loop
        fetch curl into V_XH, V_ZZ;
        update person set ZZ=V_ZZ where XH = V_XH;  
    end loop;  
    close curl;   
  end;// 
# 调用存储过程  
call useCursor();   

update person set ZZ ='(广州)1A' where XM = 'A';
update person set ZZ ='(广州)11AA' where XM = '1A';
update person set ZZ ='(广州)111AAA' where XM = '1AA';

### 把 (广州) 字符去掉
select * from person where ZZ like "%(广州)%";

### 然后把每行的

##  注意:索引从1开始数;含当前索引
select substring('ADabcdefghijklmn',2);  ## Dabcdefghijklmn

set @order1=substring('ADabcdefghijklmn',2);

drop procedure if exists useCursor ;  
delimiter // 
create procedure useCursor()  
  begin  
    declare V_ZZZ varchar(50) default ''; 
    declare V_ZZ varchar(50) default ''; 
    declare curl cursor for select ZZ as V_ZZ from person where ZZ like "%(广州)%";  
    open curl;  
    loop
        fetch curl into V_ZZ;
        set V_ZZZ = substring(V_ZZ,5);
        update person set ZZ=V_ZZZ where ZZ = V_ZZ;    
    end loop;  
    close curl;   
  end;// 
# 调用存储过程  
call useCursor();  


## 调用存储过程后，会出现如下错误：
# 错误码: 1329
# No data - zero rows fetched, selected, or processed



























































