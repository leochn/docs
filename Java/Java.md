# java 知识点

<!-- toc -->
* list.map.set的存储特点?  
```
List 以特定次序来持有元素,可有重复元素. 
Set 无法拥有重复元素,内部排序.
Map 保存key-value值,value可多值
```
* String和stringbuffer进行字符串连接时的区别？
```
String对项内容是不可改变的，StringBuffer是可以改变的，且高效.
```

* String = 与 new 的不同
```
使用“=”赋值不一定每次都创建一个新的字符串，而是从“字符串实例池”中查找字符串。使用“new”进行赋值，则每次都创建一个新的字符串。
```

* final的作用
```
final修饰符是一个用途非常广泛的修饰符，可以修饰类，方法，以及属性。 
final类是不能够被继承的类，称为终极类，如String类就是final类，不能有子类。
final修饰方法后，是终极方法，不能被子类覆盖，但是可以被子类继承使用。
final类不能被继承，final方法不能被覆盖，final属性不能被改变。
```
* HashMap的源码，实现原理，底层结构

* 说说你知道的几个Java集合类：list、set、queue、map实现类咯



* 什么叫项目？  
```
用有限的资源、有限的时间为特定客户完成特定目标的一次性工作.
```

* Collections,collection的区别 
```
Collection是个java.util下的接口，它是各种集合结构的父接口。
Collections是个java.util下的普通类，它包含有各种有关集合操作的静态方法。
Collections是针对集合类的一个帮助类，它提供一系列的静态方法实现对各种集合的搜索，排序，线程安全化等操作.
```

* 概述反射和序列化 
```
Reflection是Java被视为动态（或准动态）语言的一个关键性质。这个机制允许程序在运行时透过Reflection APIs取得任何一个已知名称的class的内部信息，包括其modifiers（诸如public, static 等等）、superclass（例如Object）、实现之interfaces（例如Cloneable），也包括fields和methods的所有信息，并可于运行时改变fields内容或唤起methods。本文借由实例，大面积示范Reflection APIs.
序列化就是一种用来处理对象流的机制，所谓对象流也就是将对象的内容进行流化。可以对流化后的对象进行读写操作，也可将流化后的对象传输于网络之间。序列化是为了解决在对对象流进行读写操作时所引发的问题.
序列化的实现：将需要被序列化的类实现Serializable接口，该接口没有需要实现的方法，implements Serializable只是为了标注该对象是可被序列化的，然后使用一个输出流(如：FileOutputStream)来构造一个 ObjectOutputStream(对象流)对象，接着，使用ObjectOutputStream对象的writeObject(Object obj)方法就可以将参数为obj的对象写出(即保存其状态)，要恢复的话则用输入流 
```
* Java中，&&与&，||与|的区别
```
&&和&都是表示与，区别是&&只要第一个条件不满足，后面条件就不再判断。而&要对所有的条件都进行判断.
||和|都是表示“或”，区别是||只要满足第一个条件，后面的条件就不再判断，而|要对所有的条件进行判断.
```

* java 是如何进行异常处理的
```
Java通过面向对象的方法进行异常处理，把各种不同的异常进行分类，并提供了良好的接口。在Java中，每个异常都是一个对象，它是Throwable类或其它子类的实例。当一个方法出现异常后便抛出一个异常对象，该对象中包含有异常信息，调用这个对象的方法可以捕获到这个异常并进行处理。Java的异常处理是通过5个关键词来实现的：try、catch、throw、throws和finally。一般情况下是用try来执行一段程序，如果出现异常，系统会抛出（throws）一个异常，这时候你可以通过它的类型来捕捉（catch）它，或最后（finally）由缺省处理器来处理.
```

