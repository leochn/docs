# tomcat9热部署遇到的问题

<!-- toc -->

## 出现TOMCAT 9.0 配置问题 403 Access Denied

### tomcat9.0 管理页面如：http://10.10.10.10:8080/manager/html 出现如下错误：403 Access Denied

* 1.需要配置：Tomcat/conf/tomcat-users.xml加入
```
<role rolename="manager-gui" />
<role rolename="manager-script" />
<user username="tomcat" password="tomcat" roles="manager-gui, manager-script"/>
```

以上配置好后本地可以访问，```http://127.0.0.1:8080/manager/html```

* 2.另外，需要修改Tomcat/webapps/manager/META-INF/context.xml文件：
```
<Context antiResourceLocking="false" privileged="true" >
  <!--
    Remove the comment markers from around the Valve below to limit access to
    the manager application to clients connecting from localhost
  -->
  
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1|\d+\.\d+\.\d+\.\d+" />
</Context>
```

* 3.或注释Value节点（tomcat9.0以下默认是注释的，所以不需修改）
```java
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
```
