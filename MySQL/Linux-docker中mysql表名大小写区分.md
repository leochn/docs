# Linux(docker)中mysql表名大小写区分.md

<!-- toc -->

## 问题:
在Docker中使用MySQL，通过sql文件导入数据库的时候，创建的表名都是大写字母，而程序中都是用的小写，碰到了下面这种错误：
```
mysql> select * from task_schedule_job;
ERROR 1146 (42S02): Table 'ucenter.task_schedule_job' doesn't exist
```

在网上查到Linux系统中mysql区分大小写
```
mysql> show variables like '%low%';
\+----------------------------+--------------------------------------+
| Variable_name              | Value                                |
+----------------------------+--------------------------------------+
| log_slow_admin_statements  | OFF                                  |
| log_slow_slave_statements  | OFF                                  |
| low_priority_updates       | OFF                                  |
| lower_case_file_system     | OFF                                  |
| lower_case_table_names     | 0                                    |
| max_allowed_packet         | 4194304                              |
| slave_allow_batching       | OFF                                  |
| slave_max_allowed_packet   | 1073741824                           |
| slow_launch_time           | 2                                    |
| slow_query_log             | OFF                                  |
| slow_query_log_file        | /var/lib/mysql/6a38e59ef95d-slow.log |
| transaction_allow_batching | OFF                                  |
+----------------------------+--------------------------------------+
12 rows in set (0.01 sec)
```

```
其中 lower_case_table_names 的值是 0 
0 代表区分大小写 
1 代表不区分大小写 
（在windows中1 表示不区分大小写 2表示区分大小写）
```

## 解决： 
```
在配置文件的[mysqld]后添加lower_case_table_names=1 
Linux中的配置文件应该是在 /etc/mysql/my.cnf
我用的mysql的官方docker镜像，在 /etc/mysql/mysql.conf.d/mysqld.cnf
```

```bash
root@d1616077a255:/etc/mysql/mysql.conf.d# cat mysqld.cnf 
# Copyright (c) 2014, 2016, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

#
# The MySQL  Server configuration file.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
#log-error      = /var/log/mysql/error.log
# By default we only accept connections from localhost
#bind-address   = 127.0.0.1
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
root@d1616077a255:/etc/mysql/mysql.conf.d#
```

* mysql镜像用的Debian 系统，没有安装vi、vim，安装vim

```bash
root@d1616077a255:/etc/mysql/mysql.conf.d# cat /proc/version 
Linux version 3.10.0-514.10.2.el7.x86_64 (builder@kbuilder.dev.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Fri Mar 3 00:04:05 UTC 2017
root@d1616077a255:/etc/mysql/mysql.conf.d# apt-get update
Get:1 http://security.debian.org jessie/updates InRelease [63.1 kB]                                 
Get:2 http://repo.mysql.com jessie InRelease [26.4 kB]                                                                              
Get:3 http://security.debian.org jessie/updates/main amd64 Packages [464 kB]
Get:4 http://repo.mysql.com jessie/mysql-5.7 amd64 Packages [2828 B]                                  
Ign http://deb.debian.org jessie InRelease                                                                                              
Get:5 http://deb.debian.org jessie-updates InRelease [145 kB]                                                                           
Get:6 http://deb.debian.org jessie Release.gpg [2373 B]                                                                                 
Get:7 http://deb.debian.org jessie Release [148 kB]                                                                                     
Get:8 http://deb.debian.org jessie-updates/main amd64 Packages [17.6 kB]                                                                
Get:9 http://deb.debian.org jessie/main amd64 Packages [9049 kB]                                                                        
Fetched 9918 kB in 5min 3s (32.7 kB/s)                                                                                                  
Reading package lists... Done
root@d1616077a255:/etc/mysql/mysql.conf.d#
```