* mybatis 中的#与$的区别 
```
1. ```#```将传入的数据都当成一个字符串，会对自动传入的数据加一个双引号。如：order by #user_id#，如果传入的值是111,那么解析成sql时的值为order by "111", 如果传入的值是id，则解析成的sql为order by "id".
2. $将传入的数据直接显示生成在sql中。如：order by $user_id$，如果传入的值是111,那么解析成sql时的值为order by user_id,  如果传入的值是id，则解析成的sql为order by id. 
3. ```#```方式能够很大程度防止sql注入。
4. $方式无法防止Sql注入。
5. $方式一般用于传入数据库对象，例如传入表名.
6. 一般能用#的就别用$. 
```

* sleep()和wait()区别  sleep() 
```
sleep()方法：线程主动放弃CPU，使得线程在指定的时间内进入阻塞状态，不能得到CPU 时间，指定的时 间一过，线程重新进入可执行状态。典型地，sleep() 被用在等待某个资源就绪的情形：测试发现条件 不满足后，让线程阻塞一段时间后重新测试，直到条件满足为止。  wait( ) ：与notify()配套使用，wait()使得线程进入阻塞状态，它有两种形式，一种允许指定以毫秒为单位的一段时间作为参数，另一种没有参数，当指定时间参数时对应的 notify() 被调用或者超出指定时间时线程重新进入可执行状态，后者则必须对应的 notify() 被调用
```


* 多线程、同步实现方法？       
```
1）.实现线程有两种方法： 继承Thread类或者实现Runnable接口
2）.实现同步也有两种,一种是用同步方法,一种是用同步块.. 同步方法就是在方法返回类型后面加上synchronized, 比如:  public void synchronized add(){...}  同步块就是直接写:synchronized (这里写需要同步的对象){...}
```

* 集合类有哪些？有哪些方法？  

```
集合类 ArrayList  LinkedList  HashSet  HashMap 
方法：add(),remove(),put(),addAll(),removeAll()
```

* java中实现多态的机制是什么:重写，重载  
```
方法的重写Overriding和重载Overloading是Java多态性的不同表现。  重写Overriding是父类与子类之间多态性的一种表现，重载Overloading是一个类中多态性的一种表现。如果在子类中定义某方法与其父类有相同的名称和参数，我们说该方法被重写 (Overriding)。子类的对象使用这个方法时，将调用子类中的定义，对它而言，父类中的定义如同被“屏蔽”了。  果在一个类中定义了多个同名的方法，它们或有不同的参数个数或有不同的参数类型，则称为方法的重载(Overloading)。Overloaded的方法是可以改变返回值的类型。
```

* 静态的多态和动态的多态的区别
```
静态的多态: 即为重载 ；方法名相同，参数个数或类型不相同。
(overloading)  动态的多态: 即为重写；子类覆盖父类的方法，将子类的实例传与父类的引用调用的是子类的方法  实现接口的实例传与接口的引用调用的实现类的方法
```

* 作用域Public,private,protected.以及不写时的区别
```
public整个java程序中都可以访问.
protected在其他包中不可以访问.
friendly只有当前包或当前内可以访问，其他都不行.
private只有当前内可以访问 不写的话默认是protected.
```

* join与left join的区别  
```
inner join(等值连接) 只返回两个表中联结字段相等的行. 
left join(左联接) 返回包括左表中的所有记录和右表中联结字段相等的记录. 
right join(右联接) 返回包括右表中的所有记录和左表中联结字段相等的记录
```

* 抽象类能否被实例化 ？抽象类的作用是什么？
```
抽象类一般不能被实例化； 抽象类通常不是由程序员定义的，而是由项目经理或模块设计人 设计抽象类的原因通常是为了规范方法名 抽象类必须要继承，不然没法用，作为模块设计者，可以把让底层程序员直接用得方法直接调用，而一些需要让程序员覆盖后自己做得方法则定义称抽象方法
```

* .Xml特点  
```
XML是一种可扩展标记语言 (XML) 是 Web 上的数据通用语言。它使开发人员能够将结构化数据，从许多不同的应用程序传递到桌面，进行本地计算和演示。XML允许为特定应用程序创建唯一的数据格式。它还是在服务器之间传输结构化数据的理想格式。
```

* Spring工作原理  

```
内部最核心的就是IOC了，动态注入，让一个对象的创建不用new了，可以自动的生产，这其实就是利用java里的反射,反射其实就是在运行时动态的去创建、调用对象，Spring就是在运行时，跟xml、Spring的配置文件来动态的创建对象，和调用对象里的方法的。还有一个核心就是AOP这个就是面向切面编程，可以为某一类对象进行监督和控制（也就是在调用这类对象的具体方法的前后去调用你指定的 模块）从而达到对一个模块扩充的功能。这些都是通过配置类达到的Spring目的：就是让对象与对象（模块与模块）之间的关系没有通过代码来关联，都是通过配置类说明 管理的（Spring根据这些配置 内部通过反射去动态的组装对象）要记住：Spring是一个容器，凡是在容器里的对象才会有Spring所提供的这些服务和功能。
```

* 单例模式
```java
//饿汉式
public class Singleton {
    // 直接创建对象
    public static Singleton instance = new Singleton();
    // 私有化构造函数
    private Singleton() {
        System.out.println("创建了一个对象");
    }
    // 返回对象实例
    public static Singleton getInstance() {
        return instance;
    }
}
```

```java
//饿汉式
public class Singleton {
    // 声明变量
    private static volatile Singleton singleton = null;
    // 私有构造函数
    private Singleton() {
        System.out.println("创建了一个对象");
    }
    // 提供对外方法
    public static Singleton getInstance() {
        if (singleton == null) {
            synchronized (Singleton.class) {
                if (singleton == null) {
                    singleton = new Singleton();
                }
            }
        }
        return singleton;
    }
}
```
```java
// 测试单例模式
public class TestSingleton {
    public static void main(String[] args) {
        for (int i = 0; i < 5000; i++) {
            Thread th = new Thread(){
                @Override
                public void run() {
                    Singleton singleton = Singleton.getInstance();
                }
            };
            th.start();
        }
    }
}

