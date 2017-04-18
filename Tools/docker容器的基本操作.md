# Docker--容器的基本操作

<!-- toc -->

## 容器的基本操作
* docker加速器
```
登陆后运行 curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://d6ca0116.m.daocloud.io 
此命令会帮助您配置 registry-mirror 。
在配置完成后，请根据终端中的提示重启 docker，以使配置生效。
```
```bash
[root@localhost ~]# curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://d6ca0116.m.daocloud.io
docker version >= 1.12
{"registry-mirrors": ["http://d6ca0116.m.daocloud.io"],
        "insecure-registries":[
                "0.0.0.0/0"
        ]
}
Success.
You need to restart docker to take effect: sudo systemctl restart docker 
[root@localhost ~]# service docker restart
Redirecting to /bin/systemctl restart  docker.service
[root@localhost ~]#
[root@localhost /]# cd /etc/docker/
[root@localhost docker]# ll
总用量 12
-rw-r--r-- 1 root root 100 4月  14 12:29 daemon.json
-rw-r--r-- 1 root root  46 4月  14 12:29 daemon.json.bak
-rw------- 1 root root 281 2月  19 14:56 key.json
-rw------- 1 root root 281 2月  19 14:56 key.json
[root@localhost docker]# cat daemon.json
{"registry-mirrors": ["http://d6ca0116.m.daocloud.io"],
        "insecure-registries":[
                "0.0.0.0/0"
        ]
}
[root@localhost docker]#
```
* 启动容器
```bash
$ docker run image_name echo "hello word"
[root@localhost /]# docker run centos echo "hello world"
hello world
[root@localhost /]#
//在输出成功的同时，启动的容器实际上也已经停止了。
```

* 启动交互式容器
``` bash
docker run -i -t centos /bin/bash // 容器启动时执行bash命令
[root@localhost ~]# docker run -i -t centos /bin/bash                    
[root@0737724188ef /]# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  1 12:10 ?        00:00:00 /bin/bash
root        13     1  0 12:10 ?        00:00:00 ps -ef
[root@0737724188ef /]#
//这样启动的一个容器，就相当于启动了一个虚拟机。
[root@0737724188ef /]# exit   // 退出容器
exit
[root@localhost ~]#
```
* 列出所有的container ：$ docker ps -a
```bash
             boring_noyce
[root@localhost ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                          PORTS               NAMES
0737724188ef        centos              "/bin/bash"            3 minutes ago       Exited (0) About a minute ago                       peaceful_hypatia
6e093cd70311        centos              "echo 'hello world'"   6 days ago          Exited (0) 6 days ago                               focused_ramanujan
8bf963ae3f75        centos              "echo 'hello world'"   6 days ago          Exited (0) 6 days ago                               eager_austin
a8d2d93c0f7f        centos              "echo hhh"             6 days ago          Exited (0) 6 days ago                               thirsty_shannon
50cae0ffe136        centos              "echohello world"      6 days ago          Created                                             boring_noyce
```

* 列出最近一次启动的container：$ docker ps -l
```bash
[root@localhost ~]# docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
0737724188ef        centos              "/bin/bash"         3 minutes ago       Exited (0) About a minute ago                       peaceful_hypatia
```

