# docker

<!-- toc -->

使用root用户

* 前提条件：
    * 首先，您要准备一个 CentOS 的操作系统，虚拟机也行。总之，可以通过 Linux 客户端工具访问到 CentOS 操作系统就行。需要说明的是，Ubuntu 或其它 Linux 操作系统也能玩 Docker，只不过本文选择了以 CentOS 为例，仅此而已。
    * CentOS 具体要求如下：
        * 必须是 64 位操作系统，建议内核在 3.8 以上
        * 通过以下命令查看您的 CentOS 内核：
        
             ```
            uname -r
            ```

        * 如果执行以上命令后，输出的内核版本号低于 3.8 , 建议使用高版本的Centos


* 在 centos 中安装 Docker, 只需通过以下命令即可安装 Docker 软件：
``` linux
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum -y install docker-io
```
可使用以下命令，查看 Docker 是否安装成功：
```
docker version
```
若输出了 Docker 的版本号，则说明安装成功了，可通过以下命令启动 Docker 服务：
```
service docker start
```
一旦 Docker 服务启动完毕，我们下面就可以开始使用 Docker 了。

* 查看docker版本：docker version
``` java 
[root@localhost ~]# docker version
Client version: 1.7.1    // 客户端版本
Client API version: 1.19
Go version (client): go1.4.2
Git commit (client): 786b29d/1.7.1
OS/Arch (client): linux/amd64
Server version: 1.7.1
Server API version: 1.19  // 服务端版本
Go version (server): go1.4.2
Git commit (server): 786b29d/1.7.1
OS/Arch (server): linux/amd64
[root@localhost ~]# 
```
* docker的虚拟网桥： ip addr, docker0: 为Docker()虚拟网桥
```java
[root@localhost ~]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eno16777736: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:58:fe:2c brd ff:ff:ff:ff:ff:ff
    inet 192.168.200.133/24 brd 192.168.200.255 scope global dynamic eno16777736
       valid_lft 1247sec preferred_lft 1247sec
    inet6 fe80::20c:29ff:fe58:fe2c/64 scope link 
       valid_lft forever preferred_lft forever
3: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN 
    link/ether 52:54:00:f5:e7:fb brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
4: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast master virbr0 state DOWN qlen 500
    link/ether 52:54:00:f5:e7:fb brd ff:ff:ff:ff:ff:ff
5: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN 
    link/ether 56:84:7a:fe:97:99 brd ff:ff:ff:ff:ff:ff
    inet 172.17.42.1/16 scope global docker0
       valid_lft forever preferred_lft forever
[root@localhost ~]#
```
* docker的配置文件：/etc/sysconfig/docker
```
  1 # /etc/sysconfig/docker
  2 #
  3 # Other arguments to pass to the docker daemon process
  4 # These will be parsed by the sysv initscript and appended
  5 # to the arguments list passed to docker -d
  6 
  7 other_args=
  8 DOCKER_CERT_PATH=/etc/docker
  9 
 10 # Resolves: rhbz#1176302 (docker issue #407)
 11 DOCKER_NOWARN_KERNEL_VERSION=1
 12 
 13 # Location used for temporary files, such as those created by
 14 # # docker load and build operations. Default is /var/lib/docker/tmp
 15 # # Can be overriden by setting the following environment variable.
 16 # # DOCKER_TMPDIR=/var/tmp
```

* 查找镜像 :  docker search centos   //查找centos的镜像

``` java
[root@localhost docker]# docker search centos  //查找centos的镜像
NAME                                   DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
centos                                 The official build of CentOS.                   3103      [OK]       
jdeathe/centos-ssh                     CentOS-6 6.8 x86_64 / CentOS-7 7.3.1611 x8...   59                   [OK]
jdeathe/centos-ssh-apache-php          CentOS-6 6.8 x86_64 - Apache / PHP-FPM / P...   25                   [OK]
nimmis/java-centos                     This is docker images of CentOS 7 with dif...   23                   [OK]
consol/centos-xfce-vnc                 Centos container with "headless" VNC sessi...   22                   [OK]
million12/centos-supervisor            Base CentOS-7 with supervisord launcher, h...   13                   [OK]
torusware/speedus-centos               Always updated official CentOS docker imag...   8                    [OK]
egyptianbman/docker-centos-nginx-php   A simple and highly configurable docker co...   6                    [OK]
nathonfowlie/centos-jre                Latest CentOS image with the JRE pre-insta...   5                    [OK]
centos/mariadb55-centos7                                                               4                    [OK]
consol/sakuli-centos-xfce              Sakuli JavaScript based end-2-end testing ...   3                    [OK]
centos/redis                           Redis built for CentOS                          2                    [OK]
harisekhon/centos-java                 Java on CentOS (OpenJDK, tags jre/jdk7-8)       2                    [OK]
centos/tools                           Docker image that has systems administrati...   2                    [OK]
timhughes/centos                       Centos with systemd installed and running       1                    [OK]
blacklabelops/centos                   CentOS Base Image! Built and Updates Daily!     1                    [OK]
freenas/centos                         Simple CentOS Linux interactive container       1                    [OK]
darksheer/centos                       Base Centos Image -- Updated hourly             1                    [OK]
harisekhon/centos-scala                Scala + CentOS (OpenJDK tags 2.10-jre7 - 2...   1                    [OK]
labengine/centos                       Centos image base                               0                    [OK]
wenjianzhou/centos                     centos                                          0                    [OK]
smartentry/centos                      centos with smartentry                          0                    [OK]
repositoryjp/centos                    Docker Image for CentOS.                        0                    [OK]
vcatechnology/centos                   A CentOS Image which is updated daily           0                    [OK]
januswel/centos 
```

``` java
[root@localhost docker]# docker search -s 3 centos  // 获取3星以上的centos
NAME                                   DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
centos                                 The official build of CentOS.                   3103      [OK]       
jdeathe/centos-ssh                     CentOS-6 6.8 x86_64 / CentOS-7 7.3.1611 x8...   59                   [OK]
jdeathe/centos-ssh-apache-php          CentOS-6 6.8 x86_64 - Apache / PHP-FPM / P...   25                   [OK]
nimmis/java-centos                     This is docker images of CentOS 7 with dif...   23                   [OK]
consol/centos-xfce-vnc                 Centos container with "headless" VNC sessi...   22                   [OK]
million12/centos-supervisor            Base CentOS-7 with supervisord launcher, h...   13                   [OK]
torusware/speedus-centos               Always updated official CentOS docker imag...   8                    [OK]
egyptianbman/docker-centos-nginx-php   A simple and highly configurable docker co...   6                    [OK]
nathonfowlie/centos-jre                Latest CentOS image with the JRE pre-insta...   5                    [OK]
centos/mariadb55-centos7                                                               4                    [OK]
consol/sakuli-centos-xfce              Sakuli JavaScript based end-2-end testing ...   3                    [OK]
[root@localhost docker]#
```

* 下载镜像 :  


* 查看镜像：


* 删除镜像：



* Dockerfile 构建过程



* Dockerfile 指令


* 容器 
    * 启动容器
        * docker run IMAGE [COMMAND] [ARG...] run 在新容器中执行命令