```
* 工厂模式
```java
//1. 定义接口
public interface Human {
    public void cry();
    public void talk();
}
//2.实现接口
public class YellowHuman implements Human {
    @Override
    public void cry() {
        System.out.println("黄色人种会大笑，幸福呀！ ");
    }
    @Override
    public void talk() {
        System.out.println("黄色人种会说话，一般说的都是双字节");
    }
}
//3.创建工厂
public class HumanFactory {
    public static Human createHuman(Class<?> c) {
        Human human = null; // 定义一个类型的人类
        try {
            human = (Human) Class.forName(c.getName()).newInstance();// 产生一个 人种
        } catch (InstantiationException e) {// 你要是不说个人种颜色的话，没法烤，要白的 黑，你说话了才好烤
            System.out.println("必须指定人种的颜色");
        } catch (IllegalAccessException e) { // 定义的人种有问题，那就烤不出来了，这是...您的设计模式
            System.out.println("人种定义错误！ ");
        } catch (ClassNotFoundException e) { // 你随便说个人种，我到哪里给你制造去？！
            System.out.println("混蛋，你指定的人种找不到！ ");
        }
        return human;
    }
}
//4.测试
public class Test {
    public static void main(String[] args) {
        Human yellowHuman = HumanFactory.createHuman(YellowHuman.class);
        yellowHuman.cry();
        yellowHuman.talk();
    }
}
```

```
注意：实现一个单例有两点注意事项，
①将构造器私有，不允许外界通过构造器创建对象；
②通过公开的静态方法向外界返回类的唯一实例。
这里有一个问题可以思考：spring的IoC容器可以为普通的类创建单例，它是怎么做到的呢？
```

* 解释一下mvc以及熟悉的mvc框架  
```
m代表模型层，v 代表视图层，c代表控制层，也就是把一个整体分割成不同的模块，各负责自己的功能，分工明确，提高代码的重用性和方便维护.
在jsp设计模式二中，jsp用来做视图层，servlet是控制器，dao则处理相关业务成为模型层.在struts2.0,其中m是action,c是拦截器，v是jsp.
```

* 你对面向对象思想的理解

```
(1)对象唯一性。  
每个对象都有自身唯一的标识，通过这种标识，可找到相应的对象。在对象的整个生命期中，它的标识都不改变，不同的对象不能有相同的标识。   
(2)分类性。
分类性是指将具有一致的数据结构(属性)和行为(操作)的对象抽象成类。一个类就是这样一种抽象，它反映了与应用有关的重要性质，而忽略其他一些无关内容。任何类的划分都是主观的，但必须与具体的应用有关。   
(3)继承性。  
继承性是子类自动共享父类数据结构和方法的机制，这是类之间的一种关系。在定义和实现一个类的时候，可以在一个已经存在的类的基础之上来进行，把这个已经存在的类所定义的内容作为自己的内容，并加入若干新的内容.
4)多态性(多形性)
多态性使指相同的操作或函数、过程可作用于多种类型的对象上并获得不同的结果。不同的对象，收到同一消息可以产生不同的结果，这种现象称为多态性。
```

* String s=new String("xyz")究竟对象个数分为两种情况：
```
1.如果String常理池中，已经创建"xyz"，则不会继续创建，此时只创建了一个对象new String("xyz")；
2.如果String常理池中，没有创建"xyz"，则会创建两个对象，一个对象的值是"xyz"，一个对象new String("xyz")
```

* 介绍下spring 
```
Spring提供了管理业务对象的一致方法并且鼓励了注入对接口编程而不是对类编程的良好习惯.
Spring的架构基础是基于使用JavaBean属性的Inversion of Control容器是一个解决了许多在J2EE开发中常见的问题的强大框架.
还提供了可以和总体的IoC容器集成的强大而灵活的MVC web框.
```

* spring 和 spring mvc 的父子容器管理
```
Spring和SpringMVC作为Bean管理容器和MVC层的默认框架，已被众多WEB应用采用，
而实际使用时，由于有了强大的注解功能，很多基于XML的配置方式已经被替代，
但是在实际项目中，同时配置Spring和SpringMVC时会出现一些奇怪的异常，
比如Bean被多次加载,多次实例化，或者依赖注入时，Bean不能被自动注入,但是明明你已经将该Bean注册了的。
找原因还是要看问题的根源，我们从容器说起。
```

```
在Spring整体框架的核心概念中，容器是核心思想，就是用来管理Bean的整个生命周期的，而在一个项目中，容器不一定只有一个，
Spring中可以包括多个容器，而且容器有上下层关系，
目前最常见的一种场景就是在一个项目中引入Spring和SpringMVC这两个框架，
其实就是2个容器，Spring是根容器，SpringMVC是其子容器，并且在Spring根容器中对于SpringMVC容器中的Bean是不可见的，
而在SpringMVC容器中对于Spring根容器中的Bean是可见的，也就是子容器可以看见父容器中的注册的Bean，反之就不行。
```

* 获得一个类的类对象有哪些方式？ 
``` 
- 方法1：类型.class，例如：String.class 
- 方法2：对象.getClass()，例如："hello".getClass() 
- 方法3：Class.forName()，例如：Class.forName("java.lang.String")
```

* 如何通过反射创建对象？ 
```
- 方法1：通过类对象调用newInstance()方法，例如：String.class.newInstance() 
- 方法2：通过类对象的getConstructor()或getDeclaredConstructor()
        方法获得构造器（Constructor）对象并调用其newInstance()
        方法创建对象，例如：String.class.getConstructor(String.class).newInstance("Hello");
