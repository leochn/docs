# vue1.x入门

<!-- toc -->

## 1.vue:
```
    vue到底是什么?
        一个mvvm框架(库)、和angular类似
        比较容易上手、小巧
    mvc:
        mvp
        mvvm
        mv*
        mvx
    官网:http://cn.vuejs.org/ 
    手册： http://cn.vuejs.org/api/
```
## 2.vue和angular区别
```
    vue――简单、易学
        指令以 v-xxx
        一片html代码配合上json，在new出来vue实例
        个人维护项目

        适合: 移动端项目,小巧

        vue的发展势头很猛，github上start数量已经超越angular
    angular――上手难
        指令以 ng-xxx
        所有属性和方法都挂到$scope身上
        angular由google维护
        
        合适: pc端项目

    共同点: 不兼容低版本IE
```
## 3.vue基本雏形
```
    angular展示一条基本数据:
        var app=angular.module('app',[]);

        app.controller('xxx',function($scope){  //C
            $scope.msg='welcome'
        })

        html:
        div ng-controller="xxx"
            {{msg}}
    vue:
        html:
            <div id="box">
                {{msg}}
            </div>

            var c=new Vue({
                el:'#box',  //选择器  class tagName
                data:{
                    msg:'welcome vue'
                }
            });
```

双向数据绑定

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>vue</title>
    <script src="vue.js"></script>
    <script>
        window.onload = function(){
            //var V = new Vue({});
            new Vue({
                el:'#box', // 选择器  class tagName
                data:{
                    msg:'welcome vue'
                }
            });
        };
    </script>
</head>
<body>
    <div id='box'>
        {{msg}}
    </div>
</body>
</html>
```

## 4.常用指令
```
    angular: 
         ng-model   ng-controller
         ng-repeat
         ng-click
         ng-show  

        $scope.show=function(){}
------------------------------------
    指令: 扩展html标签功能,属性
```
### 4.1双向数据绑定
```
   v-model 一般表单元素(input),双向数据绑定:
   <input type="text" v-model="msg">
```
### 4.2循环:
```
        new Vue({
                el:'#box',
                data:{
                    arr:['apple','banana','orange','pear'],
                    json:{a:'apple',b:'banana',c:'orange'}
                }
            });
        --------------------    
        <ul>
            <li v-for="value in arr">
                {{value}}   {{$index}}
            </li>
        </ul>
        --------------
        v-for="name in json"
            {{value}}   {{$index}}  {{$key}}
        --------------
        v-for="(k,v) in json"
            {{k}}   {{v}}   {{$index}}  {{$key}}

```
### 4.3事件:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{ //数据
                    arr:['apple','banana','orange','pear'],
                    json:{a:'apple',b:'banana',c:'orange'}
                },
                methods:{
                    add:function(){
                        this.arr.push('tomato');
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="按钮" v-on:click="add()">
        <br>
        <ul>
            <li v-for="value in arr">
                {{value}}
            </li>
        </ul>
    </div>
</body>
</html>
```

```
        v-on:click="函数"
        v-on:click="show()"
        v-on:click/mouseout/mouseover/dblclick/mousedown.....
```

