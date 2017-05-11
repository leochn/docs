# subliem之配置

<!-- toc -->

## 使用Package Control组件安装
* 1.按Ctrl+`调出console（注：安装有QQ输入法的这个快捷键会有冲突的，输入法属性设置-输入法管理-取消热键切换至QQ拼音）
* 2.粘贴以下代码到底部命令行并回车：
```
import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
```

## subliem之markdown配置
* 安装如下包:
```
MarkdownEditing
OmniMarkupPreviewer
```

* 优雅的设置markdown:Preferences → Package Setting → Markdown Editing → Markdown GFM Settings-User,配置如下
```
{
    "extensions":
    [
        "md"
    ],

    //"color_scheme": "Packages/MarkdownEditing/MarkdownEditor.tmTheme",
    "color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",
    // "color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Yellow.tmTheme",

    "line_padding_top": 4,
    "line_padding_bottom": 4,

    "tab_size": 4,
    "translate_tabs_to_spaces": true,

    "draw_centered": false,
    "word_wrap": true,
    "wrap_width": 80,
    "rulers": [60, 160]
}
```

## subliem之字体设置
* Preferences → Settings → User
```
{
    "color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",
    "default_encoding": "UTF-8",
    "font_face": "Consolas",
    "font_options":
    [
        "no_bold",
        "no_italic",
        "antialias",
        "no_gray_antialias"
    ],
    // 参数说明：
    //no_bold：不是粗体显示；
    //no_italic：不是斜体显示（也叫意大利字体样式显示）；
    //no_antialias：无反图像失真或反锯齿显示；
    //gray_antialias"；反图像灰度值失真显示；
    //以上参数去掉no_或不写入得相反效果
    "font_size": 12,
    "ignored_packages":
    [
        "Vintage"
    ]
}
```

## 其他插件

```
SideBarEnhancements：鼠标侧边栏右键增强菜单
LESS：LESS高亮插件
Doc​Blockr：生成优美注释
Color​Picker：调色板
ConvertToUTF8：文件转码成utf-8
AutoFileName：快捷输入文件名
Nodejs：node代码提示
IMESupport：解决Sublime Text 中文输入法不能跟随光标的问题，需要安装搜狗输入法
FileDiffs：强大的比较代码不同工具
Vue Syntax Highlight: vue插件
```


## 更多请查看```https://packagecontrol.io/```