* 查看容器的信息 docker inspect [CONTAINER ID]
```bash
[root@localhost ~]# docker inspect 0737724188ef 
[
    {
        "Id": "0737724188effb7f8f2b226f6b14446ac8ab64f0e0175d362512e2dcd7c8c513",
        "Created": "2017-03-09T12:10:23.674215587Z",
        "Path": "/bin/bash",
        "Args": [],
        "State": {
            "Status": "exited",
            "Running": false,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 0,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2017-03-09T12:10:28.28026553Z",
            "FinishedAt": "2017-03-09T12:12:18.36042992Z"
        },
        "Image": "sha256:67591570dd29de0e124ee89d50458b098dbd83b12d73e5fdaf8b4dcbd4ea50f8",
        "ResolvConfPath": "/var/lib/docker/containers/0737724188effb7f8f2b226f6b14446ac8ab64f0e0175d362512e2dcd7c8c513/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/0737724188effb7f8f2b226f6b14446ac8ab64f0e0175d362512e2dcd7c8c513/hostname",
        "HostsPath": "/var/lib/docker/containers/0737724188effb7f8f2b226f6b14446ac8ab64f0e0175d362512e2dcd7c8c513/hosts",
        "LogPath": "/var/lib/docker/containers/0737724188effb7f8f2b226f6b14446ac8ab64f0e0175d362512e2dcd7c8c513/0737724188effb7f8f2b226f6b14446ac8ab64f0e0175d362512e2dcd7c8c513-json.log",
        "Name": "/peaceful_hypatia",
        "RestartCount": 0,
        "Driver": "devicemapper",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {},
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": null,
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DiskQuota": 0,
            "KernelMemory": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": -1,
            "OomKillDisable": false,
            "PidsLimit": 0,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0
        },
        "GraphDriver": {
            "Name": "devicemapper",
            "Data": {
                "DeviceId": "12",
                "DeviceName": "docker-253:0-76097384-4c4cba49b5445a06ac8e0ae17c40f0a79278fe6ebdc26eeb9ece8e06c387f94c",
                "DeviceSize": "10737418240"
            }
        },
        "Mounts": [],
        "Config": {
            "Hostname": "0737724188ef",
            "Domainname": "",
            "User": "",
            "AttachStdin": true,
            "AttachStdout": true,
            "AttachStderr": true,
            "Tty": true,
            "OpenStdin": true,
            "StdinOnce": true,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/bash"
            ],
            "Image": "centos",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {
                "build-date": "20161214",
                "license": "GPLv2",
                "name": "CentOS Base Image",
                "vendor": "CentOS"
            }
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "5973c686de8e70fff8d87a7549b111a010df9c5663e0a171f0257d8977a77997",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": null,
            "SandboxKey": "/var/run/docker/netns/5973c686de8e",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "",
            "Gateway": "",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "",
            "IPPrefixLen": 0,
            "IPv6Gateway": "",
            "MacAddress": "",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "28f7568b13548cf6aee6501742230c56b5e227dd7eab144ddff2bda098a62159",
                    "EndpointID": "",
                    "Gateway": "",
                    "IPAddress": "",
                    "IPPrefixLen": 0,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": ""
                }
            }
        }
    }
]
[root@localhost ~]#
```

* 自定义容器名字:docker run --name=container02 -i -t centos /bin/bash
```bash
[root@localhost ~]# docker run --name=container02 -i -t centos /bin/bash 
[root@b3d543663ab3 /]# exit
exit
[root@localhost ~]# docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
b3d543663ab3        centos              "/bin/bash"         17 seconds ago      Exited (0) 7 seconds ago                       container02
[root@localhost ~]# 
```

* 重新启动停止的容器: docker start [-i] 容器名
```bash
[root@localhost ~]# docker start -i container02
[root@b3d543663ab3 /]# exit
exit
[root@localhost ~]# 
```

* 删除已经停止的容器: docker rm 容器名
```bash
[root@localhost ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                          PORTS               NAMES
b3d543663ab3        centos              "/bin/bash"            5 minutes ago       Exited (0) About a minute ago                       container02
da3999224f82        centos              "/bin/bash"            About an hour ago   Exited (0) About a minute ago                       container01
0737724188ef        centos              "/bin/bash"            About an hour ago   Exited (0) About an hour ago                        peaceful_hypatia
6e093cd70311        centos              "echo 'hello world'"   6 days ago          Exited (0) 6 days ago                               focused_ramanujan
8bf963ae3f75        centos              "echo 'hello world'"   6 days ago          Exited (0) 6 days ago                               eager_austin
a8d2d93c0f7f        centos              "echo hhh"             6 days ago          Exited (0) 6 days ago                               thirsty_shannon
50cae0ffe136        centos              "echohello world"      6 days ago          Created                                             boring_noyce
[root@localhost ~]# docker rm b3d543663ab3
b3d543663ab3
[root@localhost ~]# docker ps -a          
^H^H^H^H^HCONTAINER ID        IMAGE               COMMAND                CREATED             STATUS                         PORTS               NAMES
da3999224f82        centos              "/bin/bash"            About an hour ago   Exited (0) 2 minutes ago                           container01
0737724188ef        centos              "/bin/bash"            About an hour ago   Exited (0) About an hour ago                       peaceful_hypatia
6e093cd70311        centos              "echo 'hello world'"   6 days ago          Exited (0) 6 days ago                              focused_ramanujan
8bf963ae3f75        centos              "echo 'hello world'"   6 days ago          Exited (0) 6 days ago                              eager_austin
a8d2d93c0f7f        centos              "echo hhh"             6 days ago          Exited (0) 6 days ago                              thirsty_shannon
50cae0ffe136        centos              "echohello world"      6 days ago          Created                                            boring_noyce
[root@localhost ~]# 
```

