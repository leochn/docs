# docker小技巧

## 删除所有停止的容器
```
docker rm $(docker ps -a -q)
```

## 删除所有没命名的镜像
```
docker rmi $(docker images | grep "<none>" | awk "{print $3}")
```