```

* 如何通过反射调用对象的方法
```java
@Test
public void test01() {
    String str = "hello";
    Method m;
    try {
        m = str.getClass().getMethod("toUpperCase");
        System.out.println(m.invoke(str)); //HELLO
    }  catch (Exception e) {
        e.printStackTrace();
    }
}
```

* RESTful Web 服务四种操作POST/DELETE/PUT/GET
```
Rest模式有四种操作，
POST /uri 创建
DELETE /uri/xxx 删除
PUT /uri/xxx 更新或创建
GET /uri/xxx 查看
GET操作是安全的。所谓安全是指不管进行多少次操作，资源的状态都不会改变。
比如我用GET浏览文章，不管浏览多少次，那篇文章还在那，没有变化。
当然，你可能说每浏览一次文章，文章的浏览数就加一，这不也改变了资源的状态么？
这并不矛盾，因为这个改变不是GET操作引起的，而是用户自己设定的服务端逻辑造成的。

PUT，DELETE操作是幂等的。所谓幂等是指不管进行多少次操作，结果都一样。
比如我用PUT修改一篇文章，然后在做同样的操作，每次操作后的结果并没有不同，DELETE也是一样。
顺便说一句，因为GET操作是安全的，所以它自然也是幂等的。

POST操作既不是安全的，也不是幂等的，
比如常见的POST重复加载问题：当我们多次发出同样的POST请求后，其结果是创建出了若干的资源。

安全和幂等的意义在于：当操作没有达到预期的目标时，我们可以不停的重试，而不会对资源产生副作用。
从这个意义上说，POST操作往往是有害的，但很多时候我们还是不得不使用它。

