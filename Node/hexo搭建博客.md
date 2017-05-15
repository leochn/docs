# hexo搭建博客

<!-- toc -->

## 0.准备工作
```
1.node：用来生成静态页面的,到Node.js官网下载相应平台的最新版本,一路安装即可。

2.git: 把本地的hexo内容提交到github上去.

3.github：用来做博客的远程创库、域名、服务器。（~不多说了）

然后你还要知道一点点linux命令，域名解析相关知识（以上条件你都达到了，那么恭喜你30分钟搭建倒计时开始~）
```

## 1 安装Hexo
### 1.1 ```安装hexo-cli:``` ```npm install hexo-cli -g```
```
D:\worksapce-node\hexo>npm install hexo-cli -g
C:\Users\leo\AppData\Roaming\npm\hexo -> C:\Users\leo\AppData\Roaming\npm\node_modules\hexo-cli\bin\hexo

> dtrace-provider@0.8.1 install C:\Users\leo\AppData\Roaming\npm\node_modules\hexo-cli\node_modules\dtrace-provider
> node scripts/install.js


> hexo-util@0.6.0 postinstall C:\Users\leo\AppData\Roaming\npm\node_modules\hexo-cli\node_modules\hexo-util
> npm run build:highlight


> hexo-util@0.6.0 build:highlight C:\Users\leo\AppData\Roaming\npm\node_modules\hexo-cli\node_modules\hexo-util
> node scripts/build_highlight_alias.js > highlight_alias.json

C:\Users\leo\AppData\Roaming\npm
`-- hexo-cli@1.0.2
  +-- abbrev@1.1.0
  +-- bluebird@3.5.0
  +-- chalk@1.1.3
  | +-- ansi-styles@2.2.1
  | +-- escape-string-regexp@1.0.5
  | +-- has-ansi@2.0.0
  | | `-- ansi-regex@2.1.1
  | +-- strip-ansi@3.0.1
  | `-- supports-color@2.0.0
  +-- hexo-fs@0.1.6
  | +-- chokidar@1.7.0
  | | +-- anymatch@1.3.0
  | | | +-- arrify@1.0.1
  | | | `-- micromatch@2.3.11
  | | |   +-- arr-diff@2.0.0
  | | |   | `-- arr-flatten@1.0.3
  | | |   +-- array-unique@0.2.1
  | | |   +-- braces@1.8.5
  | | |   | +-- expand-range@1.8.2
  | | |   | | `-- fill-range@2.2.3
  | | |   | |   +-- is-number@2.1.0
  | | |   | |   +-- isobject@2.1.0
  | | |   | |   +-- randomatic@1.1.6
  | | |   | |   `-- repeat-string@1.6.1
  | | |   | +-- preserve@0.2.0
  | | |   | `-- repeat-element@1.1.2
  | | |   +-- expand-brackets@0.1.5
  | | |   | `-- is-posix-bracket@0.1.1
  | | |   +-- extglob@0.3.2
  | | |   +-- filename-regex@2.0.1
  | | |   +-- kind-of@3.2.0
  | | |   | `-- is-buffer@1.1.5
  | | |   +-- normalize-path@2.1.1
  | | |   | `-- remove-trailing-separator@1.0.1
  | | |   +-- object.omit@2.0.1
  | | |   | +-- for-own@0.1.5
  | | |   | | `-- for-in@1.0.2
  | | |   | `-- is-extendable@0.1.1
  | | |   +-- parse-glob@3.0.4
  | | |   | +-- glob-base@0.3.0
  | | |   | `-- is-dotfile@1.0.2
  | | |   `-- regex-cache@0.4.3
  | | |     +-- is-equal-shallow@0.1.3
  | | |     `-- is-primitive@2.0.0
  | | +-- async-each@1.0.1
  | | +-- glob-parent@2.0.0
  | | +-- inherits@2.0.3
  | | +-- is-binary-path@1.0.1
  | | | `-- binary-extensions@1.8.0
  | | +-- is-glob@2.0.1
  | | | `-- is-extglob@1.0.0
  | | +-- path-is-absolute@1.0.1
  | | `-- readdirp@2.1.0
  | |   +-- minimatch@3.0.4
  | |   | `-- brace-expansion@1.1.7
  | |   |   +-- balanced-match@0.4.2
  | |   |   `-- concat-map@0.0.1
  | |   +-- readable-stream@2.2.9
  | |   | +-- buffer-shims@1.0.0
  | |   | +-- core-util-is@1.0.2
  | |   | +-- isarray@1.0.0
  | |   | +-- process-nextick-args@1.0.7
  | |   | +-- string_decoder@1.0.0
  | |   | `-- util-deprecate@1.0.2
  | |   `-- set-immediate-shim@1.0.1
  | `-- graceful-fs@4.1.11
  +-- hexo-log@0.1.2
  | `-- bunyan@1.8.10
  |   +-- dtrace-provider@0.8.1
  |   | `-- nan@2.6.2
  |   +-- moment@2.18.1
  |   +-- mv@2.1.1
  |   | +-- mkdirp@0.5.1
  |   | | `-- minimist@0.0.8
  |   | +-- ncp@2.0.0
  |   | `-- rimraf@2.4.5
  |   |   `-- glob@6.0.4
  |   |     +-- inflight@1.0.6
  |   |     | `-- wrappy@1.0.2
  |   |     `-- once@1.4.0
  |   `-- safe-json-stringify@1.0.4
  +-- hexo-util@0.6.0
  | +-- camel-case@3.0.0
  | | +-- no-case@2.3.1
  | | | `-- lower-case@1.1.4
  | | `-- upper-case@1.1.3
  | +-- cross-spawn@4.0.2
  | | +-- lru-cache@4.0.2
  | | | +-- pseudomap@1.0.2
  | | | `-- yallist@2.1.2
  | | `-- which@1.2.14
  | |   `-- isexe@2.0.0
  | +-- highlight.js@9.11.0
  | +-- html-entities@1.2.1
  | `-- striptags@2.2.1
  +-- minimist@1.2.0
  +-- object-assign@4.1.1
  `-- tildify@1.2.0
    `-- os-homedir@1.0.2

npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@^1.0.0 (node_modules\hexo-cli\node_modules\chokidar\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.1.1: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})

D:\worksapce-node\hexo>
```