## 守护式容器：

能够长时间运行，没有交互式会话，适合运行应用程序和服务

* 以守护式形式运行容器: docker run -i -t IMAGE /bin/bash
* 通过 Ctrl+P   Ctrl+Q 组合键来退出交互式容器的bash,容器就会在后台运行
```bash
[root@localhost ~]# docker run -i -t centos /bin/bash 
[root@ef411190102a /]# [root@localhost ~]# 
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
ef411190102a        centos              "/bin/bash"         About a minute ago   Up About a minute                       unruffled_agnesi
[root@localhost ~]# 
```

* 附加到运行中的容器：docker attach 容器名
```bash
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
ef411190102a        centos              "/bin/bash"         About a minute ago   Up About a minute                       unruffled_agnesi
[root@localhost ~]# docker attach ef411190102a 
[root@ef411190102a /]# [root@localhost ~]# 
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
ef411190102a        centos              "/bin/bash"         3 minutes ago       Up 3 minutes                            unruffled_agnesi
[root@localhost ~]# docker attach ef411190102a 
[root@ef411190102a /]# exit
exit
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@localhost ~]#  
```

* 附加到运行中的容器：docker exec -i -t  容器名 /bin/bash
```
[proy@yserver ~]$ docker exec -i -t  d1616077a255  /bin/bash
```

* 启动守护式容器：docker run -d 镜像名 [COMMAND] [ARG...]
```bash
[root@localhost ~]# docker run --name dc2 -d centos /bin/sh -c "while true;do echo hello world; sleep 1;done"
eab970bdf4d397440d9c970fbfe5ee3eabcc58b7e5a16234132e661bdfdacd32
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
eab970bdf4d3        centos              "/bin/sh -c 'while..."   7 seconds ago       Up 6 seconds                            dc2
[root@localhost ~]# 
```

* 查看容器日志：docker logs [-f] [-t] [--tail] 容器名

docker logs -tf --tail 10 dc2 // 显示最新的10条数据
```bash
[root@localhost ~]# docker logs -tf --tail 10 dc2
2017-03-09T13:57:42.861587077Z hello world
2017-03-09T13:57:43.865165504Z hello world
2017-03-09T13:57:44.866677547Z hello world
2017-03-09T13:57:45.875231821Z hello world
2017-03-09T13:57:46.879996998Z hello world
2017-03-09T13:57:47.884150238Z hello world
2017-03-09T13:57:48.888390295Z hello world
2017-03-09T13:57:49.892704565Z hello world
2017-03-09T13:57:50.896329856Z hello world
2017-03-09T13:57:51.898952576Z hello world
2017-03-09T13:57:52.904690701Z hello world
2017-03-09T13:57:53.910569070Z hello world
2017-03-09T13:57:54.915265536Z hello world
2017-03-09T13:57:55.920712641Z hello world
2017-03-09T13:57:56.927213031Z hello world
2017-03-09T13:57:57.930850625Z hello world
2017-03-09T13:57:58.940577867Z hello world
2017-03-09T13:57:59.947771219Z hello world
2017-03-09T13:58:00.951221550Z hello world
```

* 查看容器内进程：docker top 容器名
```bash
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
eab970bdf4d3        centos              "/bin/sh -c 'while..."   4 minutes ago       Up 4 minutes                            dc2
[root@localhost ~]# docker top dc2
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                10762               10746               0                   21:55               ?                   00:00:00            /bin/sh -c while true;do echo hello world; sleep 1;done
root                11305               10762               0                   22:00               ?                   00:00:00            sleep 1
[root@localhost ~]# 
```

* 在运行的容器内启动新进程：docker exec [-d] [-i] [-t] 容器名
```bash
[root@localhost ~]# docker top dc2
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                10762               10746               0                   21:55               ?                   00:00:00            /bin/sh -c while true;do echo hello world; sleep 1;done
root                11305               10762               0                   22:00               ?                   00:00:00            sleep 1
[root@localhost ~]# docker exec -i -t dc2 /bin/bash
[root@eab970bdf4d3 /]# [root@localhost ~]# 
[root@localhost ~]# docker top dc2
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                10762               10746               0                   21:55               ?                   00:00:00            /bin/sh -c while true;do echo hello world; sleep 1;done
root                11776               11759               0                   22:04               pts/0               00:00:00            /bin/bash
root                11866               10762               0                   22:04               ?                   00:00:00            sleep 1
[root@localhost ~]#  
```

