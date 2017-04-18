# centos 7.2安装git2.x版本

<!-- toc -->

## 前言
今天在我的centos7.2开发环境安装git2.x时候遇到了各种问题，还好一一解决，为方便大家，这里列出遇到的问题和解决办法，```yum install git```　默认安装的git1.8版本的。

## 安装
从github获取最新的release版本源码：
```bash
[root@localhost local]#  cd /usr/local/
[root@localhost local]# pwd
/usr/local
[root@localhost local]# wget https://www.kernel.org/pub/software/scm/git/git-2.12.0.tar.gz
```
解压
```bash
[root@localhost local]# tar -zxvf git-2.12.0.tar.gz
[root@localhost local]# cd git-2.12.0/
```
进入目录配置
```bash
[root@localhost git-2.12.0]# ./configure --prefix=/usr/local/git
```
编译
```bash
[root@localhost git-2.12.0]# make
```
出现如下错误
```
Can't locate ExtUtils/MakeMaker.pm in @INC (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 .) at Makefile.PL line 3.
BEGIN failed--compilation aborted at Makefile.PL line 3.
make[1]: *** [perl.mak] 错误 2
make: *** [perl/perl.mak] 错误 2
```
解决方法
```
yum install perl-ExtUtils-MakeMaker package
```
然后再```make && make install```, 进行编译安装
```bash
[root@localhost git-2.12.0]# make
[root@localhost git-2.12.0]# make install
```
配置环境变量 ```vim /etc/profile```
```
export PATH="/usr/local/git/bin:$PATH"
```
保存配置
```
source /etc/profile
```
检查版本
```bash
[root@localhost ~]# git --version
git version 2.12.0
[root@localhost ~]#
```
## 创建SSH Key
```bash
[root@localhost local]# ssh-keygen -t rsa -C appchn@163.com
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): 
Created directory '/root/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
9b:d7:16:f3:58:5b:1c:4c:43:09:af:37:f0:4f:e0:ae appchn@163.com
The key's randomart image is:
+--[ RSA 2048]----+
|             .o+.|
|              +..|
|             ..+ |
|             .+o.|
|        S   o.o++|
|         o . B.+o|
|        o . + + .|
|         . . .   |
|            E    |
+-----------------+
[root@localhost local]#
```