还有一点需要注意的就是，创建操作可以使用POST，也可以使用PUT，区别在于POST 是作用在一个集合资源之上的（/uri），
而PUT操作是作用在一个具体资源之上的（/uri/xxx），
再通俗点说，如果URL可以在客户端确定，那么就使用PUT，如果是在服务端确定，那么就使用POST，
比如说很多资源使用数据库自增主键作为标识信息，而创建的资源的标识信息到底是什么只能由服务端提供，这个时候就必须使用POST。
```

* 选择使用Spring框架的原因（Spring框架为企业级开发带来的好处）？
```
1. IoC容器：IoC容器帮助应用程序管理对象以及对象之间的依赖关系，对象之间的依赖关系如果发生了改变只需要修改配置文件而不是修改代码，
因为代码的修改可能意味着项目的重新构建和完整的回归测试。有了IoC容器，程序员再也不需要自己编写工厂、单例，这一点特别符合Spring的精神“不要重复的发明轮子”。
2. AOP：面向切面编程，将所有的横切关注功能封装到切面（aspect）中，
通过配置的方式将横切关注功能动态添加到目标代码上，进一步实现了业务逻辑和系统服务之间的分离。
另一方面，有了AOP程序员可以省去很多自己写代理类的工作。
3. MVC：Spring的MVC框架是非常优秀的，从各个方面都可以甩Struts 2几条街，
为Web表示层提供了更好的解决方案。
4. 事务管理：Spring以宽广的胸怀接纳多种持久层技术，
并且为其提供了声明式的事务管理，在不需要任何一行代码的情况下就能够完成事务管理
```





















##### JAVA中怎么处理高并发的情况
```
一、背景综述
并发就是可以使用多个线程或进程，同时处理（就是并发）不同的操作。
高并发的时候就是有很多用户在访问，导致系统数据不正确、糗事数据的现象。对于一些大型网站，比如门户网站，在面对大量用户访问、高并发请求方面，基本的解决方案集中在这样几个环节：使用高性能的服务器、高性能的数据库、高效率的编程语言、还有高性能的Web容器。这几个解决思路在一定程度上意味着更大的投入。
使用一般的synchronized或者是lock或者是队列都是无法满足高并发的问题。

二、解决方法有三：
1.使用缓存
2.使用生成静态页面

html纯静态页面是效率最高、消耗最小的页面。我们可以使用信息发布系统来实现简单的信息录入自动生成静态页面，频道管理、权限管理和自动抓取等功能，对于一个大型网站来说，拥有一套高效、可管理的信息发布系统CMS是必不可少的。

3.图片服务器分离

图片是最消耗资源的，僵图片和页面分离可以降低提供页面访问请求的服务器系统压力，并且可以保证系统不会因为图片问题而崩溃。

4.写代码的时候减少不必要的资源浪费：

不要频繁得使用new对象，对于在整个应用中只需要存在一个实例的类使用单例模式.对于String的连接操作,使用StringBuffer或者StringBuilder.对于utility类型的类通过静态方法来访问。

避免使用错误的方式,如Exception可以控制方法推出,但是Exception要保留stacktrace消耗性能,除非必要不要使用instanceof做条件判断,尽量使用比的条件判断方式.使用JAVA中效率高的类,比如ArrayList比Vector性能好。)

使用线程安全的集合对象vector  hashtable

使用线程池
```

##### Java集群--大型网站是怎样解决多用户高并发访问的
```
为了解决大型网站的访问量大、并发量高、海量数据的问题，我们一般会考虑业务拆分和分布式部署。
我们可以把那些关联不太大的业务独立出来，部署到不同的机器上，从而实现大规模的分布式系统。
同时为了统一访问的入口，在集群机器的前面增加负载均衡设备nginx等。
```
##### Maven

* 熟练使用 Maven 等构建工具,什么是构建？
```
我们都知道，写完代码之后需要进行编译和运行，以笔者自身为例，使用 Eclipse 写完代码，需要进行编译，再生成 war 包，以便部署到 Tomcat。
在编写 Java 代码的时候，我们除了需要调用 jdk 的 api，还需要调用许多第三方的 api，加入没有构建工具，你需要把这些 jar 包下载到本地，然后添加进入工程，在 IDE 中进行添加设置。
这种方式非常繁琐，并且在遇到版本升级，git 同步等时候，程序会变得非常脆弱，极易产生未知错误。
所以便有了构建工具的产生，它可以让我们专注于写代码，而不需要考虑如何导入 jar 包，如何升级 jar 包版本，以及 git 多人协作等等问题。
这是在编译过程中的优势，在运行和发布的过程中，构建工具依然可以帮助我们将工程生成指定格式的文件。
```
* pom.xml
```
Maven项目的核心是pom.xml。POM( Project Object Model，项目对象模型)
定义了项目的基本信息，用于描述项目如何构建，声明项目依赖等。
```
* Maven 指令
```
Maven 的生命周期包括编译，运行，测试，打包，在不同的周期中，需要使用不同的指令来执行相应的功能，下面例举了一些常用的 Maven 指令以供参考。
编译源代码
mvn compile
发布项目
mvn deploy
编译测试源代码
mvn test-compile
运行应用程序中的单元测试
mvn test
生成项目相关信息的网站
mvn site
编译源代码
mvn compile
清除项目目录中的生成结果
mvn clean
根据项目生成的jar
mvn package
在本地Repository中安装jar
mvn install
生成eclipse项目文件
mvn eclipse:eclipse
启动jetty服务
mvn jetty:run
启动tomcat服务
mvn tomcat:run
清除以前的包后重新打包，跳过测试类
mvn clean package -Dmaven.test.skip=true
```
#### redis
* redis能完全替代MySQL吗？为什么
```
不会的。只能是一种互补。
redis把数据存在内存里读的速度快，但内存空间小。mysql是存放在硬盘上的。数据大。但是读硬盘肯定比读内存慢.
所以通常是两者结合起来，解决数据读取问题.