显示隐藏:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{ //数据
                    a:true
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="按钮" v-on:click="a=false">
        <div style="width:100px; height:100px; background: red" v-show="a">

        </div>
    </div>
</body>
</html>
```

## 5.事件详解
### 5.1事件对象

@click="show($event)" ,事件对象:$event

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                methods:{
                    show:function(ev){
                        alert(ev.clientX);
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="按钮" @click="show($event)">
    </div>
</body>
</html>
```

### 5.2事件冒泡
概念

```
事件冒泡:先child,然后parent.事件的触发顺序自内向外,这就是事件冒泡
```

阻止事件冒泡

```
  a). ev.cancelBubble=true;
  b). @click.stop="show()" 推荐
```

举例

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                methods:{
                    show:function(ev){
                        alert(1);
                        ev.cancelBubble=true;
                    },
                    show2:function(){
                        alert(2);
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <div @click="show2()">
            <input type="button" value="按钮" @click="show($event)">
        </div>
    </div>
</body>
</html>
```

### 5.3默认事件(鼠标右键事件)
阻止默认行为:

```
    a). ev.preventDefault();
    b). @contextmenu.prevent="show()"   推荐
```

example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                methods:{
                    show:function(){
                        alert(1);
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="按钮" @contextmenu.prevent="show()">
    </div>
</body>
</html>
```
### 5.4键盘事件
```
键盘:
    @keydown    $event  ev.keyCode
    @keyup

    常用键:
        回车
            a). @keyup.13
            b). @keyup.enter
        上、下、左、右
            @keyup/keydown.left
            @keyup/keydown.right
            @keyup/keydown.up
            @keyup/keydown.down
```

example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                methods:{
                    show:function(){
                        alert(1);
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="text" @keyup.left="show()">
    </div>
</body>
</html>
```
### 5.5事件深入

```

```

## 6.属性:
```
    v-bind:src=""
        width/height/title....
    
    简写:
    :src="" 推荐

    <img src="{{url}}" alt="">  效果能出来，但是会报一个404错误
    <img v-bind:src="url" alt="">   效果可以出来，不会发404请求
```

example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    url:'https://www.baidu.com/img/bd_logo1.png',
                    w:'200px',
                    t:'这是一张美丽的图片'
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <!--<img src="{{url}}" alt="">-->
        <img :src="url" alt="" :width="w" :title="t">
    </div>
</body>
</html>
```

## 7.class
概况
```
    :class=""   v-bind:class=""
    :style=""   v-bind:style=""

    :class="[a]"  a是数据
    :class="[a,b,c,d]"
    
    :class="{red:a, blue:false}"

    :class="json"
        
        data:{
            json:{red:a, blue:false}
        }
```

:class="[a,b,c,d]",a是数据

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .red{
            color: red;
        }
        .blue{
            background: blue;
        }
    </style>
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    a:'red',
                    b:'blue'
                },
                methods:{
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <strong :class="[a,b]">文字...</strong>
    </div>
</body>
</html>
```

example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .red{
            color: red;
        }
        .blue{
            background: blue;
        }
    </style>
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    json:{
                        red:true,
                        blue:true
                    }
                },
                methods:{
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <strong :class="json">文字...</strong>
    </div>
</body>
</html>
```

## 8.style
```
    style:
    :style="[c]"
    :style="[c,d]"
        注意:  复合样式，采用驼峰命名法
    :style="json"
```

example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .red{
            color: red;
        }
        .blue{
            background: blue;
        }
    </style>
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    c:{color:'red'},
                    b:{backgroundColor:'blue'}
                },
                methods:{
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <strong :style="[c,b]">文字...</strong>
    </div>
</body>
</html>
```

## 模板:
```
    {{msg}}     数据更新模板变化
    {{*msg}}    数据只绑定一次
    
    {{{msg}}}   HTML转意输出
```

example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .red{
            color: red;
        }
        .blue{
            background: blue;
        }
    </style>
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    msg:'abc'
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="text" v-model="msg">
        <br>
        {{msg}}
        <br>
        {{*msg}}
        <br>
        <!-- 输入:<h3>hello</h3>,这里输出hello -->
        {{{msg}}}
    </div>
</body>
</html>
```
## 过滤器:-> 过滤模板数据
```
    -----------------------------
    <div id="box">
        {{'welcome'|uppercase}}
        <br>
        {{'WELCOME'|lowercase}}
    </div>
    -----------------------------
    系统提供一些过滤器:
    {{'welcome'|uppercase}}
    {{'WELCOME'|lowercase}}

    {{msg| filterA}}
    {{msg| filterA | filterB}}

    uppercase   eg: {{'welcome'| uppercase}}
    lowercase
    capitalize  eg: {{'WELCOME'|lowercase|capitalize}}

    currency    钱
    {{12|currency '￥'}}

    {{msg| filterA 参数}}

    ....
```
## 交互:
```
    $http   （ajax）
    如果vue想做交互,需要引入vue-resouce.js

    get:
        获取一个普通文本数据:
        this.$http.get('aa.txt').then(function(res){
            alert(res.data);
        },function(res){
            alert(res.status);
        });
        给服务发送数据:√ 推荐
        this.$http.get('get.php',{
            a:1,
            b:2
        }).then(function(res){
            alert(res.data);
        },function(res){
            alert(res.status);
        });
    post:
        this.$http.post('post.php',{
            a:1,
            b:20
        },{
            emulateJSON:true
        }).then(function(res){
            alert(res.data);
        },function(res){
            alert(res.status);
        });
    jsonp:
        https://sug.so.360.cn/suggest?callback=suggest_so&word=a

        https://sp0.baidu.com/5a1Fazu8AA54nxGko9WTAnF6hhy/su?wd=a&cb=jshow

        this.$http.jsonp('https://sp0.baidu.com/5a1Fazu8AA54nxGko9WTAnF6hhy/su',{
            wd:'a'
        },{
            jsonp:'cb'  //callback名字，默认名字就是"callback"
        }).then(function(res){
            alert(res.data.s);
        },function(res){
            alert(res.status);
        });
        
https://www.baidu.com/s?wd=s
```

example

```html
<!-- 进行http请求必须启动服务,否则会出现如下错误:
XMLHttpRequest cannot load http://localhost:8085/alarms. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access.
XMLHttpRequest cannot load file:///D:/workspace-neon/vdemo/src/main/webapp/static/json/alarm.json. Cross origin requests are only supported for protocol schemes: http, data, chrome, chrome-extension, https.
 -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="static/js/vue.js"></script>
    <script src="static/js/vue-resource.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'body',
                data:{

                },
                methods:{
                    get:function(){
                        this.$http.get('http://localhost:8085/alarms').then(function(res){
                            console.log("res.data.msg:" + res.data.msg);
                        },function(res){
                            //alert(res.data);
                        });
                    },
                     get2:function(){
                        this.$http.get('static/json/alarm.json').then(function(res){
                            console.log("res.data[0].alarmTypeId=" + res.data[0].alarmTypeId);
                        },function(res){
                            //alert(res.data);
                        });
                    }
                }
            });
        };
    </script>
</head>
<body>
    <input type="button" value="按钮" @click="get()">
    <br>
    <input type="button" value="按钮2" @click="get2()">
</body>
</html>
```
























