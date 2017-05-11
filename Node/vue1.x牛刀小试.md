vue1.x牛刀小试

<!-- toc -->


## 1.基础知识
```
vue-loader:
    其他loader ->  css-loader、url-loader、html-loader.....

    后台: nodeJs  ->  require  exports
    broserify  模块加载，只能加载js
    webpack   模块加载器， 一切东西都是模块, 最后打包到一块了

    require('style.css');   ->   css-loader、style-loader

    
    vue-loader基于webpack
```

```
    XXX.vue文件:放置的是vue组件代码,格式如下:
        <template>
            html代码
        </template>
    
        <style>
            css代码
        </style>
    
        <script>
            js（平时代码、ES6）    babel-loader
        </script>
--------------------------------------------
ES6: 模块化开发
    导出模块：
        export default {}
    引入模块:
        import 模块名 from 地址
--------------------------------------------
```

## 2.vue-loader-demo
```
创建vue-loader-demo文件夹,
准备如下简单的目录结构:
    |-index.html
    |-main.js   入口文件
    |-App.vue   vue文件，官方推荐命名法,首字母大写
    |-package.json  工程文件(项目依赖、名称、配置)
        npm init --yes 来生成
    |-webpack.config.js webpack配置文件
```

### 2.0 App.veu文件的结构为:
```
<template>
    <h1>welcome Vue</h1>
</template>
<script>

</script>
<style>

</style>
```

### 2.1 main.js
```
main.js为入口函数,为什么呢?是通过webpack.config.js来配置的。
```
### 2.2 webpack.config.js

### 2.3 index.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    <div id='app'></div>
    <script src="build.js"></script>
</body>
</html>
```
### 2.4 创建 package.json
```bash
 ## cd vue-loader-demo
leo@lenovo MINGW64 /d/worksapce-node/vue-loader-demo
$ npm init --yes
Wrote to D:\worksapce-node\vue-loader-demo\package.json:

{
  "name": "vue-loader-demo",
  "version": "1.0.0",
  "description": "",
  "main": "main.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```
### 2.5 webpak准备工作
```
    cnpm install webpack --save-dev
    cnpm install webpack-dev-server --save-dev
    其中：  
        --save-dev 是把需要下载的资源保存到,package.json文件中devDependencies依赖中,下次只要运行npm install 就可以自动安装。
        --save 是把需要下载的资源保存到,package.json文件中dependencies依赖中。

    App.vue -> 变成正常代码,需要    vue-loader@8.5.4
    cnpm install vue-loader@8.5.4 --save-dev

    还需要其他loader:
    vue-html-loader、css-loader、vue-style-loader、
    vue-hot-reload-api@1.3.2

    ES6相关的babel:
    babel-loader
    babel-core
    babel-plugin-transform-runtime
    babel-preset-es2015
    babel-runtime
```

### 2.6 install包
```
leo@lenovo MINGW64 /d/worksapce-node/vue-loader-demo
$ cnpm install webpack webpack-dev-server --save-dev
platform unsupported webpack-dev-server@2.4.5 › chokidar@1.7.0 › fsevents@^1.0.0 Package require os(darwin) not compatible with your platform(win32)
[fsevents@^1.0.0] optional install error: Package require os(darwin) not compatible with your platform(win32)
√ Installed 2 packages
√ Linked 278 latest versions
√ Run 0 scripts
Recently updated (since 2017-05-05): 9 packages (detail see file D:\worksapce-node\vue-loader-demo\node_modules\.recently_updates.txt)
  Today:
    → webpack-dev-server@2.4.5 › webpack-dev-middleware@1.10.2 › mime@^1.3.4(1.3.5) (02:18:17)
    → webpack@2.5.1 › node-libs-browser@2.0.0 › crypto-browserify@3.11.0 › pbkdf2@^3.0.3(3.0.12) (02:52:20)
√ All packages installed (301 packages installed from npm registry, used 27s, speed 223.04kB/s, json 326(530.68kB), tarball 5.39MB)
```

#### 2.6.1 安装之后,再package.json文件中,就有devDependencies依赖
```json
{
  "name": "vue-loader-demo",
  "version": "1.0.0",
  "description": "",
  "main": "main.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "webpack": "^2.5.1",
    "webpack-dev-server": "^2.4.5"
  }
}
```

#### 2.6.2 安装其他包
```

```























