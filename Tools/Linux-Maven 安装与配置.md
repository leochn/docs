# Linux Maven 安装与配置

<!-- toc -->

1、下载```maven``` 

```
wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz
```
2、解压至```/usr/local```目录 
```
tar -zxvf apache-maven-3.2.5-bin.tar.gz
mv apache-maven-3.2.5  /usr/local/
```
3、配置```maven```仓库路径
```
/usr/local/apache-maven-3.2.5/conf
vim settings.xml
///// 配置本地仓库:  <localRepository>/usr/local/repository</localRepository>
```
4、配置环境变量 ```vim /etc/profile``` 最后添加以下两行
```
export MAVEN_HOME=/usr/local/apache-maven-3.2.5  
export PATH=${PATH}:${MAVEN_HOME}/bin 
```
5、保存配置,并进行测试
```bash
[root@localhost bin]# source /etc/profile
[root@localhost bin]# mvn -v
Apache Maven 3.2.5 (12a6b3acb947671f09b81f49094c53f426d8cea1; 2014-12-15T01:29:23+08:00)
Maven home: /usr/local/apache-maven-3.2.5
Java version: 1.7.0_55, vendor: Oracle Corporation
Java home: /usr/local/jdk1.7.0_55/jre
Default locale: zh_CN, platform encoding: UTF-8
OS name: "linux", version: "3.10.0-327.el7.x86_64", arch: "i386", family: "unix"
```

