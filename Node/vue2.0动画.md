# vue2.0动画

<!-- toc -->

## 1. 动画transtiton
### 1.1 transition之前,为属性
```
<p transition="fade"></p>

.fade-transition{}
.fade-enter{}
.fade-leave{}
```

### 1.2 到2.0以后transition为组件
```
<transition name="fade">
    运动东西(元素，属性、路由....)
</transition>

class定义:
.fade-enter{}   //初始状态
.fade-enter-active{}  //变化成什么样  ->  当元素出来(显示)

.fade-leave{}
.fade-leave-active{} //变成成什么样   -> 当元素离开(消失)

如何animate.css配合用？
    <transition enter-active-class="animated zoomInLeft" leave-active-class="animated zoomOutRight">
                <p v-show="show"></p>
            </transition>

多个元素运动:
    <transition-group enter-active-class="" leave-active-class="">
        <p :key=""></p>
        <p :key=""></p>
    </transition-group>
```

### 1.3 transition动画
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        p{
            width:300px;
            height:300px;
            background: red;
        }
        .fade-enter-active, .fade-leave-active{
            transition: 1s all ease;
        }

        .fade-enter-active{
            opacity:1;
            width:300px;
            height:300px;
        }
        .fade-leave-active{
            opacity:0;
            width:100px;
            height:100px;
        }

        .fade-enter{
            opacity:0;
            width:100px;
            height:100px;
        }
    </style>
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    show:false
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="点击显示隐藏" @click="show=!show">

        <transition name="fade">
            <p v-show="show"></p>
        </transition>
    </div>
</body>
</html>
```

### 1.4 transition的相关函数
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>transition</title>
    <style>
        p{
            width:300px;
            height:300px;
            background: red;
        }
        .fade-enter-active, .fade-leave-active{
            transition: 1s all ease;
        }

        .fade-enter-active{
            opacity:1;
            width:300px;
            height:300px;
        }
        .fade-leave-active{
            opacity:0;
            width:100px;
            height:100px;
        }

        .fade-enter,.fade-leave{
            opacity:0;
            width:100px;
            height:100px;
        }
    </style>
    <script src="vue.js"></script>
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    show:false
                },
                methods:{
                    beforeEnter(el){
                        console.log('动画enter之前');
                    },
                    enter(el){
                        console.log('动画enter进入');
                    },
                    afterEnter(el){
                        console.log('动画进入之后');
                        el.style.background='blue';
                    },
                    beforeLeave(el){
                        console.log('动画leave之前');
                    },
                    leave(el){
                        console.log('动画leave');
                    },
                    afterLeave(el){
                        console.log('动画leave之后');
                        el.style.background='red';
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="点击显示隐藏" @click="show=!show">
        <transition name="fade"
            @before-enter="beforeEnter"
            @enter="enter"
            @after-enter="afterEnter"

            @before-leave="beforeLeave"
            @leave="leave"
            @after-leave="afterLeave"
        >
            <p v-show="show"></p>
        </transition>
    </div>
</body>
</html>
```

### 1.5 transition配合animate
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        p{
            width:150px;
            height:150px;
            background: red;
            margin:0 auto;
        }
    </style>
    <script src="vue.js"></script>
    <link rel="stylesheet" href="animate.css">
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    show:false
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="点击显示隐藏" @click="show=!show">

        <transition enter-active-class="animated zoomInLeft" leave-active-class="animated zoomOutRight">
            <p v-show="show"></p>
        </transition>

        <!-- 或者是如下写法 -->
        <!-- <transition enter-active-class="zoomInLeft" leave-active-class="zoomOutRight">
            <p v-show="show" class="animated"></p>
        </transition> -->
    </div>
</body>
</html>
```

### 1.6 transition多个元素
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        p{
            width:100px;
            height:100px;
            background: red;
            margin:10px auto;
        }
    </style>
    <script src="vue.js"></script>
    <link rel="stylesheet" href="animate.css">
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    show:false
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="点击显示隐藏" @click="show=!show">

        <transition-group enter-active-class="zoomInLeft" leave-active-class="zoomOutRight">
            <p v-show="show" class="animated" :key="1"></p>
            <p v-show="show" class="animated" :key="2"></p>
        </transition-group>
    </div>
</body>
</html>
```

### 1.7 transition多个元素2
```html
<!-- 
需求：
在输入框中输入一个字符,会显示对应的动画
-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        p{
            width:100px;
            height:100px;
            background: red;
            margin:10px auto;
        }
    </style>
    <script src="vue.js"></script>
    <link rel="stylesheet" href="animate.css">
    <script>
        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    show:'',
                    list:['apple','banana','orange','pear']
                },
                computed:{
                    lists:function(){
                        var arr=[];
                        this.list.forEach(function(val){
                            if(val.indexOf(this.show)!=-1){
                                arr.push(val);
                            }
                        }.bind(this));
                        return arr;
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="text" v-model="show">

        <transition-group enter-active-class="zoomInLeft" leave-active-class="zoomOutRight">
            <p v-show="show" class="animated" v-for="(val,index) in lists" :key="index">
                {{val}}
            </p>
        </transition-group>
    </div>
</body>
</html>
```
