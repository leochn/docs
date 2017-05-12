# node-更改npm全局模块和cache默认安装位置

<!-- toc -->

## 1.引言
```
全局：执行npm  install  <模块的名字>  -g 就会将模块装在全局路径下，当用户在程序中require(<模块的名字>)的时候不用考虑模块在哪，如果不修改全局路径，用户下载的模块会默认在C:\Users\Administrator\AppData\Roaming\npm这个路径下。

局部：执行npm  install  <包的名字>（注意少了-g）就会将模块安装在dos窗当前指向的路径下，这时候其他路径项目无法引用到该版本的模块！
```

## 2.修改默认的全局路径
```
先配置npm的全局模块(node_global)的存放路径以及缓存(global_cache)的路径，例如我希望将以上两个文件夹放在%nodejs%\node_modules下
1）在D:\develop\node\node_modules\下建立"node_global"及"node_cach"e两个文件夹。D:\develop\node 为安装路径。
2）在DOS窗中执行：
npm config set prefix "D:\develop\node\node_modules\node_global"
npm config set cache "D:\develop\node\node_modules\node_cache"

如果这种方法无法修改还可以：
在nodejs的安装目录"D:\develop\node\node_modules\npm"中找到npmrc文件
修改如下即可：
prefix=D:\develop\node\node_modules\node_global
cache=D:\develop\node\node_modules\node_cache
```

## 3.修改环境变量
```
新建一个名为NODE_PATH的变量 ---> NODE_PATH="D:\develop\node"
在path中添加: %NODE_PATH%\;%NODE_PATH%\node_modules\node_global;
```





