本质上Redis是一个基于内存的cache，在数据落地，持久化方面肯定不如MySQL可靠.
Redis基于内存，目前来说内存还是比较昂贵的.

其他:
1. Redis虽然默认提供了RDB和AOF两种数据持久化方式，不过很多前辈还是建议我不要太信任Redis的持久化功能，所以重要数据最好还是存放在MySQL，然后在Redis中做缓存。
2. 项目初期在访问量低的时候通过Redis实现了很多功能，当用户量大了以后很快发现内存不够用了就会很尴尬。合理的利用有限的内存，将读（写）频繁的热数据放在Redis中才能更好感受到它带来的性能提升
```

* mySQL里有2000w数据，redis中只存20w的数据，如何保证redis中的数据都是热点数据
```
redis 内存数据集大小上升到一定大小的时候，就会施行数据淘汰策略。redis 提供 6种数据淘汰策略：
volatile-lru：从已设置过期时间的数据集（server.db[i].expires）中挑选最近最少使用的数据淘汰
volatile-ttl：从已设置过期时间的数据集（server.db[i].expires）中挑选将要过期的数据淘汰
volatile-random：从已设置过期时间的数据集（server.db[i].expires）中任意选择数据淘汰
allkeys-lru：从数据集（server.db[i].dict）中挑选最近最少使用的数据淘汰
allkeys-random：从数据集（server.db[i].dict）中任意选择数据淘汰
no-enviction（驱逐）：禁止驱逐数据

设置maxmemory为20w数据的容量，然后用allkeys-lru
热点数据，可以按照查询时间来划分，设置过期时间

两点建议：
1、MySQL可以通过使用时间戳对数据表进行分区，将热点数据聚集到一个分区，然后Redis只从这个表的分区中取数据
2、Redis本身有页面淘汰策略，选择合适的策略即可
```


#### mysql
* mysql的复制原理以及流程。
```
复制是MySQL数据库提供的一种高可用，高性能的解决方案，一般用来建立大型应用。总体来说，复制的工作原理分为以下3个步骤：
1)master把数据更新记录到二进制日志(binary log)中,（这些记录叫做二进制日志事件，binary log events）。
2)slave将master的binary log events拷贝到它的中继日志(relay log)
3)slave重做中继日志中的事件，将改变反映它自己的数据。
工作原理：
```


* MySQL中myisam与innodb的区别，至少5点
```
(1)、问5点不同；
1>.InnoDB支持事物，而MyISAM不支持事物
2>.InnoDB支持行级锁，而MyISAM支持表级锁
3>.InnoDB支持MVCC, 而MyISAM不支持
4>.InnoDB支持外键，而MyISAM不支持
5>.InnoDB不支持全文索引，而MyISAM支持。

(2)、innodb引擎的4大特性
插入缓冲（insert buffer),二次写(double write),自适应哈希索引(ahi),预读(read ahead)

