# vue2.0

<!-- toc -->

## 1. vue2.0以后的一些变化
### 1.1. 在每个组件模板，不在支持片段代码
```
 组件中模板:
     之前:
         <template>
             <h3>我是组件</h3><strong>我是加粗标签</strong>
         </template>
     现在:  必须有根元素，包裹住所有的代码
         <template id="aaa">
                 <div>
                     <h3>我是组件</h3>
                     <strong>我是加粗标签</strong>
                 </div>
         </template>
```
### 1.2. 关于组件定义
```
    Vue.extend  这种方式，在2.0里面有，但是有一些改动，这种写法，即使能用，咱也不用――废弃
    
    Vue.component(组件名称,{    在2.0继续能用
        data(){}
        methods:{}
        template:
    });

    2.0推出一个组件，简洁定义方式：
    var Home={
        template:''     ->   Vue.extend()
    };
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        var Home={  //这是2.0组件
            template:'#bbb'
        };  //Vue.extend()

        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    msg:'welcome vue2.0'
                },
                components:{
                    'my-temp':Home
                }
            });
        };
    </script>
</head>
<body>
    <template id="bbb">
        <div>
            <h3>我是组件</h3>
            <strong>我是加粗标签</strong>
        </div>
    </template>
    <div id="box">
        <my-temp></my-temp>
        {{msg}}
    </div>
</body>
</html>
```
### 1.3. 生命周期
```
    之前:
        init    
        created
        beforeCompile
        compiled
        ready       √   ->     mounted
        beforeDestroy   
        destroyed
    现在:
        beforeCreate    组件实例刚刚被创建,属性都没有
        created 实例已经创建完成，属性已经绑定
        beforeMount 模板编译之前
        mounted 模板编译之后，代替之前ready  *
        beforeUpdate    组件更新之前
        updated 组件更新完毕  *
        beforeDestroy   组件销毁前
        destroyed   组件销毁后
```
### 1.4. 循环
```
    2.0里面默认就可以添加重复数据

    arr.forEach(function(item,index){

    });

    去掉了隐式一些变量
        $index  $key

    之前:
        v-for="(index,val) in array"
    现在:
        v-for="(val,index) in array"
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
                    list:['width','height','border']
                },
                methods:{
                    add(){
                        this.list.push('background');
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <input type="button" value="添加" @click="add">
        <ul>
            <li v-for="(val,index) in list" :key="index">
                {{val}} {{index}}
            </li>
        </ul>
    </div>
</body>
</html>
```
### 1.5. track-by="id"
```
    变成
        <li v-for="(val,index) in list" :key="index">
```
### 1.6. 自定义键盘指令
```
    之前：Vue.directive('on').keyCodes.f1=17;  
    
    现在:  Vue.config.keyCodes.ctrl=17
```
### 1.7. 过滤器
```
    之前:
        系统就自带很多过滤
        {{msg | currency}}
        {{msg | json}}
        ....
        limitBy
        filterBy
        .....
    一些简单功能，自己通过js实现

    到了2.0， 内置过滤器，全部删除了

    作者推荐：lodash 工具库(工具框架) _.debounce(fn,200)

    自定义过滤器――还有
        但是,自定义过滤器传参
        之前: {{msg | toDou '12' '5'}}
        现在: {{msg | toDou('12','5')}}
```

 example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        Vue.filter('toDou',function(n,a,b){
            alert(a+','+b);
            return n<10?'0'+n:''+n;
        });

        window.onload=function(){
            new Vue({
                el:'#box',
                data:{
                    msg:9
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        {{msg | toDou('12','5')}}
    </div>
</body>
</html>
```

### 1.8 组件通信:
```
    vm.$emit()
    vm.$on();

    父组件和子组件:

    子组件想要拿到父组件数据:
        通过  props

    之前，子组件可以更改父组件信息，可以是同步  sync
    现在，不允许直接给父级的数据，做赋值操作

    问题，就想更改：
        a). 父组件每次传一个对象给子组件, 对象之间引用  √
        b). 只是不报错, mounted中转
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
                    giveData:{
                        a:'我是父组件数据'
                    }
                },
                components:{
                    'child-com':{
                        props:['msg'],
                        template:'#child',
                        methods:{
                            change(){
                                this.msg.a='被改了';
                            }
                        }
                    }
                }
            });
        };
    </script>
</head>
<body>
    <template id="child">
        <div>
            <span>我是子组件</span>
            <input type="button" value="按钮" @click="change">
            <strong>{{msg.a}}</strong>
        </div>
    </template>

    <div id="box">
        父级: ->{{giveData.a}}
        <br>
        <child-com :msg="giveData"></child-com>
    </div>
</body>
</html>
```

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
                    a:'我是父组件数据'
                },
                components:{
                    'child-com':{
                        data(){
                            return {
                                b:''
                            }
                        },
                        props:['msg'],
                        template:'#child',
                        mounted(){
                            this.b=this.msg;
                        },
                        methods:{
                            change(){
                                this.b='被改了';
                            }
                        }
                    }
                }
            });
        };
    </script>
</head>
<body>
    <template id="child">
        <div>
            <span>我是子组件</span>
            <input type="button" value="按钮" @click="change">
            <strong>{{b}}</strong>
        </div>
    </template>

    <div id="box">
        父级: ->{{a}}
        <br>
        <child-com :msg.sync="a"></child-com>
    </div>
</body>
</html>
```

### 1.9 可以单一事件管理组件通信:vuex
```
    var Event=new Vue();

    Event.$emit(事件名称, 数据)

    Event.$on(事件名称,function(data){
        //data
    }.bind(this));
```

 example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        //准备一个空的实例对象
        var Event=new Vue();


        var A={
            template:`
                <div>
                    <span>我是A组件</span> -> {{a}}
                    <input type="button" value="把A数据给C" @click="send">
                </div>
            `,
            methods:{
                send(){
                    Event.$emit('a-msg',this.a);
                }
            },
            data(){
                return {
                    a:'我是a数据'
                }
            }
        };
        var B={
            template:`
                <div>
                    <span>我是B组件</span> -> {{a}}
                    <input type="button" value="把B数据给C" @click="send">
                </div>
            `,
            methods:{
                send(){
                    Event.$emit('b-msg',this.a);
                }
            },
            data(){
                return {
                    a:'我是b数据'
                }
            }
        };
        var C={
            template:`
                <div>
                    <h3>我是C组件</h3>
                    <span>接收过来的A的数据为: {{a}}</span>
                    <br>
                    <span>接收过来的B的数据为: {{b}}</span>
                </div>
            `,
            data(){
                return {
                    a:'',
                    b:''
                }
            },
            mounted(){
                //var _this=this;
                //接收A组件的数据
                Event.$on('a-msg',function(a){
                    this.a=a;
                }.bind(this));

                //接收B组件的数据
                Event.$on('b-msg',function(a){
                    this.b=a;
                }.bind(this));
            }
        };


        window.onload=function(){
            new Vue({
                el:'#box',
                components:{
                    'com-a':A,
                    'com-b':B,
                    'com-c':C
                }
            });
        };
    </script>
</head>
<body>
    <div id="box">
        <com-a></com-a>
        <com-b></com-b>
        <com-c></com-c>
    </div>
</body>
</html>
```














