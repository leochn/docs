# vue1.x牛刀小试

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
```js
//main.js为入口函数,为什么呢?是通过webpack.config.js来配置的。
import Vue from 'vue'
import App from './App.vue'

new Vue({
    el:'body',
    components:{
        app:App
    }
});
```
### 2.2 webpack.config.js
```js
module.exports={
    entry:'./main.js',

    output:{
        path:__dirname,
        filename:'build.js'
    }

    //加载loaders配置
    module:{
        loaders:[
            {test:/\.vue$/,loader:'vue'}, //对.vue结尾的文件进行vue-loader
            {test:/\.js$/,loader:'babel',exclude:/node_modules/} //排除node_modules文件下的所有.js文件
        ]
    },
    //es6
    babel:{
        presets:['es2015'],
        plugins:['transform-runtime']
    }
}
```

### 2.3 index.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    <app></app>
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
```bash
lij01@SH-RAD02-V17 MINGW64 /d/workspace-node/vue-demo
$ cnpm install webpack@1.13.3 webpack-dev-server@1.16.2 --save-dev
platform unsupported webpack@1.13.3 › watchpack@0.2.9 › chokidar@1.7.0 › fsevents@^1.0.0 Package require os(darwin) not compatible with your platform(win32)
[fsevents@^1.0.0] optional install error: Package require os(darwin) not compatible with your platform(win32)
√ Installed 2 packages
√ Linked 195 latest versions
√ Run 0 scripts
Recently updated (since 2017-05-05): 3 packages (detail see file D:\workspace-node\vue-demo\node_modules\.recently_updates.txt)
  Today:
    → webpack-dev-server@1.16.2 › webpack-dev-middleware@1.10.2 › mime@^1.3.4(1.3.5) (02:18:17)
√ All packages installed (222 packages installed from npm registry, used 4s, speed 89kB/s, json 234(379.69kB), tarball 0B)

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
    "webpack": "^1.13.3",
    "webpack-dev-server": "^1.16.2"
  }
}
```

#### 2.6.2 安装其他包
```
    cnpm install vue-loader@8.5.4 vue-html-loader@1.2.3 css-loader@0.25.0 vue-style-loader@1.0.0 vue-hot-reload-api@1.3.2 --save-dev

    cnpm install babel-loader@6.2.5 babel-core@6.17.0 babel-plugin-transform-runtime@6.15.0 babel-preset-es2015@6.16.0 babel-runtime@6.11.6 --save-dev

    npm install vue@1.0.28 --save
```

#### 2.6.3 修改package.json文件中的scripts
```js
"scripts": {
    "dev": "webpack-dev-server --inline --hot --port 8082"
  },
```

#### 2.6.4 运行
```bash
# npm run dev:相当于运行package.json文件中scripts脚本中的dev
npm run dev
```

#### 2.6.5 运行效果
```
浏览器中输入 http://localhost:8082/ , 可以看到 welcome Vue
```

#### 2.6.6 上线:npm run build
```js
  // package.json 中配置
  "scripts": {
    "dev": "webpack-dev-server --inline --hot --port 8082",
    "build":"webpack -p"  //上线使用npm run build
  },
```

## 3.脚手架
### 3.1 vue-cli:vue脚手架
```
vue-cli:vue脚手架,帮你提供好基本项目结构
```

### 3.2 项目模板
```
  simple    个人觉得一点用都没有
  webpack 可以使用(大型项目)
      Eslint 检查代码规范，
      单元测试
  webpack-simple  个人推荐使用, 没有代码检查  √

  browserify  ->  自己看
  browserify-simple
```

### 3.3 基本使用流程:
```
1. npm install vue-cli -g 安装 vue命令环境
  验证安装ok?
    vue --version
2. 生成项目模板
  vue init <模板名> 本地文件夹名称
  其中:<模板名> 就是指3.2中的simple、webpack等项目模板。
3. 进入到生成目录里面
  cd xxx
  npm install
4. npm run dev
```