(3)、2者selectcount(*)哪个更快，为什么
myisam更快，因为myisam内部维护了一个计数器，可以直接调取。
```

* MySQL中varchar与char的区别以及varchar(50)中的50代表的涵义
```
(1)、varchar与char的区别
char是一种固定长度的类型，varchar则是一种可变长度的类型
(2)、varchar(50)中50的涵义
最多存放50个字符，varchar(50)和(200)存储hello所占空间一样，但后者在排序时会消耗更多内存，因为order by col采用fixed_length计算col长度(memory引擎也一样)
(3)、int（20）中20的涵义
是指显示字符的长度
但要加参数的，最大为255，比如它是记录行数的id,插入10笔资料，它就显示00000000001 ~~~00000000010，当字符的位数超过11,它也只显示11位，如果你没有加那个让它未满11位就前面加0的参数，它不会在前面加0
20表示最大显示宽度为20，但仍占4字节存储，存储范围不变；
(4)、mysql为什么这么设计
对大多数应用没有意义，只是规定一些工具用来显示字符的个数；int(1)和int(20)存储和计算均一样
```
* 问了innodb的事务与日志的实现方式
```
(1)、有多少种日志；
错误日志：记录出错信息，也记录一些警告信息或者正确的信息。
查询日志：记录所有对数据库请求的信息，不论这些请求是否得到了正确的执行。
慢查询日志：设置一个阈值，将运行时间超过该值的所有SQL语句都记录到慢查询的日志文件中。
二进制日志：记录对数据库执行更改的所有操作。
中继日志：
事务日志：

(2)、事物的4种隔离级别
隔离级别
读未提交(RU)
读已提交(RC)
可重复读(RR)
串行

(3)、事务是如何通过日志来实现的，说得越深入越好。
事务日志是通过redo和innodb的存储引擎日志缓冲（Innodb log buffer）来实现的，当开始一个事务的时候，会记录该事务的lsn(log sequence number)号; 当事务执行时，会往InnoDB存储引擎的日志
的日志缓存里面插入事务日志；当事务提交时，必须将存储引擎的日志缓冲写入磁盘（通过innodb_flush_log_at_trx_commit来控制），也就是写数据前，需要先写日志。这种方式称为“预写日志方式”
```
* 问了下MySQL数据库cpu飙升到500%的话他怎么处理？
```
(1)、没有经验的，可以不问；
(2)、有经验的，问他们的处理思路。
列出所有进程  show processlist  观察所有进程  多秒没有状态变化的(干掉)
查看超时日志或者错误日志 (做了几年开发,一般会是查询以及大批量的插入会导致cpu与i/o上涨,,,,当然不排除网络状态突然断了,,导致一个请求服务器只接受到一半，比如where子句或分页子句没有发送,,当然的一次被坑经历)
```

* 使用explain分析该dql语句：
```
explain select * from bpm_ru_path where PATH_ID_='148955392356078'
会产生如下信息：
select_type:表示查询的类型。
table:输出结果集的表
type:表示表的连接类型(system和const为佳)
possible_keys:表示查询时，可能使用的索引
key:表示实际使用的索引
key_len:索引字段的长度
rows:扫描的行数
Extra:执行情况的描述和说明

注意：要尽量避免让type的结果为all，extra的结果为：using filesort
```
![explain分析sql语句](./images/explain分析sql语句.png)


* 你是否做过主从一致性校验，如果有，怎么做的，如果没有，你打算怎么做？
```
主从一致性校验有多种工具 例如checksum、mysqldiff、pt-table-checksum等.
pt-table-checksum是一个在线验证主从数据一致性的工具,主要用于以下场景:
1. 数据迁移前后,进行数据一致性检查
2. 当主从复制出现问题,待修复完成后,对主从数据进行一致性检查
3. 把从库当成主库,进行数据更新,产生了"脏数据"
4. 定期校验
```
* 你是如何维护数据库的数据字典的？
```
这个大家维护的方法都不同，我一般是直接在生产库进行注释，利用工具导出成excel方便流通。
```
* 开放性问题：据说是腾讯的
```
一个6亿的表a，一个3亿的表b，通过外间tid关联，你如何最快的查询出满足条件的第50000到第50200中的这200条数据记录。
1、如果A表TID是自增长,并且是连续的,B表的ID为索引
select * from a,b where a.tid = b.id and a.tid>500000 limit 200;

