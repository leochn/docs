# docker小技巧

## 删除所有停止的容器
```
docker rm $(docker ps -a -q)
```