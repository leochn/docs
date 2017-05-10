# vue1.x进阶

<!-- toc -->

## 1.vue生命周期
* 钩子函数
```
    created         ->   实例已经创建 √
    beforeCompile   ->   编译之前
    compiled        ->   编译之后
    ready           ->   插入到文档中 √

    beforeDestroy   ->   销毁之前
    destroyed       ->   销毁之后
```

* ```example```
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
</head>
<body>
    <div id="box">
        {{msg}}
    </div>
    <script>
        var vm=new Vue({
            el:'#box',
            data:{
                msg:'well'
            },
            created:function(){
                alert('实例已经创建');
            },
            beforeCompile:function(){
                alert('编译之前');
            },
            compiled:function(){
                alert('编译之后');
            },
            ready:function(){
                alert('插入到文档中');
            },
            beforeDestroy:function(){
                alert('销毁之前');
            },
            destroyed:function(){
                alert('销毁之后');
            }
        });
        /*点击页面销毁vue对象*/
        document.onclick=function(){
            vm.$destroy();
        };
    </script>
</body>
</html>
```

## 2.v-text,v-html
```html 
<!-- v-html 会进行转义 -->  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
</head>
<body>
    <div id="box">
        <span>{{{msg1}}}</span>
        <br>
        <span v-text="msg1"></span>
        <br>
        <span v-html="msg1"></span>
        <hr>
        <span>{{{msg2}}}</span>
        <br>
        <span v-text="msg2"></span>
        <br>
        <span v-html="msg2"></span>
    </div>
    <script>
        new Vue({
            el:'#box',
            data:{
                msg2:'<strong>welcome</strong>',
                msg1:'helloworld'
            }
        });
    </script>
</body>
</html>
```

## 3.计算属性
### 3.1计算属性
```
模板内的表达式是非常便利的，但是它们实际上只用于简单的运算。在模板中放入太多的逻辑会让模板过重且难以维护。例如：
<div id="example">
  {{ message.split('').reverse().join('') }}
</div>
在这种情况下，模板不再简单和清晰。在意识到这是反向显示 message 之前，你不得不再次确认第二遍。当你想要在模板中多次反向显示 message 的时候，问题会变得更糟糕。
这就是对于任何复杂逻辑，你都应当使用计算属性的原因
```

### 3.2基础例子
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
</head>
<body>
    <div id="box">
        a => {{a}}
        <br>
        b => {{computeB}}
        <br>
        b => {{methodB()}}
    </div>
    <script>
        var vm=new Vue({
            el:'#box',
            data:{
                a:100
            },
            methods:{
                methodB:function(){
                    //业务逻辑代码
                    console.log("mdthod...");
                    return this.a+1;
                }
            },
            computed:{
                computeB:function(){
                    //业务逻辑代码
                    console.log("computed...");
                    return this.a+1;
                },now: function () {
                    return Date.now()
                }
            }
        });
    </script>
</body>
</html>
```

### 3.3结果
```
a => 100 
b => 101 
b => 101
可以打开浏览器的控制台,自行修改例子中的vm. vm.computeB 的值始终取决于 vm.a 的值
vm.a=1024    //输出如下:
    computed...
    mdthod...
    1024
vm.computeB  //输出如下:
    1025
vm.methodB() //输出如下:
    mdthod...
    1025
vm.now       //输出如下:
    1494390378264
vm.now       //输出如下:
    1494390378264
```

### 3.4计算缓存与method
```
根据以上的结果，相比而言，只要发生重新渲染，method 调用总会执行该函数。
我们为什么需要缓存？假设我们有一个性能开销比较大的的计算属性 A ，它需要遍历一个极大的数组和做大量的计算。然后我们可能有其他的计算属性依赖于 A 。如果没有缓存，我们将不可避免的多次执行 A 的 getter！如果你不希望有缓存，请用 method 替代。
```
### 3.5计算setter
```js
var vm=new Vue({
    el:'#box',
    data:{
        a:1
    },
    computed:{
        b:{
            get:function(){
                return this.a+2;
            },
            set:function(val){
                this.a=val;
            }
        }
    }
});
```

## 4.vue实例简单方法
```
    vm.$el  ->  就是元素
    vm.$data  ->  就是data
    vm.$mount ->  手动挂在vue程序
    
    vm.$options ->   获取自定义属性
    vm.$destroy ->   销毁对象

    vm.$log();  ->  查看现在数据的状态
```
* ```example```
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
</head>
<body>
    <div id="box">
        <span v-text="a"></span>
    </div>
    <script>
        var vm=new Vue({
            data:{
                a:1,
                b:2
            }
        }).$mount('#box');

        //vm就是实例对象
        console.log(vm.$el); //这里就是div元素
        vm.$el.style.background = 'red';
        console.log(vm.$data); 
        console.log(vm.$data.a);   //'1'
        console.log(vm.$log());    
    </script>
