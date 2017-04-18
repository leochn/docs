# docker构建tomcat镜像并进行maven热部署

<!-- toc -->

## 一.通过Dockerfile构建基础镜像

### 1. 创建Dockerfile文件
* 创建目录,准备tomcat9和jdk文件
```bash
[root@localhost docker-file]# cd tomcat9fix/
[root@localhost tomcat9fix]# ll
总用量 188032
-rw-r--r-- 1 root root   9287772 4月  12 10:10 apache-tomcat-9.0.0.M18.tar.gz
-rw-r--r-- 1 root root       495 4月  12 10:17 Dockerfile
drwxr-xr-x 8   10  143      4096 12月 13 08:50 jdk1.8.0_121
-rw-r--r-- 1 root root 183246769 4月   1 14:50 jdk-8u121-linux-x64.tar.gz
```
* Dockerfile文件内容：
```bash
[root@localhost tomcat9fix]# cat Dockerfile 
# This is My first Dockerfile
# Version 1.0
# Author: leo

#Base images
FROM centos

#MAINTAINER
MAINTAINER leo

#ADD
ADD jdk-8u121-linux-x64.tar.gz /usr/local/
ADD apache-tomcat-9.0.0.M18.tar.gz /usr/local/


#配置java与tomcat环境变量
ENV JAVA_HOME /usr/local/jdk1.8.0_121
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.0.M18
ENV PATH $PATH:$CATALINA_HOME/lib:$CATALINA_HOME/bin

#容器运行时监听的端口
EXPOSE  8080

[root@localhost tomcat9fix]#
```
### 2. 创建镜像
```bash
[root@localhost tomcat9fix]# docker build -t tomcat9fix:v2 .                 
Sending build context to Docker daemon   564 MB
Step 1/9 : FROM centos
 ---> 67591570dd29
Step 2/9 : MAINTAINER leo
 ---> Using cache
 ---> 7a7f5cb74241
Step 3/9 : ADD jdk-8u121-linux-x64.tar.gz /usr/local/
 ---> bf8c6fb5fe2a
Removing intermediate container 2a9124a4b697
Step 4/9 : ADD apache-tomcat-9.0.0.M18.tar.gz /usr/local/
 ---> 2772cd29398a
Removing intermediate container 941045e0a97d
Step 5/9 : ENV JAVA_HOME /usr/local/jdk1.8.0_121
 ---> Running in a899121808fe
 ---> 48881ab635a2
Removing intermediate container a899121808fe
Step 6/9 : ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
 ---> Running in 43de10d077cf
 ---> ebc04d5b2860
Removing intermediate container 43de10d077cf
Step 7/9 : ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.0.M18
 ---> Running in 48562db1e111
 ---> 53b848b86236
Removing intermediate container 48562db1e111
Step 8/9 : ENV PATH $PATH:$CATALINA_HOME/lib:$CATALINA_HOME/bin
 ---> Running in 841516ad25bb
 ---> a0a62b90bc05
Removing intermediate container 841516ad25bb
Step 9/9 : EXPOSE 8080
 ---> Running in 9bc0e3885dca
 ---> 80af2f8cd9b9
Removing intermediate container 9bc0e3885dca
Successfully built 80af2f8cd9b9
[root@localhost tomcat9fix]#
```
### 3.启动容器,启动容器中的tomcat9
* 查看镜像
```bash
[root@localhost /]# docker images 
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
tomcat9fix                 v2                  80af2f8cd9b9        About an hour ago   575 MB
tomcat9fix                 v1                  9eaf3c91c24a        2 hours ago         656 MB
centos                     latest              67591570dd29        3 months ago        192 MB
[root@localhost /]#
```
* 启动容器
```bash
[root@localhost tomcat9fix]# docker run -i -t -p 8088:8080 tomcat9fix:v2
```
* 启动和关闭容器中的tomcat9
```bash
[root@8e0208bd2a63 /]# ./usr/local/apache-tomcat-9.0.0.M18/bin/startup.sh
Using CATALINA_BASE:   /usr/local/apache-tomcat-9.0.0.M18
Using CATALINA_HOME:   /usr/local/apache-tomcat-9.0.0.M18
Using CATALINA_TMPDIR: /usr/local/apache-tomcat-9.0.0.M18/temp
Using JRE_HOME:        /usr/local/jdk1.8.0_121
Using CLASSPATH:       /usr/local/apache-tomcat-9.0.0.M18/bin/bootstrap.jar:/usr/local/apache-tomcat-9.0.0.M18/bin/tomcat-juli.jar
Tomcat started.
[root@8e0208bd2a63 /]# ./usr/local/apache-tomcat-9.0.0.M18/bin/shutdown.sh
Using CATALINA_BASE:   /usr/local/apache-tomcat-9.0.0.M18
Using CATALINA_HOME:   /usr/local/apache-tomcat-9.0.0.M18
Using CATALINA_TMPDIR: /usr/local/apache-tomcat-9.0.0.M18/temp
Using JRE_HOME:        /usr/local/jdk1.8.0_121
Using CLASSPATH:       /usr/local/apache-tomcat-9.0.0.M18/bin/bootstrap.jar:/usr/local/apache-tomcat-9.0.0.M18/bin/tomcat-juli.jar
[root@8e0208bd2a63 /]#
```

