# 如何将docker镜像上传到dockerhub仓库

<!-- toc -->


## 1.先创建Docker hub 帐号 ，并创建仓库
```
首先你需要一个docker hub 帐号，记住username，password，email .
后面在命令行验证登陆的时候需要用到，
再下来就是创建仓库了：create --->  create repository ,
取个名字，这里我们最终创建的仓库名称：leousst/tomcat9 ，
这个leousst是我的帐号，tomcat9是其中一个仓库名。
```

## 2.将容器commit 成镜像
* 这里你有一个运行容器，docker ps -a
```
[root@localhost ~]# docker ps -a
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS                      PORTS               NAMES
46d1e09e8a4c        jkinfo-tomcat9:v1             "/bin/bash"              2 hours ago         Exited (0) 18 minutes ago                       pensive_yalow
8e0208bd2a63        tomcat9fix:v2                 "/bin/bash"              2 hours ago         Exited (0) 2 hours ago                          focused_wright
d02b06a5191a        centos                        "/bin/bash"              3 hours ago         Exited (127) 2 hours ago                        kind_yalow
70e9eff459eb        centos-tomcat-dockerfile:v2   "/bin/sh -c '/opt/..."   3 hours ago         Exited (127) 3 hours ago                        confident_leavitt
```
* 我们需要将容器制作成为镜像才可以上传

```docker commit <exiting-Container> <hub-user>/<repo-name>[:<tag>]```

```
[root@localhost ~]# docker commit -m "jk-tomcat9" 8e0208bd2a63 leousst/tomcat9:v2       
sha256:10d03584d8e3f38476cc13ba5ed0d1fb5c809aa1e7691ec43e68ba0aa28130ad
[root@localhost ~]# docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
leousst/tomcat9            v2                  10d03584d8e3        5 seconds ago       575 MB
jkinfo-tomcat9             v1                  8a58707e98f9        About an hour ago   575 MB
tomcat9fix                 v2                  80af2f8cd9b9        2 hours ago         575 MB
tomcat9fix                 v1                  9eaf3c91c24a        3 hours ago         656 MB
centos                     latest              67591570dd29        3 months ago        192 MB
[root@localhost ~]# 
```

* 如果是已经存在的镜像，如何上传呢？
```
docker tag <existing-image> <hub-user>/<repo-name>[:<tag>]
这里的tag不指定就是latest 
```


## 3.docker hub 帐号在本地验证登陆
```bash
[root@localhost ~]# docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: leousst
Password: 
Login Succeeded
[root@localhost ~]#
```

## 4.docker push镜像到docker hub的仓库
* 语法
```
docker push
<hub-user>/<repo-name>:<tag>
```
* 正在推送
```
[root@localhost ~]# docker push leousst/tomcat9:v2
The push refers to a repository [docker.io/leousst/tomcat9]
c2e682f3a3ab: Pushed 
448615d3d8c4: Pushing [===================>                               ] 5.107 MB/13.1 MB
62d2c961c519: Pushing [>                                                  ]  7.07 MB/370.1 MB
34e7b85d83e4: Mounted from library/centos
```
* 推送完成





## 5.在docker hub仓库中查看

