</body>
</html>
```

## 5.循环
```
    v-for="value in data"
    会有重复数据?默认无法添加重复数据,加入track-by,则可以添加
    track-by='索引'   提高循环性能
    track-by='$index/uid'
```

* ```example```
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
</head>
<body>
    <div id="box">
        <input type="button" value="添加" @click="add">
        <ul>
            <li v-for="val in arr" track-by="$index">
                {{val}}
            </li>
        </ul>
    </div>
    <script>
        var vm=new Vue({
            data:{
                arr:['apple','pear','orange']
            },
            methods:{
                add:function(){
                    this.arr.push('tomato');
                }
            }
        }).$mount('#box');
    </script>
</body>
```

## 6.自定义指令
```
    // red 是指令名称
    Vue.directive(red,function(参数){
        this.el -> 原生DOM元素
    });

    <div v-red="参数"></div>

    指令名称:   v-red  ->  red

    * 注意: 必须以 v-开头
```

### 6.1 example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        Vue.directive('red',function(){
            this.el.style.background='red';
        });

        window.onload=function(){
            var vm=new Vue({
                el:'#box'
            });
        };

    </script>
</head>
<body>
    <div id="box">
        <span v-red>
            asdfasd
        </span>
    </div>
</body>
</html>
```

### 6.2 自定义键盘信息
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
    <script>
        //ctrl->17
        /*document.onkeydown=function(ev){
            console.log(ev.keyCode);
        };*/
        Vue.directive('on').keyCodes.ctrl=17;  //
        Vue.directive('on').keyCodes.myenter=13;

        window.onload=function(){
            var vm=new Vue({
                el:'#box',
                data:{
                    a:'blue'
                },
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
        <input type="text" @keydown.ctrl="show">
        <br>
        <input type="text" @keydown.myenter="show | debounce 500">
    </div>
</body>
</html>
```

## 7.监听数据变化
```
    vm.$el/$mount/$options/....
    vm.$watch(name,fnCb);  //浅度监听
    vm.$watch(name,fnCb,{deep:true});  //深度监视
```

* example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
</head>
<body>
    <div id="box">
        {{a}}
        <br> {{b}}
    </div>
    <script>
    var vm = new Vue({
        el: '#box',
        data: {
            a: 111,
            b: 2,
            json:{ name:'strive',age:18 },
            json2:{ name:'strive',age:18 }
        }
    });
    vm.$watch('a', function() {
        alert('a发生变化了');
        this.b = this.a + 100;
    });
    vm.$watch('json',function(){
        alert('json发生变化了');
    },{deep:true});

    vm.$watch('json2',function(){
        alert('json2发生变化了');
    },);

    document.onclick = function() {
        vm.a = 1;
        vm.json.name='aaa';
    };
    </script>
</body>
</html>
```

## 8.自定义过滤器
```
    自定义过滤器:  model ->过滤 -> view
        Vue.filter(name,function(input){
            
        });
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="vue.js"></script>
</head>
<body>
    <div id="box">
        {{a | toDou 1 2}}
    </div>
    <script>
    Vue.filter('toDou', function(input, a, b) {
        alert(a + ',' + b); // 这里的input就是a,为9
        return input < 10 ? '0' + input : '' + input;
    });
    var vm = new Vue({
        data: {
            a: 9
        },
        methods: {

        }
    }).$mount('#box');
    </script>
</body>
</html>
```

## 9.过渡(动画)
```
    本质走的css3: transtion ,animation

    <div id="div1" v-show="bSign" transition="fade"></div>

    动画:
        .fade-transition{        
        }
        进入：
        .fade-enter{
            opacity: 0;
        }
        离开：
        .fade-leave{
            opacity: 0;
            transform: translateX(200px);
        }
```
## 10.组件
### 10.1 定义组件的一种方式
#### 10.1.1 全局组件
```
var Aaa=Vue.extend({
    template:'<h3>我是标题3</h3>'
});
Vue.component('aaa',Aaa);
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="bower_components/vue/dist/vue.js"></script>
</head>
<body>
    <div id="box">
        <!-- 使用aaa组件 -->
        <aaa></aaa>
    </div>
    <script>
        var Aaa=Vue.extend({
            template:'<h3>我是标题3</h3>'
        });
        Vue.component('aaa',Aaa); // 定义全局组件
        var vm=new Vue({
            el:'#box',
            data:{
                bSign:true
            }
        });
    </script>
