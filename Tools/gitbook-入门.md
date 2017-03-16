# GitBook入门

<!-- toc -->

GitBook 是一个命令行工具。通过它，你能够使用 Git 和 Markdown 来编排书本。并且通过工具可以自动生成相应的 HTML、PDF 和 epub 格式的文件。

## 安装

因为 GitBook 是一个基于 Node 开发的命令行工具。因此需要您自行配置 Node 和 npm 环境。如果你已经安装好这些环境之后，GitBook 的安装只需要一步就能完成！
```
$ npm install gitbook -g 
$ npm install gitbook-cli -g  //在全局安装 gitbook 客户端工具
```

## 使用

GitBook 的用法非常简单，老规矩，先看一下我们都有哪些命令可以使用

```
$ git help
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
```

实际上我们最常用的命令只有两个:
```
gitbook init   //初始化书籍目录
gitbook serve  //在编写书籍时启动一个服务器，自动编译&更新内容，并在浏览器中预览
```

首先，通过终端(PC 下可使用命令提示符)进入到你想要书写内容的目录，然后执行 ```gitbook init``` 命令，之后目录中会自动生成 README.md 和 SUMMARY.md 两个文件。

这两个文件在 GitBook 项目中是必须存在的，其中 README.md 是对书籍的简单介绍，SUMMARY.md 是对书籍目录的描述，并且 GitBook 会通过该文件中的目录描述自动生成对应的目录和文件。

其中，SUMMARY.md 文件中内容的格式是这样的:
```
* [Chapter1](chapter1/README.md)
  * [Section1.1](chapter1/section1.1.md)
  * [Section1.2](chapter1/section1.2.md)
* [Chapter2](chapter2/README.md)
```

当你修改了 SUMMARY.md 文件中的内容后，你可以再次使用 ```gitbook init``` 来自动生成对应的目录和文件。

```gitbook serve```

书籍目录结构创建完成以后，我们就可以使用 ```gitbook serve``` 来编译和预览书籍了：

```gitbook serve``` 命令实际上会首先调用 ```gitbook build``` 编译书籍，完成以后会打开一个 web 服务器，监听在本地的 4000 端口。

```
$ gitbook serve
Live reload server started on port: 35729
Press CTRL+C to quit ...

info: 7 plugins are installed
info: loading plugin "livereload"... OK
info: loading plugin "highlight"... OK
info: loading plugin "search"... OK
info: loading plugin "lunr"... OK
info: loading plugin "sharing"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-default"... OK
info: found 5 pages
info: found 4 asset files
info: >> generation finished with success in 3.0s !

Starting server ...
Serving book on http://localhost:4000

```

之后，你就可以使用浏览器打开 ```http://127.0.0.1:4000``` 查看效果了。就是这么简单。

gitbook启动的web 服务默认监听4000端口，而重启监控进程默认监听35729端口。

如果要启动另一部电子书服务的话， 就需要同时修改web端口和监控进程端口，类似这样:
```
gitbook serve --lrport 35288 --port 4001
```
之后，你就可以使用浏览器打开 ```http://127.0.0.1:4001``` 查看效果了。

## 使用插件

Gitbook 本身功能丰富，但同时可以使用插件来进行个性化定制。 Gitbook 插件 里已经有100多个插件，可以在 book.json 文件的 plugins 和 pluginsConfig 字段添加插件及相关配置，添加后别忘了进行安装。
```
{
    "title": "leo-notes",
    "description": "notes",
    "plugins": [
        "toc",
        "back-to-top-button",
        "toggle-chapters",
        "search-plus",
        "-sharing",
        "mtime",
        "popup"
    ],
    "pluginsConfig": {},
    "version": "v0.1.0"
}
```

安装插件
```$ gitbook install ./```