2、如果A表的TID不是连续的,那么就需要使用覆盖索引.TID要么是主键,要么是辅助索引,B表ID也需要有索引。
select * from b , (select tid from a limit 50000,200) a where b.id = a .tid;
```

#### java 算法
* 利用冒泡排序对数组进行排序
```java
public static void main(String[] args) {
    int arr[] = new int[]{1,6,2,2,5};
    BubbleSort(arr);
    System.out.println(Arrays.toString(arr));
}
public static void BubbleSort(int[] arr) {
    int temp;//定义一个临时变量
    for(int i=0;i<arr.length-1;i++){//冒泡趟数
        for(int j=0;j<arr.length-i-1;j++){
            if(arr[j+1]<arr[j]){
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}
```
* 打印出所有的 "水仙花数 "
```
所谓 "水仙花数 "是指一个三位数，其各位数字立方和等于该数本身。
例如：153是一个 "水仙花数 "，因为153=1的三次方＋5的三次方＋3的三次方
```
```java
public boolean shuiXianHua(int x)
{
    int i = 0, j = 0, k = 0;
    i = x / 100;
    j = (x % 100) / 10;
    k = x % 10;
    int temp = i * i * i + j * j * j + k * k * k;
    if (x == temp){
        return true;
    }else{
        return false;
    }
}
```
* 一球从100米高度自由落下，每次落地后反跳回原高度的一半；再落下，求它在   第10次落地时，共经过多少米？第10次反弹多高？
```java
    @Test
    public void test02() {
        double s = 0;
        double t = 100;
        for (int i = 1; i <= 10; i++) {
            s += t;
            t = t / 2;
        }
        System.out.println(s);
        System.out.println(t);
    }
```
* 输出9*9口诀
```java
    @Test
    public void test02() {
        int i = 0;
        int j = 0;
        for (i = 1; i <= 9; i++) {
            for (j = 1; j <= 9; j++){
                System.out.print(i + "*" + j + "=" + i * j + "\t");
            }
            System.out.println();
        }
    }
```
#### spring
* Spring工作原理
```
    内部最核心的就是IOC了，  
    动态注入，让一个对象的创建不用new了，可以自动的生产，这其实就是利用java里的反射  
反射其实就是在运行时动态的去创建、调用对象，Spring就是在运行时，跟xml Spring的配置  
文件来动态的创建对象，和调用对象里的方法的 。  
    Spring还有一个核心就是AOP这个就是面向切面编程，可以为某一类对象 进行监督和控制（也就是  
在调用这类对象的具体方法的前后去调用你指定的 模块）从而达到对一个模块扩充的功能。这些都是通过  
配置类达到的。  
    Spring目的：就是让对象与对象（模块与模块）之间的关系没有通过代码来关联，都是通过配置类说明  
管理的（Spring根据这些配置 内部通过反射去动态的组装对象）  
    要记住：Spring是一个容器，凡是在容器里的对象才会有Spring所提供的这些服务和功能。 
```

#### SpringMVC
* SpringMVC工作原理
```
1、客户端发出一个http请求给web服务器，web服务器对http请求进行解析，如果匹配DispatcherServlet的请求映射路径（在web.xml中指定），web容器将请求转交给DispatcherServlet.
2、DipatcherServlet接收到这个请求之后将根据请求的信息（包括URL、Http方法、请求报文头和请求参数Cookie等）以及HandlerMapping的配置找到处理请求的处理器（Handler）。
3-4、DispatcherServlet根据HandlerMapping找到对应的Handler,将处理权交给Handler（Handler将具体的处理进行封装），再由具体的HandlerAdapter对Handler进行具体的调用。
5、Handler对数据处理完成以后将返回一个ModelAndView()对象给DispatcherServlet。
6、Handler返回的ModelAndView()只是一个逻辑视图并不是一个正式的视图，DispatcherSevlet通过ViewResolver将逻辑视图转化为真正的视图View。
7、Dispatcher通过model解析出ModelAndView()中的参数进行解析最终展现出完整的view并返回给客户端。
```
![SpringMVC工作原理图](./images/SpringMVC工作原理图.png)

#### jdbc 
* jdbc 
```java
package com.example.utils;
import java.sql.Connection;
import java.sql.DriverManager;
public class JdbcUtil {
    private static String url = "jdbc:mysql:///tusers";
    private static String user = "root";
    private static String password = "root";
    // 连接数据库
    public static Connection getConnection(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
```

```java
// 测试
@Test
public void test01() throws Exception{
    String sql = "select * from tbuser";
    Connection con = JdbcUtil.getConnection();
    QueryRunner qr = new QueryRunner();
    List<Tbuser> list = qr.query(con, sql,new BeanListHandler<Tbuser>(Tbuser.class));
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i).getRealname());
        }
    }
    con.close();
}
```

```java
// pojo
public class Tbuser {
    private Integer userid;
    private String username;
    private String realname;
    private Long telephonenum;
    private String email;
    private String userdescribe;
    private String password;
    // get,set ......
}
```