* 修改tomcat中的热配置(查看tomcat9热部署),并退出容器
```bash
[root@8e0208bd2a63 /]# cd /usr/local/apache-tomcat-9.0.0.M18/conf/
[root@8e0208bd2a63 conf]# 
[root@8e0208bd2a63 conf]# vi tomcat-users.xml 
[root@8e0208bd2a63 conf]# cd /usr/local/apache-tomcat-9.0.0.M18/webapps/manager/META-INF/
[root@8e0208bd2a63 META-INF]# ls -l
total 4
-rw-r----- 1 root root 1018 Mar  8 15:22 context.xml
[root@8e0208bd2a63 META-INF]# vi context.xml
[root@8e0208bd2a63 META-INF]# exit
```

## 二.通过commit构建tomcat9镜像
### 1.commit构建镜像
```bash
[root@localhost tomcat9]# docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
8e0208bd2a63        tomcat9fix:v2       "/bin/bash"         13 minutes ago      Exited (0) 10 seconds ago                       focused_wright
[root@localhost tomcat9]# docker commit -m "centos-tomcat9" 8e0208bd2a63 jkinfo-tomcat9:v1
sha256:8a58707e98f97f39ed184b5c8208db53cd6abb07f1041762d2d8a81dd2d340fc
[root@localhost tomcat9]# docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
jkinfo-tomcat9             v1                  8a58707e98f9        49 seconds ago      575 MB
tomcat9fix                 v2                  80af2f8cd9b9        42 minutes ago      575 MB
tomcat9fix                 v1                  9eaf3c91c24a        About an hour ago   656 MB
centos                     latest              67591570dd29        3 months ago        192 MB
```
### 2.启动容器并启动该容器中tomcat9
```bash
[root@localhost tomcat9]# docker run -i -t -p 8088:8080 jkinfo-tomcat9:v1
[root@46d1e09e8a4c /]# ./usr/local/apache-tomcat-9.0.0.M18/bin/startup.sh
Using CATALINA_BASE:   /usr/local/apache-tomcat-9.0.0.M18
Using CATALINA_HOME:   /usr/local/apache-tomcat-9.0.0.M18
Using CATALINA_TMPDIR: /usr/local/apache-tomcat-9.0.0.M18/temp
Using JRE_HOME:        /usr/local/jdk1.8.0_121
Using CLASSPATH:       /usr/local/apache-tomcat-9.0.0.M18/bin/bootstrap.jar:/usr/local/apache-tomcat-9.0.0.M18/bin/tomcat-juli.jar
Tomcat started.
[root@46d1e09e8a4c /]#
```

## 三.通过maven热部署到容器中的tomcat

### 1. 使用maven插件实现热部署
```
需要使用maven的tomcat插件。Apache官方提供的tomcat插件。
使用maven打包——》上传——热部署一气呵成。
Maven的配置：
修改项目的pom.xml文件,在<build> 节点下面增加如下配置:tomcat7的配置
```
```
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.tomcat.maven</groupId>
                <artifactId>tomcat7-maven-plugin</artifactId>
                <version>2.2</version>
                <configuration>
                    <port>8088</port>
                    <path>/</path>
                    <url>http://192.168.200.133:8088/manager/text</url>
                    <username>tomcat</username>
                    <password>tomcat</password>
                </configuration>
            </plugin>
        </plugins>
    </build>
```
### 2. 热部署
```
热部署之前，修改配置文件中的数据库配置、调用服务的配置为生产环境需要的ip及端口。
执行以下命令：
初次部署可以使用 "tomcat7:deploy" 命令
如果已经部署过使用 "tomcat7:redeploy" 命令

部署跳过测试：
tomcat7:redeploy -DskipTests
```


### 热部署出错：
```
Uploading: http://192.168.126.202:8088/manager/text/deploy?path=%2F&update=true

[INFO] I/O exception (java.net.SocketException) caught when processing request: Connection reset by peer: socket write error
[INFO] Retrying request
Uploading: http://192.168.126.202:8088/manager/text/deploy?path=%2F&update=true

[INFO] I/O exception (java.net.SocketException) caught when processing request: Connection reset by peer: socket write error
[INFO] Retrying request
Uploading: http://192.168.126.202:8088/manager/text/deploy?path=%2F&update=true

[INFO] I/O exception (java.net.SocketException) caught when processing request: Connection reset by peer: socket write error
[INFO] Retrying request
Uploading: http://192.168.126.202:8088/manager/text/deploy?path=%2F&update=true

[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 12.505 s
[INFO] Finished at: 2017-04-12T16:41:18+08:00
[INFO] Final Memory: 15M/190M
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.tomcat.maven:tomcat7-maven-plugin:2.2:redeploy (default-cli) on project jkinfo-user: Cannot invoke Tomcat manager: Connection reset by peer: socket write error -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
```