* 停止守护式容器：docker stop 容器名
* 停止守护式容器：docker kill 容器名
```bash
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
eab970bdf4d3        centos              "/bin/sh -c 'while..."   11 minutes ago      Up 11 minutes                           dc2
[root@localhost ~]# docker stop dc2
dc2
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[root@localhost ~]# 
```

## 在容器中部署nginx静态网站

* 设置容器的端口映射：run [-P] [-p]
* Nginx 部署流程

1.创建映射80端口的交互式容器

2.安装Nginx

3.创建静态页面

4.修改nginx配置文件

5.运行nginx

6.验证网站访问


```bash
[root@localhost ~]# docker run -p 80 --name web -i -t centos /bin/bash
[root@fb587df3ab6e /]# wget //查看有没有wget命令
bash: wget: command not found
[root@fb587df3ab6e /]# yum install -y wget gcc gcc-c++ make openssl-devel //安装需要的工具
......
//安装nginx需要依赖pcre
[root@fb587df3ab6e /]# wget http://nginx.org/download/nginx-1.11.10.tar.gz

[root@fb587df3ab6e /]# wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.gz
[root@fb587df3ab6e /]# ll
total 3028
-rw-r--r--   1 root root   15712 Dec 14 14:59 anaconda-post.log
lrwxrwxrwx   1 root root       7 Dec 14 14:57 bin -> usr/bin
drwxr-xr-x   5 root root     360 Mar  9 14:13 dev
drwxr-xr-x  47 root root    4096 Mar  9 14:24 etc
drwxr-xr-x   2 root root    4096 Nov  5 15:38 home
lrwxrwxrwx   1 root root       7 Dec 14 14:57 lib -> usr/lib
lrwxrwxrwx   1 root root       9 Dec 14 14:57 lib64 -> usr/lib64
drwx------   2 root root    4096 Dec 14 14:57 lost+found
drwxr-xr-x   2 root root    4096 Nov  5 15:38 media
drwxr-xr-x   2 root root    4096 Nov  5 15:38 mnt
-rw-r--r--   1 root root  967773 Feb 14 15:43 nginx-1.11.10.tar.gz
drwxr-xr-x   2 root root    4096 Nov  5 15:38 opt
-rw-r--r--   1 root root 2062258 Mar  9 14:33 pcre-8.39.tar.gz
dr-xr-xr-x 312 root root       0 Mar  9 14:13 proc
dr-xr-x---   2 root root    4096 Dec 14 14:59 root
drwxr-xr-x  10 root root    4096 Mar  9 14:25 run
lrwxrwxrwx   1 root root       8 Dec 14 14:57 sbin -> usr/sbin
drwxr-xr-x   2 root root    4096 Nov  5 15:38 srv
dr-xr-xr-x  13 root root       0 Mar  9 14:13 sys
drwxrwxrwt   7 root root    4096 Mar  9 14:25 tmp
drwxr-xr-x  13 root root    4096 Dec 14 14:57 usr
drwxr-xr-x  18 root root    4096 Dec 14 14:59 var
[root@fb587df3ab6e /]# pwd
/
[root@fb587df3ab6e /]# mv *.gz /usr/local/src/  
[root@fb587df3ab6e /]# cd /usr/local/src/
[root@fb587df3ab6e src]# ll
total 2964
-rw-r--r-- 1 root root  967773 Feb 14 15:43 nginx-1.11.10.tar.gz
-rw-r--r-- 1 root root 2062258 Mar  9 14:33 pcre-8.39.tar.gz
[root@fb587df3ab6e src]# tar zxf pcre-8.39.tar.gz 
[root@fb587df3ab6e src]# tar zxf nginx-1.11.10.tar.gz 
[root@fb587df3ab6e src]# ll
total 2972
drwxr-xr-x 8 1001 1001    4096 Feb 14 15:36 nginx-1.11.10
-rw-r--r-- 1 root root  967773 Feb 14 15:43 nginx-1.11.10.tar.gz
drwxr-xr-x 7 1169 1169    4096 Jun 14  2016 pcre-8.39
-rw-r--r-- 1 root root 2062258 Mar  9 14:33 pcre-8.39.tar.gz
[root@fb587df3ab6e nginx-1.11.10]# useradd -s /sbin/nologin -M www
[root@fb587df3ab6e nginx-1.11.10]# ll
total 720
-rw-r--r-- 1 1001 1001 274992 Feb 14 15:36 CHANGES
-rw-r--r-- 1 1001 1001 419007 Feb 14 15:36 CHANGES.ru
-rw-r--r-- 1 1001 1001   1397 Feb 14 15:36 LICENSE
-rw-r--r-- 1 1001 1001     49 Feb 14 15:36 README
drwxr-xr-x 6 1001 1001   4096 Mar  9 14:36 auto
drwxr-xr-x 2 1001 1001   4096 Mar  9 14:36 conf
-rwxr-xr-x 1 1001 1001   2481 Feb 14 15:36 configure
drwxr-xr-x 4 1001 1001   4096 Mar  9 14:36 contrib
drwxr-xr-x 2 1001 1001   4096 Mar  9 14:36 html
drwxr-xr-x 2 1001 1001   4096 Mar  9 14:36 man
drwxr-xr-x 9 1001 1001   4096 Mar  9 14:36 src
[root@fb587df3ab6e nginx-1.11.10]# ./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_ssl_module --with-http_stub_status_module --with-pcre=/usr/local/src/pcre-8.39 
checking for OS
 + Linux 3.10.0-327.el7.x86_64 x86_64
checking for C compiler ... found
 + using GNU C compiler
 + gcc version: 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) 
checking for gcc -pipe switch ... found
checking for -Wl,-E switch ... found
checking for gcc builtin atomic operations ... found
checking for C99 variadic macros ... found
checking for gcc variadic macros ... found
checking for gcc builtin 64 bit byteswap ... found
checking for unistd.h ... found
checking for inttypes.h ... found
checking for limits.h ... found
checking for sys/filio.h ... not found
checking for sys/param.h ... found
checking for sys/mount.h ... found
checking for sys/statvfs.h ... found
checking for crypt.h ... found
checking for Linux specific features
checking for epoll ... found
checking for EPOLLRDHUP ... found
checking for EPOLLEXCLUSIVE ... not found
checking for O_PATH ... found
checking for sendfile() ... found
checking for sendfile64() ... found
checking for sys/prctl.h ... found
checking for prctl(PR_SET_DUMPABLE) ... found
checking for sched_setaffinity() ... found
checking for crypt_r() ... found
checking for sys/vfs.h ... found
checking for poll() ... found
checking for /dev/poll ... not found
checking for kqueue ... not found
checking for crypt() ... not found
checking for crypt() in libcrypt ... found
checking for F_READAHEAD ... not found
checking for posix_fadvise() ... found
checking for O_DIRECT ... found
checking for F_NOCACHE ... not found
checking for directio() ... not found
checking for statfs() ... found
checking for statvfs() ... found
checking for dlopen() ... not found
checking for dlopen() in libdl ... found
checking for sched_yield() ... found
checking for SO_SETFIB ... not found
checking for SO_REUSEPORT ... found
checking for SO_ACCEPTFILTER ... not found
checking for SO_BINDANY ... not found
checking for IP_BIND_ADDRESS_NO_PORT ... not found
checking for IP_TRANSPARENT ... found
checking for IP_BINDANY ... not found
checking for IP_RECVDSTADDR ... not found
checking for IP_PKTINFO ... found
checking for IPV6_RECVPKTINFO ... found
checking for TCP_DEFER_ACCEPT ... found
checking for TCP_KEEPIDLE ... found
checking for TCP_FASTOPEN ... found
checking for TCP_INFO ... found
checking for accept4() ... found
checking for eventfd() ... found
checking for int size ... 4 bytes
checking for long size ... 8 bytes
checking for long long size ... 8 bytes
checking for void * size ... 8 bytes
checking for uint32_t ... found
checking for uint64_t ... found
checking for sig_atomic_t ... found
checking for sig_atomic_t size ... 4 bytes
checking for socklen_t ... found
checking for in_addr_t ... found
checking for in_port_t ... found
checking for rlim_t ... found
checking for uintptr_t ... uintptr_t found
checking for system byte ordering ... little endian
checking for size_t size ... 8 bytes
checking for off_t size ... 8 bytes
checking for time_t size ... 8 bytes
checking for AF_INET6 ... found
checking for setproctitle() ... not found
checking for pread() ... found
checking for pwrite() ... found
checking for pwritev() ... found
checking for sys_nerr ... found
checking for localtime_r() ... found
checking for posix_memalign() ... found
checking for memalign() ... found
checking for mmap(MAP_ANON|MAP_SHARED) ... found
checking for mmap("/dev/zero", MAP_SHARED) ... found
checking for System V shared memory ... found
checking for POSIX semaphores ... not found
checking for POSIX semaphores in libpthread ... found
checking for struct msghdr.msg_control ... found
checking for ioctl(FIONBIO) ... found
checking for struct tm.tm_gmtoff ... found
checking for struct dirent.d_namlen ... not found
checking for struct dirent.d_type ... found
checking for sysconf(_SC_NPROCESSORS_ONLN) ... found
checking for openat(), fstatat() ... found
checking for getaddrinfo() ... found
checking for OpenSSL library ... found
checking for zlib library ... found
creating objs/Makefile

Configuration summary
  + using PCRE library: /usr/local/src/pcre-8.39
  + using system OpenSSL library
  + using system zlib library

  nginx path prefix: "/usr/local/nginx"
  nginx binary file: "/usr/local/nginx/sbin/nginx"
  nginx modules path: "/usr/local/nginx/modules"
  nginx configuration prefix: "/usr/local/nginx/conf"
  nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
  nginx pid file: "/usr/local/nginx/logs/nginx.pid"
  nginx error log file: "/usr/local/nginx/logs/error.log"
  nginx http access log file: "/usr/local/nginx/logs/access.log"
  nginx http client request body temporary files: "client_body_temp"
  nginx http proxy temporary files: "proxy_temp"
  nginx http fastcgi temporary files: "fastcgi_temp"
  nginx http uwsgi temporary files: "uwsgi_temp"
  nginx http scgi temporary files: "scgi_temp"

[root@fb587df3ab6e nginx-1.11.10]# make
......
objs/ngx_modules.o \
-ldl -lpthread -lcrypt /usr/local/src/pcre-8.39/.libs/libpcre.a -lssl -lcrypto -ldl -lz \
-Wl,-E
sed -e "s|%%PREFIX%%|/usr/local/nginx|" \
        -e "s|%%PID_PATH%%|/usr/local/nginx/logs/nginx.pid|" \
        -e "s|%%CONF_PATH%%|/usr/local/nginx/conf/nginx.conf|" \
        -e "s|%%ERROR_LOG_PATH%%|/usr/local/nginx/logs/error.log|" \
        < man/nginx.8 > objs/nginx.8
make[1]: Leaving directory `/usr/local/src/nginx-1.11.10'
[root@fb587df3ab6e nginx-1.11.10]# make install
......
make[1]: Leaving directory `/usr/local/src/nginx-1.11.10'
[root@fb587df3ab6e nginx-1.11.10]# pwd
/usr/local/src/nginx-1.11.10
[root@fb587df3ab6e ~]# mkdir -p /var/www/html
[root@fb587df3ab6e ~]# cd /var/www/html/
[root@fb587df3ab6e html]# vi index.html
[root@fb587df3ab6e sbin]# vi /var/www/html/index.html
[root@fb587df3ab6e sbin]# cat /var/www/html/index.html 
<html>
<html lang="en">
<head>
</head>
<body >
    <h2 > Nginx </h2>
</body>
</html>
[root@fb587df3ab6e sbin]# cd /usr/local/nginx/sbin
[root@fb587df3ab6e sbin]# pwd
/usr/local/nginx/sbin
[root@fb587df3ab6e sbin]# ./nginx
[root@fb587df3ab6e sbin]# ps -ef  
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 14:13 ?        00:00:00 /bin/bash
root      5826     1  0 15:27 ?        00:00:00 nginx: master process ./nginx
www       5827  5826  0 15:27 ?        00:00:00 nginx: worker process
root      5828     1  0 15:28 ?        00:00:00 ps -ef
[root@fb587df3ab6e sbin]# [root@localhost ~]# 
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                   NAMES
fb587df3ab6e        centos              "/bin/bash"         About an hour ago   Up About an hour    0.0.0.0:32768->80/tcp   web
[root@localhost ~]#  docker port web
80/tcp -> 0.0.0.0:32768
[root@localhost ~]# docker top web
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                12516               12500               0                   22:13               pts/0               00:00:00            /bin/bash
root                22110               12516               0                   23:27               ?                   00:00:00            nginx: master process ./nginx
1000                22111               22110               0                   23:27               ?                   00:00:00            nginx: worker process
[root@localhost ~]# curl http://127.0.0.1:32768
<html>
<html lang="en">
<head>
</head>
<body >
    <h2 > Nginx </h2>
</body>
</html>
[root@localhost ~]# 
////// 在物理机中输入：http://192.168.200.133:32768，也可以查看到信息。
```

* 当容器exit退出后，再启动容器，端口映射会发生改变。