</body>
</html>
```

#### 10.1.2 局部组件
```
局部组件:放到某个组件内部
var vm=new Vue({
    el:'#box',
    data:{
        bSign:true
    },
    components:{ //局部组件
        aaa:Aaa
    }
});
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="bower_components/vue/dist/vue.js"></script>
</head>
<body>
    <div id="box">
        <my-aaa></my-aaa>
    </div>
    <script>
        var Aaa=Vue.extend({
            template:'<h3>{{msg}}</h3>',
            // 组件里面放数据:
            //   data必须是函数的形式,函数必须返回一个对象(json)
            data(){
                return {
                    msg:'hello Component!'
                }
            }
        });
        var vm=new Vue({
            el:'#box',
            data:{
                bSign:true
            },
            components:{     //局部组件
                'my-aaa':Aaa
            }
        });
    </script>
</body>
</html>
```

### 10.2 定义组件的另一种方式
```
    // 全部组件
    Vue.component('my-aaa',{
        template:'<strong>好</strong>'
    });
    --------------------------------------
    // 局部组件
    var vm=new Vue({
        el:'#box',
        components:{
            'my-aaa':{
                template:'<h2>标题2</h2>'
            }
        }
    });
```

### 10.3 组件配合模板
* 概述
```
    1. template:'<h2 @click="change">标题2->{{msg}}</h2>'
    2. 单独放到某个地方的两种方式
        a). 
        <script type="x-template" id="aaa">
            <h2 @click="change">标题2->{{msg}}</h2>
        </script>
        
        b). 
        <template id="aaa">
            <h1>标题1</h1>
            <ul>
                <li v-for="val in arr">
                    {{val}}
                </li>
            </ul>
        </template>
```

* example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="bower_components/vue/dist/vue.js"></script>
</head>
<body>
    <div id="box">
        <my-aaa></my-aaa>
    </div>
    <script type="x-template" id="aaa">
        <h2 @click="change">标题2->{{msg}}</h2>
    </script>
    <script>
        var vm=new Vue({
            el:'#box',
            components:{
                'my-aaa':{
                    data(){
                        return {
                            msg:'welcome vue'
                        }
                    },
                    methods:{
                        change(){
                            this.msg='changed';
                        }
                    },
                    template:'#aaa'
                }
            }
        });
    </script>
</body>
</html>
```

* example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="bower_components/vue/dist/vue.js"></script>
</head>
<body>
    <div id="box">
        <my-aaa></my-aaa>
    </div>
    <template id="aaa">
        <h1>标题1</h1>
        <ul>
            <li v-for="val in arr">
                {{val}}
            </li>
        </ul>
    </template>
    <script>
        var vm=new Vue({
            el:'#box',
            components:{
                'my-aaa':{
                    data(){
                        return {
                            msg:'welcome vue',
                            arr:['apple','banana','orange']
                        }
                    },
                    methods:{
                        change(){
                            this.msg='changed';
                        }
                    },
                    template:'#aaa'
                }
            }
        });
    </script>
</body>
</html>
```

### 10.4 动态组件
```
<component :is="组件名称"></component>
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="bower_components/vue/dist/vue.js"></script>
</head>
<body>
    <div id="box">
        <input type="button" @click="a='aaa'" value="aaa组件">
        <input type="button" @click="a='bbb'" value="bbb组件">
        <component :is="a"></component>
    </div>
    <script>
        var vm=new Vue({
            el:'#box',
            data:{
                a:'aaa'
            },
            components:{
                'aaa':{
                    template:'<h2>我是aaa组件</h2>'
                },
                'bbb':{
                    template:'<h2>我是bbb组件</h2>'
                }
            }
        });
    </script>
</body>
</html>
```

### 10.5 组件间数据传递
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="bower_components/vue/dist/vue.js"></script>
</head>
<body>
    <div id="box">
        <aaa></aaa>
    </div>
    <script>
        var vm=new Vue({
            el:'#box',
            components:{
                'aaa':{
                    template:'<h2>我是aaa组件</h2><bbb></bbb>',
                    components:{
                        'bbb':{
                            template:'<h3>我是bbb组件</h3>'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
```

#### 10.5.1 子组件想获取父组件数据
```
    在调用子组件：
        <bbb :m="数据"></bbb>
    子组件之内:
        props:['m','myMsg']
        props:{
            'm':String,
            'myMsg':Number
        }
```




#### 10.5.2 父组件获取子组件数据
```
子组件把自己的数据,发送到父级
vm.$emit(事件名,数据);
```

#### 10.5.3 父子组件通讯
```
vm.$dispatch(事件名,数据)    子级向父级发送数据
vm.$broadcast(事件名,数据)   父级向子级广播数据
    配合: event:{}

    在vue2.0里面已经，报废了
```



slot:



路由


多层路由





































































