# taotao

<!-- toc -->

```
0.nginx:
    cd /root/nginx-1.8.0/
    make install
    cd /usr/local/nginx/sbin/
    ./nginx

1.redis
    启动redis实例：
        cd /usr/local/redis/bin/
        ./redis-server redis.conf
    查看状态：ps aux|grep redis

2.启动solr，开启tomcat
    cd /usr/local/solr/tomcat/bin
    ./startup.sh
    //或者------------------
    cd /usr/local/solr/tomcat/
    bin/startup.sh

3.到数据到solr：http://localhost:8083/search/manager/importall



//=======================
启动rabbitmq:在192.168.200.132服务器上：
cd /usr/local/rabbitmq/rabbitmq_server-3.6.0/sbin
启动rabbitmq：./rabbitmq-server -detached
关闭rabbitmq：./rabbitmqctl stop

//=================
vi /etc/sysconfig/iptables #编辑防火墙配置文件
systemctl restart iptables.service  #最后重启防火墙使配置生效

cp -r html  html81

测试是否安装成功（非必需）
输入"rpm -qa | grep -i mysql"命令，"-i" 是不分大小写字符查询，只要含有mysql

```