### 1.2 可能你会有WARN,但不用担心,这不会影响你的正常使用,然后安装hexo
```
npm install hexo -g
```


### 1.3 hexo版本查看
```
leo@lenovo MINGW64 /d/worksapce-node
$ hexo -v
hexo: 3.3.5
hexo-cli: 1.0.2
os: Windows_NT 10.0.14393 win32 x64
http_parser: 2.7.0
node: 6.10.2
v8: 5.1.281.98
uv: 1.9.1
zlib: 1.2.11
ares: 1.10.1-DEV
icu: 58.2
modules: 48
openssl: 1.0.2k

```

## 2. 创建hexo项目
### 2.1 新建hexo文件夹,并进行init
```
leo@lenovo MINGW64 /d/worksapce-node
$ cd hexo/

leo@lenovo MINGW64 /d/worksapce-node/hexo
$ hexo init
```

### 2.2 安装依赖包
```
cnpm install
```

### 2.3 运行hexo,默认的4000端口可能会被占用,端口修改为8089
```
leo@lenovo MINGW64 /d/worksapce-node/hexo
$ hexo s -g -p 8089
INFO  Start processing
INFO  Hexo is running at http://localhost:8089/. Press Ctrl+C to stop.
```

### 2.4 运行效果
![hexo效果](./images/hexo-001.PNG)

### 2.5 修改主题样式

### 2.6 创建自己的博客
```
http://www.cnblogs.com/dantefung/p/d8c48ba8030bcab7cfc364d423186fee.html

http://hifor.net/2015/07/01/%E9%9B%B6%E5%9F%BA%E7%A1%80%E5%85%8D%E8%B4%B9%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2-hexo-github/


```

## 3. hexo发布到github中


## 4. hexo的github站点绑定自己的域名


## 5. 让goole和baidu能搜索到自己的博客