```
root@d1616077a255:/etc/mysql/mysql.conf.d# apt-get install vim
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following extra packages will be installed:
  libgpm2 vim-common vim-runtime
Suggested packages:
  gpm ctags vim-doc vim-scripts
The following NEW packages will be installed:
  libgpm2 vim vim-common vim-runtime
0 upgraded, 4 newly installed, 0 to remove and 0 not upgraded.
Need to get 6217 kB of archives.
After this operation, 28.9 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://security.debian.org/ jessie/updates/main vim-common amd64 2:7.4.488-7+deb8u2 [185 kB]
Get:2 http://security.debian.org/ jessie/updates/main vim-runtime all 2:7.4.488-7+deb8u2 [5046 kB]
Get:3 http://deb.debian.org/debian/ jessie/main libgpm2 amd64 1.20.4-6.1+b2 [34.0 kB]                                                   
Get:4 http://security.debian.org/ jessie/updates/main vim amd64 2:7.4.488-7+deb8u2 [953 kB]                                             
Fetched 6217 kB in 58s (107 kB/s)                                                                                                       
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libgpm2:amd64.
(Reading database ... 9215 files and directories currently installed.)
Preparing to unpack .../libgpm2_1.20.4-6.1+b2_amd64.deb ...
Unpacking libgpm2:amd64 (1.20.4-6.1+b2) ...
Selecting previously unselected package vim-common.
Preparing to unpack .../vim-common_2%3a7.4.488-7+deb8u2_amd64.deb ...
Unpacking vim-common (2:7.4.488-7+deb8u2) ...
Selecting previously unselected package vim-runtime.
Preparing to unpack .../vim-runtime_2%3a7.4.488-7+deb8u2_all.deb ...
Adding 'diversion of /usr/share/vim/vim74/doc/help.txt to /usr/share/vim/vim74/doc/help.txt.vim-tiny by vim-runtime'
Adding 'diversion of /usr/share/vim/vim74/doc/tags to /usr/share/vim/vim74/doc/tags.vim-tiny by vim-runtime'
Unpacking vim-runtime (2:7.4.488-7+deb8u2) ...
Selecting previously unselected package vim.
Preparing to unpack .../vim_2%3a7.4.488-7+deb8u2_amd64.deb ...
Unpacking vim (2:7.4.488-7+deb8u2) ...
Setting up libgpm2:amd64 (1.20.4-6.1+b2) ...
Setting up vim-common (2:7.4.488-7+deb8u2) ...
Setting up vim-runtime (2:7.4.488-7+deb8u2) ...
Processing /usr/share/vim/addons/doc
Setting up vim (2:7.4.488-7+deb8u2) ...
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/vim (vim) in auto mode
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/vimdiff (vimdiff) in auto mode
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/rvim (rvim) in auto mode
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/rview (rview) in auto mode
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/vi (vi) in auto mode
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/view (view) in auto mode
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/ex (ex) in auto mode
update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/editor (editor) in auto mode
Processing triggers for libc-bin (2.19-18+deb8u7) ...
root@d1616077a255:/etc/mysql/mysql.conf.d#
```

* 修改保存之后重启mysql服务，不过关闭了mysql容器也跟着关闭了如下

```bash
root@d1616077a255:/etc/mysql/mysql.conf.d# vim mysqld.cnf 
root@d1616077a255:/etc/mysql/mysql.conf.d# service mysql restart
[info] Stopping MySQL Community Server 5.7.18.
....
[info] MySQL Community Server 5.7.18 is stopped.
[info] Re-starting MySQL Community Server 5.7.18.
[proy@yserver ~]$
```

* 启动容器，进入容器
```
[proy@yserver ~]$ docker start d1616077a255
[proy@yserver ~]$ docker exec -i -t d1616077a255 /bin/bash
root@d1616077a255:/# 
```
* 这时lower_case_table_names 的值 已经改成了1
```
mysql> show variables like '%low%';
\+----------------------------+--------------------------------------+
| Variable_name              | Value                                |
+----------------------------+--------------------------------------+
| log_slow_admin_statements  | OFF                                  |
| log_slow_slave_statements  | OFF                                  |
| low_priority_updates       | OFF                                  |
| lower_case_file_system     | OFF                                  |
| lower_case_table_names     | 1                                    |
| max_allowed_packet         | 4194304                              |
| slave_allow_batching       | OFF                                  |
| slave_max_allowed_packet   | 1073741824                           |
| slow_launch_time           | 2                                    |
| slow_query_log             | OFF                                  |
| slow_query_log_file        | /var/lib/mysql/6a38e59ef95d-slow.log |
| transaction_allow_batching | OFF                                  |
+----------------------------+--------------------------------------+
12 rows in set (0.01 sec)
```

## 其他
* 但是还是有问题
```
mysql> select * from task_schedule_job ;
ERROR 1146 (42S02): Table 'ucenter.task_schedule_job' doesn't exist
```

* 删除之前的数据库,出现ERROR 1010 (HY000)错误
```
mysql> drop database ucenter;
ERROR 1010 (HY000): Error dropping database (can't rmdir './ucenter', errno: 39)
mysql> select @@datadir;
+-----------------+
| @@datadir       |
+-----------------+
| /var/lib/mysql/ |
+-----------------+
1 row in set (0.00 sec)
```

* 直接查询数据文件目录，删除数据文件
```
root@6a38e59ef95d:/# cd /var/lib/mysql
root@6a38e59ef95d:/var/lib/mysql# rm -r -f ucenter
重新建立数据库，执行sql文件，导入的表名都变成了小写
```

