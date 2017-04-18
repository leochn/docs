# linux下MySQL表名不区分大小写的设置方法

<!-- toc -->

原来Linux下的MySQL默认是区分表名大小写的，通过如下设置，可以让MySQL不区分表名大小写：
```
1、用root登录，修改 /etc/my.cnf；
2、在[mysqld]节点下，加入一行： lower_case_table_names=1
3、重启MySQL即可；
其中 lower_case_table_names=1 参数缺省地在 Windows 中这个选项为 1 ，
在 Unix 中为 0，因此在window中不会遇到的问题，一旦一直到linux就会出问题的原因.
（尤其在mysql对表起名时是无法用大写字母的，而查询用了大写字母却会出查不到的错误，真是弄的莫名其妙）
```



