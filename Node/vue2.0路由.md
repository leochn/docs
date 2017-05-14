# vue2.0路由

<!-- toc -->
## 1. vue2.0路由文档
链接: [http://router.vuejs.org/zh-cn/](http://router.vuejs.org/zh-cn/)

## 2. 基本使用
```
1.  布局
    <router-link to="/home">主页</router-link>

    <router-view></router-view>
2. 路由具体写法
    //组件
    var Home={
        template:'<h3>我是主页</h3>'
    };
    var News={
        template:'<h3>我是新闻</h3>'
    };

    //配置路由
    const routes=[
        {path:'/home', componet:Home},
        {path:'/news', componet:News},
    ];

    //生成路由实例
    const router=new VueRouter({
        routes
    });

    //最后挂到vue上
    new Vue({
        router,
        el:'#box'
    });
3. 重定向
    之前  router.rediect  废弃了
    {path:'*', redirect:'/home'}
```

## 3. 路由嵌套
```
    /user/username

    const routes=[
        {path:'/home', component:Home},
        {
            path:'/user',
            component:User,
            children:[  //核心
                {path:'username', component:UserDetail}
            ]
        },
        {path:'*', redirect:'/home'}  //404
    ];
```
### 3.1 example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .router-link-active{
            font-size: 20px;
            color:#f60;
        }
    </style>
    <script src="vue.js"></script>
    <script src="bower_components/vue-router/dist/vue-router.min.js"></script>
</head>
<body>
    <div id="box">
        <div>
            <router-link to="/home">主页</router-link>
            <router-link to="/user">用户</router-link>
        </div>
        <div>
            <router-view></router-view>
        </div>
    </div>

    <script>
        //组件
        var Home={
            template:'<h3>我是主页</h3>'
        };
        var User={
            template:`
                <div>
                    <h3>我是用户信息</h3>
                    <ul>
                        <li><router-link to="/user/strive/age/10">Strive</router-link></li>
                        <li><router-link to="/user/blue/age/80">Blue</router-link></li>
                        <li><router-link to="/user/eric/age/70">Eric</router-link></li>
                    </ul>
                    <div>
                        <router-view></router-view>
                    </div>
                </div>
            `
        };
        var UserDetail={
            template:'<div>{{$route.params}}</div>'
        };

        //配置路由
        const routes=[
            {path:'/home', component:Home},
            {
                path:'/user',
                component:User,
                children:[
                    {path:':username/age/:age', component:UserDetail}
                ]
            },
            {path:'*', redirect:'/home'}  //404
        ];

        //生成路由实例
        const router=new VueRouter({
            routes
        });


        //最后挂到vue上
        new Vue({
            router,
            el:'#box'
        });
    </script>
</body>
</html>
```

## 4.路由实例方法:
```
    router.push({path:'home'});  //直接添加一个路由,表现切换路由，本质往历史记录里面添加一个
    router.replace({path:'news'}) //替换路由，不会往历史记录里面添加
```
### 4.1 example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .router-link-active{
            font-size: 20px;
            color:#f60;
        }
    </style>
    <script src="vue.js"></script>
    <script src="bower_components/vue-router/dist/vue-router.min.js"></script>
</head>
<body>
    <div id="box">
        <input type="button" value="添加一个路由" @click="push">
        <input type="button" value="替换一个路由" @click="replace">
        <div>
            <router-link to="/home">主页</router-link>
            <router-link to="/user">用户</router-link>
        </div>
        <div>
            <router-view></router-view>
        </div>
    </div>

    <script>
        //组件
        var Home={
            template:'<h3>我是主页</h3>'
        };
        var User={
            template:`
                <div>
                    <h3>我是用户信息</h3>
                    <ul>
                        <li><router-link to="/user/strive/age/10">Strive</router-link></li>
                        <li><router-link to="/user/blue/age/80">Blue</router-link></li>
                        <li><router-link to="/user/eric/age/70">Eric</router-link></li>
                    </ul>
                    <div>
                        <router-view></router-view>
                    </div>
                </div>
            `
        };
        var UserDetail={
            template:'<div>{{$route.params}}</div>'
        };

        //配置路由
        const routes=[
            {path:'/home', component:Home},
            {
                path:'/user',
                component:User,
                children:[
                    {path:':username/age/:age', component:UserDetail}
                ]
            },
            {path:'*', redirect:'/home'}  //404
        ];

        //生成路由实例
        const router=new VueRouter({
            routes
        });

        //最后挂到vue上
        new Vue({
            router,
            methods:{
                push(){
                    router.push({path:'home'});
                },
                replace(){
                    router.replace({path:'user'});
                }
            }
        }).$mount('#box');
    </script>
</body>
</html>
```

## 5.路由配合运动
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .router-link-active{
            font-size: 20px;
            color:#f60;
        }
    </style>
    <script src="vue.js"></script>
    <script src="bower_components/vue-router/dist/vue-router.min.js"></script>
    <link rel="stylesheet" href="animate.css">
</head>
<body>
    <div id="box">
        <input type="button" value="添加一个路由" @click="push">
        <input type="button" value="替换一个路由" @click="replace">
        <div>
            <router-link to="/home">主页</router-link>
            <router-link to="/user">用户</router-link>
        </div>
        <div>
            <transition enter-active-class="animated bounceInLeft" leave-active-class="animated bounceOutRight">
                <router-view></router-view>
            </transition>
        </div>
    </div>

    <script>
        //组件
        var Home={
            template:'<h3>我是主页</h3>'
        };
        var User={
            template:`
                <div>
                    <h3>我是用户信息</h3>
                    <ul>
                        <li><router-link to="/user/strive/age/10">Strive</router-link></li>
                        <li><router-link to="/user/blue/age/80">Blue</router-link></li>
                        <li><router-link to="/user/eric/age/70">Eric</router-link></li>
                    </ul>
                    <div>
                        <router-view></router-view>
                    </div>
                </div>
            `
        };
        var UserDetail={
            template:'<div>{{$route.params}}</div>'
        };

        //配置路由
        const routes=[
            {path:'/home', component:Home},
            {
                path:'/user',
                component:User,
                children:[
                    {path:':username/age/:age', component:UserDetail}
                ]
            },
            {path:'*', redirect:'/home'}  //404
        ];

        //生成路由实例
        const router=new VueRouter({
            routes
        });

        //最后挂到vue上
        new Vue({
            router,
            methods:{
                push(){
                    router.push({path:'home'});
                },
                replace(){
                    router.replace({path:'user'});
                }
            }
        }).$mount('#box');
    </script>
</body>
</html>
```

## 6.其他
```
style和css的顺序
style-loader    css-loader

    style!css
```
















