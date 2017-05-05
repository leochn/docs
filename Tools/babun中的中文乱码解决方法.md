# babun中的中文乱码解决方法

<!-- toc -->

```
cygwin babun中的中文乱码解决方法，默认babun安装完后使用的系统字符集是en_US.UTF-8 ，字符集默认是可以显示中文的。
```


### 新思路:

```
但是使用ping 等一些网络命令的时候，是要调用系统命令来执行，这个字体编码是gbk所以会出现乱码，但是你要去调整babun的字符集的话，在查看系统里面的中文又是乱码，其实查看很多资料所说的解决办法都是不行的。
新的思路：
是否可以在babun中改变一下，windows系统的编码默认是用utf-8来进行调用呢？测试下，windows 下修编码模式命令为chcp修改命令为
{ d } » chcp 65001
Active code page: 65001
表示已经成功再次执行ping命令
{ d } » ping baidu.com
Pinging baidu.com [220.181.57.217] with 32 bytes of data:
Reply from 220.181.57.217: bytes=32 time=30ms TTL=55
一切正常了，希望加入启动后直接加载
{ d }  » vi ~/.bahunrc
在打开的文件里面加入
chcp 65001
每次打开都可以正常加载这个配置了，如果是cygwin可以直接放在.bashrc里面就可以的。
```
