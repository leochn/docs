# mysql游标

<!-- toc -->

## 一，什么是游标(cursor)
```
个人觉得就是一个cursor,就是一个标识，用来标识数据取到什么地方了。你也可以把它理解成数组中的下标。
```
## 二，游标(cursor)的特性
```
1,只读的，不能更新的。
2,不滚动的
3,不敏感的，不敏感意为服务器可以活不可以复制它的结果表
游标(cursor)必须在声明处理程序之前被声明，并且变量和条件必须在声明游标或处理程序之前被声明。
```
## 三，使用游标(cursor)
```
1.声明游标
DECLARE cursor_name CURSOR FOR select_statement
这个语句声明一个游标。也可以在子程序中定义多个游标，但是一个块中的每一个游标必须有唯一的名字。声明游标后也是单条操作的，但是不能用SELECT语句不能有INTO子句。
2. 游标OPEN语句
OPEN cursor_name
这个语句打开先前声明的游标。
3. 游标FETCH语句
FETCH cursor_name INTO var_name [, var_name] ...
这个语句用指定的打开游标读取下一行（如果有下一行的话），并且前进游标指针。
4. 游标CLOSE语句
CLOSE cursor_name
这个语句关闭先前打开的游标。
```
## 四，应用举例