# vue1.x入门
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

* 显示隐藏:
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

```html

```

### 5.2事件冒泡
```
事件冒泡:
```

### 5.3默认事件

### 5.4键盘事件

### 5.5事件深入

```
    v-on:click/mouseover......
    
    简写的:
    @click=""       推荐

    事件对象:
        @click="show($event)"
    事件冒泡:
        阻止冒泡:  
            a). ev.cancelBubble=true;
            b). @click.stop 推荐
    默认行为(默认事件):
        阻止默认行为:
            a). ev.preventDefault();
            b). @contextmenu.prevent    推荐
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
            .....
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

## 7.class:
```
    :class=""   v-bind:class=""
    :style=""   v-bind:style=""

    :class="[red]"  red是数据
    :class="[red,b,c,d]"
    
    :class="{red:a, blue:false}"

    :class="json"
        
        data:{
            json:{red:a, blue:false}
        }
```
## 8.style
```
    style:
    :style="[c]"
    :style="[c,d]"
        注意:  复合样式，采用驼峰命名法
    :style="json"
```

## 模板:
```
    {{msg}}     数据更新模板变化
    {{*msg}}    数据只绑定一次
    
    {{{msg}}}   HTML转意输出
```
## 过滤器:-> 过滤模板数据
```
    系统提供一些过滤器:
    
    {{msg| filterA}}
    {{msg| filterA | filterB}}

    uppercase   eg: {{'welcome'| uppercase}}
    lowercase
    capitalize

    currency    钱

    {{msg| filterA 参数}}

    ....
```
## 交互:
```
    $http   （ajax）

    如果vue想做交互

    引入: vue-resouce

    get:
        获取一个普通文本数据:
        this.$http.get('aa.txt').then(function(res){
            alert(res.data);
        },function(res){
            alert(res.status);
        });
        给服务发送数据:√
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
























