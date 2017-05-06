# mybatis

<!-- toc -->

## mybatis初级
### 1.mybatis框架
#### mybatis是什么 
```
mybatis是一个持久层的框架，是apache下的顶级项目。
mybatis托管到goolecode下，再后来托管到github下(https://github.com/mybatis/mybatis-3/releases)。

mybatis让程序将主要精力放在sql上，通过mybatis提供的映射方式，自由灵活生成（半自动化，大部分需要程序员编写sql）满足需要sql语句。

mybatis可以将向 preparedStatement中的输入参数自动进行输入映射，将查询结果集灵活映射成java对象。（输出映射）
```

### 2.入门demo
#### 2.1 sql脚本
##### sql_table
```sql
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '商品名称',
  `price` float(10,1) NOT NULL COMMENT '商品定价',
  `detail` text COMMENT '商品描述',
  `pic` varchar(64) DEFAULT NULL COMMENT '商品图片',
  `createtime` datetime NOT NULL COMMENT '生产日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `orderdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL COMMENT '订单id',
  `items_id` int(11) NOT NULL COMMENT '商品id',
  `items_num` int(11) DEFAULT NULL COMMENT '商品购买数量',
  PRIMARY KEY (`id`),
  KEY `FK_orderdetail_1` (`orders_id`),
  KEY `FK_orderdetail_2` (`items_id`),
  CONSTRAINT `FK_orderdetail_1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_orderdetail_2` FOREIGN KEY (`items_id`) REFERENCES `items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '下单用户id',
  `number` varchar(32) NOT NULL COMMENT '订单号',
  `createtime` datetime NOT NULL COMMENT '创建订单时间',
  `note` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `FK_orders_1` (`user_id`),
  CONSTRAINT `FK_orders_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL COMMENT '用户名称',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

```

##### sql_data
```sql
insert  into `items`(`id`,`name`,`price`,`detail`,`pic`,`createtime`)  values (1,'台式机',3000.0,'该电脑质量非常好！！！！',NULL,'2015-02-03 13:22:53'),(2,'笔记本',6000.0,'笔记本性能好，质量好！！！！！',NULL,'2015-02-09 13:22:57'),(3,'背包',200.0,'名牌背包，容量大质量好！！！！',NULL,'2015-02-06 13:23:02');

insert  into `orderdetail`(`id`,`orders_id`,`items_id`,`items_num`) values (1,3,1,1),(2,3,2,3),(3,4,3,4),(4,4,2,3);

insert  into `orders`(`id`,`user_id`,`number`,`createtime`,`note`) values (3,1,'1000010','2015-02-04 13:22:35',NULL),(4,1,'1000011','2015-02-03 13:22:41',NULL),(5,10,'1000012','2015-02-12 16:13:23',NULL);

insert  into `user`(`id`,`username`,`birthday`,`sex`,`address`) values (1,'王五',NULL,'2',NULL),(10,'张三','2014-07-10','1','北京市'),(16,'张小明',NULL,'1','河南郑州'),(22,'陈小明',NULL,'1','河南郑州'),(24,'张三丰',NULL,'1','河南郑州'),(25,'陈小明',NULL,'1','河南郑州'),(26,'王五',NULL,NULL,NULL);
```

#### 2.2 根据用户id（主键）查询用户信息
* 创建pojo类

```java
public class User {
    //属性名和数据库表的字段对应
    private int id;
    private String username;// 用户姓名
    private String sex;// 性别
    private Date birthday;// 生日
    private String address;// 地址
}
```

* 映射文件
```
映射文件命名：
User.xml（原始ibatis命名），mapper代理开发映射文件名称叫XXXMapper.xml，比如：UserMapper.xml、ItemsMapper.xml
在映射文件中配置sql语句。
```

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- namespace命名空间，作用就是对sql进行分类化管理，理解sql隔离 
注意：使用mapper代理方法开发，namespace有特殊重要的作用，namespace等于mapper接口地址
-->
<mapper namespace="test">
    <!-- 在 映射文件中配置很多sql语句 -->
    <!-- 需求：通过id查询用户表的记录 -->
    <!-- 通过 select执行数据库查询
    id：标识 映射文件中的 sql
    将sql语句封装到mappedStatement对象中，所以将id称为statement的id
    parameterType：指定输入 参数的类型，这里指定int型 
    #{}表示一个占位符号
    #{id}：其中的id表示接收输入 的参数，参数名称就是id，如果输入 参数是简单类型，#{}中的参数名可以任意，可以value或其它名称
    
    resultType：指定sql输出结果 的所映射的java对象类型，select指定resultType表示将单条记录映射成的java对象。
     -->
    <select id="findUserById" parameterType="int" resultType="user">
        SELECT * FROM USER WHERE id=#{id}
    </select>
</mapper>
```

* 在sqlMapConfig.xml中加载User.xml
```
<mappers>
    <mapper resource="sql/User.xml"/>
</mappers>
```

* 程序实现
```java
    // 根据id查询用户信息，得到一条记录结果
    @Test
    public void findUserByIdTest() throws IOException {
        // mybatis配置文件
        String resource = "SqlMapConfig.xml";
        // 得到配置文件流
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 创建会话工厂，传入mybatis的配置文件信息
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
        // 通过工厂得到SqlSession
        SqlSession sqlSession = sqlSessionFactory.openSession();
        // 通过SqlSession操作数据库
        // 第一个参数：映射文件中statement的id，等于=namespace+"."+statement的id
        // 第二个参数：指定和映射文件中所匹配的parameterType类型的参数
        // sqlSession.selectOne结果 是与映射文件中所匹配的resultType类型的对象
        // selectOne查询出一条记录
        User user = sqlSession.selectOne("test.findUserById", 1);
        System.out.println(user);
        // 释放资源
        sqlSession.close();
    }
```

#### 2.3 根据用户名称模糊查询用户信息
* 映射文件,使用User.xml，添加根据用户名称模糊查询用户信息的sql语句。

```xml
    <!-- 根据用户名称模糊查询用户信息，可能返回多条
    resultType：指定就是单条记录所映射的java对象 类型
    ${}:表示拼接sql串，将接收到参数的内容不加任何修饰拼接在sql中。
    使用${}拼接sql，引起 sql注入
    ${value}：接收输入 参数的内容，如果传入类型是简单类型，${}中只能使用value
     -->
    <select id="findUserByName" parameterType="java.lang.String" resultType="cn.example.mybatis.po.User">
        SELECT * FROM USER WHERE username LIKE '%${value}%'
    </select>
```


* 程序实现
```java
   // 根据用户名称模糊查询用户列表
    @Test
    public void findUserByNameTest() throws IOException {
        // mybatis配置文件
        String resource = "SqlMapConfig.xml";
        // 得到配置文件流
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 创建会话工厂，传入mybatis的配置文件信息
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
        // 通过工厂得到SqlSession
        SqlSession sqlSession = sqlSessionFactory.openSession();
        // list中的user和映射文件中resultType所指定的类型一致
        List<User> list = sqlSession.selectOne("test.findUserByName", "小明");
        System.out.println(list);
        sqlSession.close();
    }
```
#### 2.4 添加用户
* 在 User.xml中配置添加用户的Statement
```xml
<!-- 添加用户 
    parameterType：指定输入 参数类型是pojo（包括 用户信息）
    #{}中指定pojo的属性名，接收到pojo对象的属性值，mybatis通过OGNL获取对象的属性值
    -->
    <insert id="insertUser" parameterType="cn.example.mybatis.po.User">
        insert into user(username,birthday,sex,address) value(#{username},#{birthday},#{sex},#{address})
    </insert>
```

* 代码实现
```java
    // 添加用户信息
    @Test
    public void insertUserTest() throws IOException {
        // mybatis配置文件
        String resource = "SqlMapConfig.xml";
        // 得到配置文件流
        InputStream inputStream = Resources.getResourceAsStream(resource);

        // 创建会话工厂，传入mybatis的配置文件信息
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
        // 通过工厂得到SqlSession
        SqlSession sqlSession = sqlSessionFactory.openSession();
        // 插入用户对象
        User user = new User();
        user.setUsername("王小军");
        user.setBirthday(new Date());
        user.setSex("1");
        user.setAddress("河南郑州");
        sqlSession.insert("test.insertUser", user);
        // 提交事务
        sqlSession.commit();
        // 获取用户信息主键
        System.out.println(user.getId());
        // 关闭会话
        sqlSession.close();
    }
```

#### 2.5 删除用户
* 映射文件
```xml
    <!-- 删除用户,根据id删除用户，需要输入 id值
     -->
    <delete id="deleteUser" parameterType="java.lang.Integer">
        delete from user where id=#{id}
    </delete>
```

* 代码实现
```java
    // 根据id删除 用户信息
    @Test
    public void deleteUserTest() throws IOException {
        // mybatis配置文件
        String resource = "SqlMapConfig.xml";
        // 得到配置文件流
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 创建会话工厂，传入mybatis的配置文件信息
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
        // 通过工厂得到SqlSession
        SqlSession sqlSession = sqlSessionFactory.openSession();
        // 传入id删除 用户
        sqlSession.delete("test.deleteUser", 39);
        // 提交事务
        sqlSession.commit();
        // 关闭会话
        sqlSession.close();
    }
```

#### 2.6 更新用户
* 映射文件
```xml
    <!-- 根据id更新用户
    分析：
    需要传入用户的id
    需要传入用户的更新信息
    parameterType指定user对象，包括 id和更新信息，注意：id必须存在
    #{id}：从输入 user对象中获取id属性值
     -->
    <update id="updateUser" parameterType="cn.example.mybatis.po.User">
        update user set username=#{username},birthday=#{birthday},sex=#{sex},address=#{address} 
         where id=#{id}
    </update>
```

* 代码实现
```java
    // 更新用户信息
    @Test
    public void updateUserTest() throws IOException {
        // mybatis配置文件
        String resource = "SqlMapConfig.xml";
        // 得到配置文件流
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 创建会话工厂，传入mybatis的配置文件信息
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
        // 通过工厂得到SqlSession
        SqlSession sqlSession = sqlSessionFactory.openSession();
        // 更新用户信息
        User user = new User();
        //必须设置id
        user.setId(41);
        user.setUsername("王大军");
        user.setBirthday(new Date());
        user.setSex("2");
        user.setAddress("河南郑州");
        sqlSession.update("test.updateUser", user);    
        // 提交事务
        sqlSession.commit();
        // 关闭会话
        sqlSession.close();
    }
```

#### 2.7 小结
* parameterType & resultType
```
在映射文件中通过parameterType指定输入参数的类型。
在映射文件中通过resultType指定输出结果的类型.
```

* #{}和${}
```
#{}表示一个占位符号，#{}接收输入参数，类型可以是简单类型，pojo、hashmap。
如果接收简单类型，#{}中可以写成value或其它名称。
#{}接收pojo对象值，通过OGNL读取对象中的属性值，通过属性.属性.属性...的方式获取对象属性值。

${}表示一个拼接符号，会引用sql注入，所以不建议使用${}。
${}接收输入参数，类型可以是简单类型，pojo、hashmap。
如果接收简单类型，${}中只能写成value。
${}接收pojo对象值，通过OGNL读取对象中的属性值，通过属性.属性.属性...的方式获取对象属性值。
```

* selectOne和selectList
```
selectOne表示查询出一条记录进行映射。如果使用selectOne可以实现使用selectList也可以实现（list中只有一个对象）。

selectList表示查询出一个列表（多条记录）进行映射。如果使用selectList查询多条记录，则不能使用selectOne。

如果使用selectOne报错：
org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 4
```

* mybatis和hibernate本质区别和应用场景
```
hibernate：是一个标准ORM框架（对象关系映射）。入门门槛较高的，不需要程序写sql，sql语句自动生成了。
对sql语句进行优化、修改比较困难的。
应用场景：
    适用与需求变化不多的中小型项目，比如：后台管理系统，erp、orm、oa。。

mybatis：专注是sql本身，需要程序员自己编写sql语句，sql修改、优化比较方便。mybatis是一个不完全 的ORM框架，虽然程序员自己写sql，mybatis 也可以实现映射（输入映射、输出映射）。
应用场景：
    适用与需求变化较多的项目，比如：互联网项目。
企业进行技术选型，以低成本 高回报作为技术选型的原则，根据项目组的技术力量进行选择。
```

### 3.mybatis开发Dao的方法


#### 3.1 SqlSession使用范围
* SqlSessionFactoryBuilder
```
 通过SqlSessionFactoryBuilder创建会话工厂SqlSessionFactory
将SqlSessionFactoryBuilder当成一个工具类使用即可，不需要使用单例管理SqlSessionFactoryBuilder。
在需要创建SqlSessionFactory时候，只需要new一次SqlSessionFactoryBuilder即可。
```

* SqlSessionFactory
```
通过SqlSessionFactory创建SqlSession，使用单例模式管理sqlSessionFactory（工厂一旦创建，使用一个实例）。

将来mybatis和spring整合后，使用单例模式管理sqlSessionFactory。
```

* SqlSession
```
SqlSession是一个面向用户（程序员）的接口。
SqlSession中提供了很多操作数据库的方法：如：selectOne(返回单个对象)、selectList（返回单个或多个对象）、。

SqlSession是线程不安全的，在SqlSesion实现类中除了有接口中的方法（操作数据库的方法）还有数据域属性。

SqlSession最佳应用场合在方法体内，定义成局部变量使用。
```

#### 3.2 原始dao开发方法:需要写dao接口和dao实现类
* 思路
```
程序员需要写dao接口和dao实现类。
需要向dao实现类中注入SqlSessionFactory，在方法体内通过SqlSessionFactory创建SqlSession
```

* dao接口
```java
public interface UserDao {
    //根据id查询用户信息
    public User findUserById(int id) throws Exception;
    //根据用户名列查询用户列表
    public List<User> findUserByName(String name) throws Exception;
    //添加用户信息
    public void insertUser(User user) throws Exception;
    //删除用户信息
    public void deleteUser(int id) throws Exception;
}
```
* dao实现类
```java
public class UserDaoImpl implements UserDao {
    // 需要向dao实现类中注入SqlSessionFactory
    // 这里通过构造方法注入
    private SqlSessionFactory sqlSessionFactory;

    public UserDaoImpl(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    @Override
    public User findUserById(int id) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        User user = sqlSession.selectOne("test.findUserById", id);
        // 释放资源
        sqlSession.close();
        return user;
    }
    
    @Override
    public List<User> findUserByName(String name) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        List<User> list = sqlSession.selectList("test.findUserByName", name);
        // 释放资源
        sqlSession.close();
        return list;
    }
    @Override
    public void insertUser(User user) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //执行插入操作
        sqlSession.insert("test.insertUser", user);
        // 提交事务
        sqlSession.commit();
        // 释放资源
        sqlSession.close();
    }
    @Override
    public void deleteUser(int id) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //执行插入操作
        sqlSession.delete("test.deleteUser", id);
        // 提交事务
        sqlSession.commit();
        // 释放资源
        sqlSession.close();
    }
}
```

* 测试代码
```java
public class UserDaoImplTest {
    private SqlSessionFactory sqlSessionFactory;
    // 此方法是在执行testFindUserById之前执行
    @Before
    public void setUp() throws Exception {
        // 创建sqlSessionFactory
        // mybatis配置文件
        String resource = "SqlMapConfig.xml";
        // 得到配置文件流
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 创建会话工厂，传入mybatis的配置文件信息
        sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
    }

    @Test
    public void testFindUserById() throws Exception {
        // 创建UserDao的对象
        UserDao userDao = new UserDaoImpl(sqlSessionFactory);
        // 调用UserDao的方法
        User user = userDao.findUserById(1);    
        System.out.println(user);
    }
}
```

* 总结原始 dao开发问题
```
1、dao接口实现类方法中存在大量模板方法，设想能否将这些代码提取出来，大大减轻程序员的工作量。

2、调用sqlsession方法时将statement的id硬编码了

3、调用sqlsession方法时传入的变量，由于sqlsession方法使用泛型，即使变量类型传入错误，在编译阶段也不报错，不利于程序员开发。
```

#### 3.3 mapper代理方法:只需要mapper接口(相当于dao接口)
* 思路（mapper代理开发规范）
```
程序员还需要编写mapper.xml映射文件
程序员编写mapper接口需要遵循一些开发规范，mybatis可以自动生成mapper接口实现类代理对象。

开发规范：
1、在mapper.xml中namespace等于mapper接口地址
<!-- namespace命名空间，作用就是对sql进行分类化管理，理解sql隔离 
注意：使用mapper代理方法开发，namespace有特殊重要的作用，namespace等于mapper接口地址
-->
<mapper namespace="cn.example.mybatis.mapper.UserMapper">

2、mapper.java接口中的方法名和mapper.xml中statement的id一致

3、mapper.java接口中的方法输入参数类型和mapper.xml中statement的parameterType指定的类型一致。

4、mapper.java接口中的方法返回值类型和mapper.xml中statement的resultType指定的类型一致。

    //根据id查询用户信息
    public User findUserById(int id) throws Exception;

    <select id="findUserById" parameterType="int" resultType="cn.example.mybatis.po.User">
        SELECT * FROM USER WHERE id=#{id}
    </select>
```


* mapper.java
```java
public interface UserMapper {
    //根据id查询用户信息
    public User findUserById(int id) throws Exception;
}
```

* mapper.xml
```xml
    <select id="findUserById" parameterType="int" resultType="cn.example.mybatis.po.User">
        SELECT * FROM USER WHERE id=#{id}
    </select>
```

* 在SqlMapConfig.xml中加载mapper.xml
```xml
<!-- 加载 映射文件 -->
    <mappers>
        <!--通过resource方法一次加载一个映射文件 -->
        <mapper resource="mapper/UserMapper.xml"/> 
    </mappers>
```

* 测试
```java
public class UserMapperTest {
    private SqlSessionFactory sqlSessionFactory;
    // 此方法是在执行testFindUserById之前执行
    @Before
    public void setUp() throws Exception {
        // 创建sqlSessionFactory
        // mybatis配置文件
        String resource = "SqlMapConfig.xml";
        // 得到配置文件流
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 创建会话工厂，传入mybatis的配置文件信息
        sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
    }
    @Test
    public void testFindUserById() throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //创建UserMapper对象，mybatis自动生成mapper代理对象
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        //调用userMapper的方法
        User user = userMapper.findUserById(1);
        System.out.println(user); 
    }
}
```

* 一些问题总结
```
1. 代理对象内部调用selectOne或selectList
如果mapper方法返回单个pojo对象（非集合对象），代理对象内部通过selectOne查询数据库。
如果mapper方法返回集合对象，代理对象内部通过selectList查询数据库。

2. mapper接口方法参数只能有一个是否影响系统 开发
mapper接口方法参数只能有一个，系统是否不利于扩展维护。

系统 框架中，dao层的代码是被业务层公用的。
即使mapper接口只有一个参数，可以使用包装类型的pojo满足不同的业务方法的需求。

注意：持久层方法的参数可以包装类型、map...，service方法中建议不要使用包装类型（不利于业务层的可扩展）。
```

### 4.SqlMapConfig.xml
```
mybatis的全局配置文件SqlMapConfig.xml，配置内容如下：
properties（属性）
settings（全局配置参数）
typeAliases（类型别名）
typeHandlers（类型处理器）
objectFactory（对象工厂）
plugins（插件）
environments（环境集合属性对象）
environment（环境子属性对象）
transactionManager（事务管理）
dataSource（数据源）
mappers（映射器）
```

#### 4.1 properties属性
```
注意： MyBatis 将按照下面的顺序来加载属性：
    1.在 properties 元素体内定义的属性首先被读取。 
    2.然后会读取properties 元素中resource或 url 加载的属性，它会覆盖已读取的同名属性。 
    3.最后读取parameterType传递的属性，它会覆盖已读取的同名属性。

建议：
    不要在properties元素体内添加任何属性值，只将属性值定义在properties文件中。
    在properties文件中定义属性名要有一定的特殊性，如：XXXXX.XXXXX.XXXX
```

#### 4.2 settings全局参数配置
```
mybatis框架在运行时可以调整一些运行参数。
比如：开启二级缓存、开启延迟加载。。

全局参数将会影响mybatis的运行行为。
```

#### 4.3 typeAliases(别名)
##### 4.3.1 需求
```
在mapper.xml中，定义很多的statement，statement需要parameterType指定输入参数的类型、需要resultType指定输出结果的映射类型。

如果在指定类型时输入类型全路径，不方便进行开发，可以针对parameterType或resultType指定的类型定义一些别名，在mapper.xml中通过别名定义，方便开发。
```

##### 4.3.2 mybatis默认支持别名
```
别名                映射的类型
_byte               byte 
_long               long 
_short              short 
_int                int 
_integer            int 
_double             double 
_float              float 
_boolean            boolean 
string              String 
byte                Byte 
long                Long 
short               Short 
int                 Integer 
integer             Integer 
double              Double 
float               Float 
boolean             Boolean 
date                Date 
decimal             BigDecimal 
bigdecimal          BigDecimal
```

##### 4.3.3   自定义别名
* 单个别名定义
```xml
    <!-- 别名定义 -->
    <typeAliases>
        <!-- 针对单个别名定义
        type：类型的路径
        alias：别名
         -->
        <typeAlias type="cn.example.mybatis.po.User" alias="user"/>       
    </typeAliases>
```

* 引用别名 ```resultType="user"```
```xml
    <!-- resultType="user" -->
    <select id="findUserById" parameterType="int" resultType="user">
        SELECT * FROM USER WHERE id=#{id}
    </select>
```

* 批量定义别名（常用）
```xml
    <!-- 别名定义 -->
    <typeAliases>
        <!-- 批量别名定义 
        指定包名，mybatis自动扫描包中的po类，自动定义别名，别名就是类名（首字母大写或小写都可以）
        -->
        <package name="cn.example.mybatis.po"/>
    </typeAliases>
```

#### 4.4 typeHandlers(类型处理器)
```
mybatis中通过typeHandlers完成jdbc类型和java类型的转换。
通常情况下，mybatis提供的类型处理器满足日常需要，不需要自定义.
```

#### 4.5 mappers(映射配置)
##### 4.5.1 通过resource加载单个映射文件
```xml
<!--通过resource方法一次加载一个映射文件 -->
<mapper resource="mapper/UserMapper.xml"/>
```

##### 4.5.2   通过mapper接口加载单个mapper
```xml
<!-- 通过mapper接口加载单个 映射文件
遵循一些规范：需要将mapper接口类名和mapper.xml映射文件名称保持一致，且在一个目录中
上边规范的前提是：使用的是mapper代理方法
-->
<mapper class="cn.example.mybatis.mapper.UserMapper"/>
```

```
按照上边的规范，将mapper.java和mapper.xml放在一个目录，且同名(UserMapper.java,UserMapper.xml)。
```
##### 4.5.3   批量加载mapper(推荐使用)
```xml
    <mappers>    
        <!-- 批量加载mapper
        指定mapper接口的包名，mybatis自动扫描包下边所有mapper接口进行加载
        遵循一些规范：需要将mapper接口类名和mapper.xml映射文件名称保持一致，且在一个目录中
        上边规范的前提是：使用的是mapper代理方法
         -->
        <package name="cn.example.mybatis.mapper"/>
    </mappers>
```
### 5.输入映射
```
通过parameterType指定输入参数的类型，类型可以是简单类型、hashMap、pojo的包装类型
```

* 需求
```
完成用户信息的综合查询，需要传入查询条件很复杂（可能包括用户信息、其它信息，比如商品、订单的）
```

* 定义包装类型pojo
```
针对上边需求，建议使用自定义的包装类型的pojo。
在包装类型的pojo中将复杂的查询条件包装进去
```

```java
public class UserQueryVo {
    //用户查询条件
    private UserCustom userCustom;
    public UserCustom getUserCustom() {
        return userCustom;
    }
    public void setUserCustom(UserCustom userCustom) {
        this.userCustom = userCustom;
    }
    //可以包装其它的查询条件，订单、商品 ......
}
```
* mapper.xml
``` 
在UserMapper.xml中定义用户信息综合查询（查询条件复杂，通过高级查询进行复杂关联查询）
```

```xml
    <!-- 用户信息综合查询
    #{userCustom.sex}:取出pojo包装对象中性别值
    ${userCustom.username}：取出pojo包装对象中用户名称
     -->
    <select id="findUserList" parameterType="cn.example.mybatis.po.UserQueryVo" 
            resultType="cn.example.mybatis.po.UserCustom">
    SELECT * FROM USER WHERE user.sex = #{userCustom.sex} AND user.username LIKE '%${userCustom.username}%' 
    </select>
```

* mapper.java
```java
// 用户信息综合查询
public List<UserCustom> findUserList(UserQueryVo userQueryVo) throws Exception;
```
* 测试代码
```java
    //用户信息的综合 查询
    @Test
    public void testFindUserList() throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //创建UserMapper对象，mybatis自动生成mapper代理对象
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        //创建包装对象，设置查询条件
        UserQueryVo userQueryVo = new UserQueryVo();
        UserCustom userCustom = new UserCustom();
        userCustom.setSex("1");
        userCustom.setUsername("小明");
        userQueryVo.serUserCustom(userCustom);
        // 调用userMapper的方法
        List<UserCustom> list = userMapper.findUserList(userQueryVo);     
        System.out.println(list);     
    }
```


### 6.输出映射:resultType&resultMap
#### 6.1 resultType
```
使用resultType进行输出映射，只有查询出来的列名和pojo中的属性名一致，该列才可以映射成功.
如果查询出来的列名和pojo中的属性名全部不一致，没有创建pojo对象.
只要查询出来的列名和pojo中的属性有一个一致，就会创建pojo对象.
```
##### 输出简单类型
```xml
<!-- 查询出来的结果集只有一行且一列，可以使用简单类型进行输出映射。 -->
    <select id="findUserCount" parameterType="cn.example.mybatis.po.UserQueryVo" resultType="int">
       SELECT count(*) FROM USER      
    </select>
```
##### 输出pojo对象和pojo列表
```
1.不管是输出的pojo单个对象还是一个列表（list中包括pojo），在mapper.xml中resultType指定的类型是一样的。
2.在mapper.java指定的方法返回值类型不一样.
3.生成的动态代理对象中是根据mapper方法的返回值类型确定是调用selectOne(返回单个对象调用)还是selectList（返回集合对象调用 ）
```

#### 6.2 resultMap
```
mybatis中使用resultMap完成高级输出结果映射
```
##### resultMap使用方法
```
如果查询出来的列名和pojo的属性名不一致，通过定义一个resultMap对列名和pojo属性名之间作一个映射关系。
```
1、定义resultMap
```xml
    <!-- 定义resultMap
    将SELECT id id_,username username_ FROM USER 和User类中的属性作一个映射关系
    
    type：resultMap最终映射的java对象类型,可以使用别名
    id：对resultMap的唯一标识
     -->
     <resultMap type="user" id="userResultMap">
        <!-- id表示查询结果集中唯一标识 
        column：查询出来的列名
        property：type指定的pojo类型中的属性名
        最终resultMap对column和property作一个映射关系 （对应关系）
        -->
        <id column="id_" property="id"/>
        <!-- 
        result：对普通名映射定义
        column：查询出来的列名
        property：type指定的pojo类型中的属性名
        最终resultMap对column和property作一个映射关系 （对应关系）
         -->
        <result column="username_" property="username"/>
     </resultMap>
```
2、使用resultMap作为statement的输出映射类型
```xml
    <!-- 使用resultMap进行输出映射
    resultMap：指定定义的resultMap的id，如果这个resultMap在其它的mapper文件，前边需要加namespace
    -->
    <select id="findUserByIdResultMap" parameterType="int" resultMap="userResultMap">
        SELECT id id_,username username_ FROM USER WHERE id=#{value}
    </select>
```

#### 6.3 小结
```
使用resultType进行输出映射，只有查询出来的列名和pojo中的属性名一致，该列才可以映射成功。
如果查询出来的列名和pojo的属性名不一致，通过定义一个resultMap对列名和pojo属性名之间作一个映射关系。
```

### 7.动态sql
#### 7.1 什么是动态sql
```
mybatis核心 :对sql语句进行灵活操作，通过表达式进行判断，对sql进行灵活拼接、组装。
```

#### 7.2 需求
```
用户信息综合查询列表和用户信息查询列表总数这两个statement的定义使用动态sql。
对查询条件进行判断，如果输入参数不为空才进行查询条件拼接。
```

#### 7.3 mapper.xml
```xml
    <!-- 用户信息综合查询
    #{userCustom.sex}:取出pojo包装对象中性别值
    ${userCustom.username}：取出pojo包装对象中用户名称
     -->
    <select id="findUserList" parameterType="cn.itcast.mybatis.po.UserQueryVo" 
            resultType="cn.itcast.mybatis.po.UserCustom">
    SELECT * FROM USER
    <!-- 
    where可以自动去掉条件中的第一个and
     -->
    <where>
        <if test="userCustom!=null">
            <if test="userCustom.sex!=null and userCustom.sex!=''">
                and user.sex = #{userCustom.sex}
            </if>
            <if test="userCustom.username!=null and userCustom.username!=''">
                and user.username LIKE '%${userCustom.username}%'
            </if>
        </if>
    </where>     
    </select>
```

#### 7.4 测试代码
```java

    //用户信息的综合 查询
    @Test
    public void testFindUserList() throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //创建UserMapper对象，mybatis自动生成mapper代理对象
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        //创建包装对象，设置查询条件
        UserQueryVo userQueryVo = new UserQueryVo();
        UserCustom userCustom = new UserCustom();
        //由于这里使用动态sql，如果不设置某个值，条件不会拼接在sql中
        userCustom.setSex("1");
        userCustom.setUsername("小明");
        userQueryVo.setUserCustom(userCustom);
        //调用userMapper的方法
        List<UserCustom> list = userMapper.findUserList(userQueryVo);
        System.out.println(list);     
    }
```

#### 7.5 sql片段
##### 7.5.1   需求
```
将上边实现的动态sql判断代码块抽取出来，组成一个sql片段。其它的statement中就可以引用sql片段。方便程序员进行开发
```

##### 7.5.2   定义sql片段
```xml
<!-- 定义sql片段
    id：sql片段的唯 一标识
    经验：是基于单表来定义sql片段，这样话这个sql片段可重用性才高
    在sql片段中不要包括 where
     -->
    <sql id="query_user_where">
        <if test="userCustom!=null">
            <if test="userCustom.sex!=null and userCustom.sex!=''">
                and user.sex = #{userCustom.sex}
            </if>
            <if test="userCustom.username!=null and userCustom.username!=''">
                and user.username LIKE '%${userCustom.username}%'
            </if>
        </if>
    </sql>

```
##### 7.5.3   引用sql片段
```
在mapper.xml中定义的statement中引用sql片段：
```

```xml
    <select id="findUserList" parameterType="cn.itcast.mybatis.po.UserQueryVo" 
            resultType="cn.itcast.mybatis.po.UserCustom">
    SELECT * FROM USER
    <!--   where可以自动去掉条件中的第一个and  -->
    <where>
        <!-- 引用sql片段 的id，如果refid指定的id不在本mapper文件中，需要前边加namespace -->
        <include refid="query_user_where"></include>
        <!-- 在这里还要引用其它的sql片段  -->
    </where>
    </select>
```

#### 7.6 foreach:向sql传递数组或List，mybatis使用foreach解析

##### 7.6.1 需求
```
在用户查询列表和查询总数的statement中增加多个id输入查询。
sql语句如下：
两种方法：
SELECT * FROM USER WHERE id=1 OR id=10 OR id=16
SELECT * FROM USER WHERE id IN(1,10,16)
```

##### 7.6.2 在输入参数类型中添加List<Integer> ids传入多个id
```java
public class UserQueryVo {
    //传入多个id
    private List<Integer> ids;
    public List<Integer> getIds() {
        return ids;
    }
    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }
}
```

##### 7.6.3 修改mapper.xml
```
WHERE id=1 OR id=10 OR id=16
在查询条件中，查询条件定义成一个sql片段，需要修改sql片段。
```

```xml
    <sql id="query_user_where">
        <if test="userCustom!=null">
            <if test="userCustom.sex!=null and userCustom.sex!=''">
                and user.sex = #{userCustom.sex}
            </if>
            <if test="userCustom.username!=null and userCustom.username!=''">
                and user.username LIKE '%${userCustom.username}%'
            </if>
            <if test="ids!=null">
            <!-- 使用 foreach遍历传入ids
            collection：指定输入 对象中集合属性
            item：每个遍历生成对象中
            open：开始遍历时拼接的串
            close：结束遍历时拼接的串
            separator：遍历的两个对象中需要拼接的串
             -->
             <!-- 使用实现下边的sql拼接：AND (id=1 OR id=10 OR id=16) -->
            <foreach collection="ids" item="user_id" open="AND (" close=")" separator="or">
                <!-- 每个遍历需要拼接的串 -->
                id=#{user_id}
            </foreach>
            
            <!-- 实现  “ and id IN(1,10,16)”拼接 -->
            <!-- <foreach collection="ids" item="user_id" open="and id IN(" close=")" separator=",">
                每个遍历需要拼接的串
                #{user_id}
            </foreach> -->
            </if>
        </if>
    </sql>

```


##### 7.6.4 测试代码
```java
    //用户信息的综合 查询
    @Test
    public void testFindUserList() throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //创建UserMapper对象，mybatis自动生成mapper代理对象
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        //创建包装对象，设置查询条件
        UserQueryVo userQueryVo = new UserQueryVo();
        UserCustom userCustom = new UserCustom();
        //由于这里使用动态sql，如果不设置某个值，条件不会拼接在sql中
//      userCustom.setSex("1");
        userCustom.setUsername("小明");
        //传入多个id
        List<Integer> ids = new ArrayList<Integer>();
        ids.add(1);
        ids.add(10);
        ids.add(16);
        //将ids通过userQueryVo传入statement中
        userQueryVo.setIds(ids);
        userQueryVo.setUserCustom(userCustom);
        //调用userMapper的方法
        List<UserCustom> list = userMapper.findUserList(userQueryVo);
        System.out.println(list);    
    }
```
## mybatis进阶
### 1.订单商品数据模型
##### 1.1sql语句
```sql
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '商品名称',
  `price` float(10,1) NOT NULL COMMENT '商品定价',
  `detail` text COMMENT '商品描述',
  `pic` varchar(64) DEFAULT NULL COMMENT '商品图片',
  `createtime` datetime NOT NULL COMMENT '生产日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `orderdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL COMMENT '订单id',
  `items_id` int(11) NOT NULL COMMENT '商品id',
  `items_num` int(11) DEFAULT NULL COMMENT '商品购买数量',
  PRIMARY KEY (`id`),
  KEY `FK_orderdetail_1` (`orders_id`),
  KEY `FK_orderdetail_2` (`items_id`),
  CONSTRAINT `FK_orderdetail_1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_orderdetail_2` FOREIGN KEY (`items_id`) REFERENCES `items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '下单用户id',
  `number` varchar(32) NOT NULL COMMENT '订单号',
  `createtime` datetime NOT NULL COMMENT '创建订单时间',
  `note` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `FK_orders_1` (`user_id`),
  CONSTRAINT `FK_orders_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL COMMENT '用户名称',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

```

##### 1.2 数据模型分析思路
```
1、每张表记录的数据内容
    分模块对每张表记录的内容进行熟悉，相当 于你学习系统 需求（功能）的过程。
2、每张表重要的字段设置
    非空字段、外键字段
3、数据库级别表与表之间的关系
    外键关系
4、表与表之间的业务关系
    在分析表与表之间的业务关系时一定要建立 在某个业务意义基础上去分析。
```

##### 1.3 数据模型分析
```
用户表user：
    记录了购买商品的用户信息

订单表：orders
    记录了用户所创建的订单（购买商品的订单）

订单明细表：orderdetail：
    记录了订单的详细信息即购买商品的信息

商品表：items
    记录了商品信息


表与表之间的业务关系：
    在分析表与表之间的业务关系时需要建立 在某个业务意义基础上去分析。
先分析数据级别之间有关系的表之间的业务关系：
    
usre和orders：
user---->orders：一个用户可以创建多个订单，一对多
orders--->user：一个订单只由一个用户创建，一对一

orders和orderdetail：
orders---》orderdetail：一个订单可以包括 多个订单明细，因为一个订单可以购买多个商品，每个商品的购买信息在orderdetail记录，一对多关系

orderdetail--> orders：一个订单明细只能包括在一个订单中，一对一

orderdetail和itesm：
orderdetail---》itesms：一个订单明细只对应一个商品信息，一对一

items--> orderdetail:一个商品可以包括在多个订单明细 ，一对多

再分析数据库级别没有关系的表之间是否有业务关系：
orders和items：
orders和items之间可以通过orderdetail表建立 关系。

```

### 2.一对一查询
#### 2.1 需求
```
查询订单信息，关联查询创建订单的用户信息
```
#### 2.2 resultType
##### 2.2.1 sql语句
```
确定查询的主表：订单表
确定查询的关联表：用户表
    关联查询使用内链接？还是外链接？
    由于orders表中有一个外键（user_id），通过外键关联查询用户表只能查询出一条记录，可以使用内链接。
```

```sql
SELECT 
  orders.*,
  USER.username,
  USER.sex,
  USER.address 
FROM
  orders,
  USER 
WHERE orders.user_id = user.id
```

##### 2.2.2  创建pojo
```
将上边sql查询的结果映射到pojo中，pojo中必须包括所有查询列名。
原始的Orders.java不能映射全部字段，需要新创建的pojo。
创建 一个pojo继承包括查询字段较多的po类。
```

```java
public class OrdersCustom extends Orders{
    //添加用户属性 USER.username,  USER.sex, USER.address 
    private String username;
    private String sex;
    private String address;
}
```

##### 2.2.3 mapper.xml
```xml
    <!-- 查询订单关联查询用户信息 -->
    <select id="findOrdersUser" resultType="cn.itcast.mybatis.po.OrdersCustom">
        SELECT
        orders.*,
        USER.username,
        USER.sex,
        USER.address
        FROM
        orders,
        USER
        WHERE orders.user_id = user.id
    </select>
```

##### 2.2.4 mapper.java
```java
public List<OrdersCustom> findOrdersUser() throws Exception;
```

#### 2.3 resultMap

##### 2.3.1 sql语句
```
同resultType实现的sql
```

##### 2.3.2 使用resultMap映射的思路
```
使用resultMap将查询结果中的订单信息映射到Orders对象中，在orders类中添加User属性，将关联查询出来的用户信息映射到orders对象中的user属性中。
```

##### 2.3.3 需要Orders类中添加user属性
```java
public class Orders {
    private Integer id;
    private Integer userId;
    private String number;
    private Date createtime;
    private String note;
    //用户信息
    private User user;
}
```

##### 2.3.4 mapper.xml
* 2.3.4.1 定义resultMap
```xml
<!-- 订单查询关联用户的resultMap
    将整个查询的结果映射到cn.itcast.mybatis.po.Orders中
     -->
    <resultMap type="cn.itcast.mybatis.po.Orders" id="OrdersUserResultMap">
        <!-- 配置映射的订单信息 -->
        <!-- id：指定查询列中的唯 一标识，订单信息的中的唯 一标识，如果有多个列组成唯一标识，配置多个id
            column：订单信息的唯 一标识 列
            property：订单信息的唯 一标识 列所映射到Orders中哪个属性
          -->
        <id column="id" property="id"/>
        <result column="user_id" property="userId"/>
        <result column="number" property="number"/>
        <result column="createtime" property="createtime"/>
        <result column="note" property=note/>
        
        <!-- 配置映射的关联的用户信息 -->
        <!-- association：用于映射关联查询单个对象的信息
        property：要将关联查询的用户信息映射到Orders中哪个属性
         -->
        <association property="user"  javaType="cn.itcast.mybatis.po.User">
            <!-- id：关联查询用户的唯 一标识
            column：指定唯 一标识用户信息的列
            javaType：映射到user的哪个属性
             -->
            <id column="user_id" property="id"/>
            <result column="username" property="username"/>
            <result column="sex" property="sex"/>
            <result column="address" property="address"/>
        
        </association>
    </resultMap>
```

* 2.3.4.2 statement定义
```xml
    <!-- 查询订单关联查询用户信息，使用resultmap -->
    <select id="findOrdersUserResultMap" resultMap="OrdersUserResultMap">
        SELECT
        orders.*,
        USER.username,
        USER.sex,
        USER.address
        FROM
        orders,
        USER
        WHERE orders.user_id = user.id
    </select>
```

##### 2.3.5 mapper.java
```java
//查询订单关联查询用户使用resultMap
public List<Orders> findOrdersUserResultMap() throws Exception;
```

#### 2.4 resultType和resultMap实现一对一查询小结
```
实现一对一查询：
resultType：使用resultType实现较为简单，如果pojo中没有包括查询出来的列名，需要增加列名对应的属性，即可完成映射。
如果没有查询结果的特殊要求建议使用resultType。

resultMap：需要单独定义resultMap，实现有点麻烦，如果对查询结果有特殊的要求，使用resultMap可以完成将关联查询映射pojo的属性中。

resultMap可以实现延迟加载，resultType无法实现延迟加载。
```

### 3.一对多查询
#### 3.1 需求
```
查询订单及订单明细的信息。
```
#### 3.2 sql语句
```sql
-- 确定主查询表：订单表
-- 确定关联查询表：订单明细表
-- 在一对一查询基础上添加订单明细表关联即可。
SELECT 
  orders.*,
  USER.username,
  USER.sex,
  USER.address,
  orderdetail.id orderdetail_id,
  orderdetail.items_id,
  orderdetail.items_num,
  orderdetail.orders_id
FROM
  orders,
  USER,
  orderdetail
WHERE orders.user_id = user.id AND orderdetail.orders_id=orders.id
```

#### 3.3 分析
```
使用resultType将上边的 查询结果映射到pojo中，订单信息的就是重复。
要求：
对orders映射不能出现重复记录。

在orders.java类中添加List<orderDetail> orderDetails属性。
最终会将订单信息映射到orders中，订单所对应的订单明细映射到orders中的orderDetails属性中。

映射成的orders记录数为两条（orders信息不重复）
每个orders中的orderDetails属性存储了该 订单所对应的订单明细。
```

#### 3.4 在orders中添加list订单明细属性
```java
public class Orders {
    private Integer id;
    private Integer userId;
    private String number;
    private Date createtime;
    private String note;
    //用户信息
    private User user;  
    //订单明细
    private List<Orderdetail> orderdetails;
}
```

#### 3.5 mapper.xml
```xml
    <!-- 查询订单关联查询用户及订单明细，使用resultmap -->
    <select id="findOrdersAndOrderDetailResultMap" resultMap="OrdersAndOrderDetailResultMap">
        SELECT 
          orders.*,
          USER.username,
          USER.sex,
          USER.address,
          orderdetail.id orderdetail_id,
          orderdetail.items_id,
          orderdetail.items_num,
          orderdetail.orders_id
        FROM
          orders,
          USER,
          orderdetail
        WHERE orders.user_id = user.id AND orderdetail.orders_id=orders.id
    </select>
```

#### 3.6 resultMap定义
```xml
<!-- 订单及订单明细的resultMap
    使用extends继承，不用在中配置订单信息和用户信息的映射
     -->
    <resultMap type="cn.itcast.mybatis.po.Orders" id="OrdersAndOrderDetailResultMap" extends="OrdersUserResultMap">
        <!-- 订单信息 -->
        <!-- 用户信息 -->
        <!-- 使用extends继承，不用在中配置订单信息和用户信息的映射 -->

        <!-- 订单明细信息
        一个订单关联查询出了多条明细，要使用collection进行映射
        collection：对关联查询到多条记录映射到集合对象中
        property：将关联查询到多条记录映射到cn.itcast.mybatis.po.Orders哪个属性
        ofType：指定映射到list集合属性中pojo的类型
         -->
         <collection property="orderdetails" ofType="cn.itcast.mybatis.po.Orderdetail">
            <!-- id：订单明细唯 一标识
            property:要将订单明细的唯 一标识 映射到cn.itcast.mybatis.po.Orderdetail的哪个属性
              -->
            <id column="orderdetail_id" property="id"/>
            <result column="items_id" property="itemsId"/>
            <result column="items_num" property="itemsNum"/>
            <result column="orders_id" property="ordersId"/>
         </collection>
    </resultMap>
```

#### 3.7 mapper.java
```java
// 查询订单(关联用户)及订单明细
public List<Orders> findOrdersAndOrderDetailResultMap() throws Exception;
```

#### 3.8 小结
```
mybatis使用resultMap的collection对关联查询的多条记录映射到一个list集合属性中。

使用resultType实现：
将订单明细映射到orders中的orderdetails中，需要自己处理，使用双重循环遍历，去掉重复记录，将订单明细放在orderdetails中。
```

### 4.多对多查询

#### 4.1 需求
```
查询用户及用户购买商品信息。
```
#### 4.2 sql语句
```sql
-- 查询主表是：用户表
-- 关联表：由于用户和商品没有直接关联，通过订单和订单明细进行关联，所以关联表：
-- orders、orderdetail、items
SELECT 
  orders.*,
  USER.username,
  USER.sex,
  USER.address,
  orderdetail.id orderdetail_id,
  orderdetail.items_id,
  orderdetail.items_num,
  orderdetail.orders_id,
  items.name items_name,
  items.detail items_detail,
  items.price items_price
FROM
  orders,
  USER,
  orderdetail,
  items
WHERE orders.user_id = user.id AND orderdetail.orders_id=orders.id AND orderdetail.items_id = items.id
```

#### 4.3 映射思路
```
将用户信息映射到user中。
在user类中添加订单列表属性List<Orders> orderslist，将用户创建的订单映射到orderslist
在Orders中添加订单明细列表属性List<OrderDetail>orderdetials，将订单的明细映射到orderdetials
在OrderDetail中添加Items属性，将订单明细所对应的商品映射到Items
```

#### 4.4 mapper.xml
```xml
    <!-- 查询用户及购买的商品信息，使用resultmap -->
    <select id="findUserAndItemsResultMap" resultMap="UserAndItemsResultMap">
        SELECT 
          orders.*,
          USER.username,
          USER.sex,
          USER.address,
          orderdetail.id orderdetail_id,
          orderdetail.items_id,
          orderdetail.items_num,
          orderdetail.orders_id,
          items.name items_name,
          items.detail items_detail,
          items.price items_price
        FROM
          orders,
          USER,
          orderdetail,
          items
        WHERE orders.user_id = user.id AND orderdetail.orders_id=orders.id AND orderdetail.items_id = items.id
    </select>
```


#### 4.5 resultMap定义
```xml
<!-- 查询用户及购买的商品 -->
    <resultMap type="cn.itcast.mybatis.po.User" id="UserAndItemsResultMap">
        <!-- 用户信息 -->
        <id column="user_id" property="id"/>
        <result column="username" property="username"/>
        <result column="sex" property="sex"/>
        <result column="address" property="address"/>
        <!-- 订单信息
        一个用户对应多个订单，使用collection映射
         -->
         <collection property="ordersList" ofType="cn.itcast.mybatis.po.Orders">
            <id column="id" property="id"/>
            <result column="user_id" property="userId"/>
            <result column="number" property="number"/>
            <result column="createtime" property="createtime"/>
            <result column="note" property="note"/>         
             <!-- 订单明细
         一个订单包括 多个明细
          -->
            <collection property="orderdetails" ofType="cn.itcast.mybatis.po.Orderdetail">
                    <id column="orderdetail_id" property="id"/>
                    <result column="items_id" property="itemsId"/>
                    <result column="items_num" property="itemsNum"/>
                    <result column="orders_id" property="ordersId"/>
                    
                    <!-- 商品信息
            一个订单明细对应一个商品
             -->
                <association property="items" javaType="cn.itcast.mybatis.po.Items">
                    <id column="items_id" property="id"/>
                    <result column="items_name" property="name"/>
                    <result column="items_detail" property="detail"/>
                    <result column="items_price" property="price"/>
                </association>            
            </collection>      
         </collection>  
    </resultMap>
```

#### 4.6 mapper.java
```java
// 查询用户购买商品信息
public List<User> findUserAndItemsResultMap() throws Exception;
```

#### 4.7 多对多查询总结
```
将查询用户购买的商品信息明细清单，（用户名、用户地址、购买商品名称、购买商品时间、购买商品数量）

针对上边的需求就使用resultType将查询到的记录映射到一个扩展的pojo中，很简单实现明细清单的功能。

一对多是多对多的特例，如下需求：
查询用户购买的商品信息，用户和商品的关系是多对多关系。
需求1：
查询字段：用户账号、用户名称、用户性别、商品名称、商品价格(最常见)
企业开发中常见明细列表，用户购买商品明细列表，
使用resultType将上边查询列映射到pojo输出。

需求2：
查询字段：用户账号、用户名称、购买商品数量、商品明细（鼠标移上显示明细）
使用resultMap将用户购买的商品明细列表映射到user对象中。

总结：

使用resultMap是针对那些对查询结果映射有特殊要求的功能，，比如特殊要求映射成list中包括 多个list。
```

### 5.resultMap总结
```
resultType：
作用：
    将查询结果按照sql列名pojo属性名一致性映射到pojo中。
场合：
    常见一些明细记录的展示，比如用户购买商品明细，将关联查询信息全部展示在页面时，此时可直接使用resultType将每一条记录映射到pojo中，在前端页面遍历list（list中是pojo）即可。

resultMap：
    使用association和collection完成一对一和一对多高级映射（对结果有特殊的映射要求）。

association：
作用：
    将关联查询信息映射到一个pojo对象中。
场合：
    为了方便查询关联信息可以使用association将关联订单信息映射为用户对象的pojo属性中，比如：查询订单及关联用户信息。
    使用resultType无法将查询结果映射到pojo对象的pojo属性中，根据对结果集查询遍历的需要选择使用resultType还是resultMap。
    
collection：
作用：
    将关联查询信息映射到一个list集合中。
场合：
    为了方便查询遍历关联信息可以使用collection将关联信息映射到list集合中，比如：查询用户权限范围模块及模块下的菜单，可使用collection将模块映射到模块list中，将菜单列表映射到模块对象的菜单list属性中，这样的作的目的也是方便对查询结果集进行遍历查询。
    如果使用resultType无法将查询结果映射到list集合中。
```

### 6.延迟加载
#### 6.1 什么是延迟加载
```
resultMap可以实现高级映射（使用association、collection实现一对一及一对多映射），association、collection具备延迟加载功能。
需求：
如果查询订单并且关联查询用户信息。如果先查询订单信息即可满足要求，当我们需要查询用户信息时再查询用户信息。把对用户信息的按需去查询就是延迟加载。

延迟加载：先从单表查询、需要时再从关联表去关联查询，大大提高 数据库性能，因为查询单表要比关联查询多张表速度要快。
```

#### 6.2 使用association实现延迟加载

##### 6.2.1 需求
```
查询订单并且关联查询用户信息
```

##### 6.2.2 mapper.xml
```
需要定义两个mapper的方法对应的statement。
1、只查询订单信息
SELECT * FROM orders
在查询订单的statement中使用association去延迟加载（执行）下边的satatement(关联查询用户信息)
```

```xml
    <!-- 查询订单关联查询用户，用户信息需要延迟加载 -->
    <select id="findOrdersUserLazyLoading" resultMap="OrdersUserLazyLoadingResultMap">
        SELECT * FROM orders
    </select>
```

```
2、关联查询用户信息
    通过上边查询到的订单信息中user_id去关联查询用户信息
    使用UserMapper.xml中的findUserById

```

```xml
    <select id="findUserById" parameterType="int" resultMap="user">
        SELECT * FROM USER WHERE id=#{value}
    </select>
```

```
上边先去执行findOrdersUserLazyLoading，当需要去查询用户的时候再去执行findUserById，通过resultMap的定义将延迟加载执行配置起来。
```


##### 6.2.3 延迟加载resultMap
```xml
<!--使用association中的select指定延迟加载去执行的statement的id。-->
<!-- 延迟加载的resultMap -->
    <resultMap type="cn.itcast.mybatis.po.Orders" id="OrdersUserLazyLoadingResultMap">
            <!--对订单信息进行映射配置  -->
            <id column="id" property="id"/>
            <result column="user_id" property="userId"/>
            <result column="number" property="number"/>
            <result column="createtime" property="createtime"/>
            <result column="note" property="note"/>
            <!-- 实现对用户信息进行延迟加载
            select：指定延迟加载需要执行的statement的id（是根据user_id查询用户信息的statement）
            要使用userMapper.xml中findUserById完成根据用户id(user_id)用户信息的查询，如果findUserById不在本mapper中需要前边加namespace
            column：订单信息中关联用户信息查询的列，是user_id
            关联查询的sql理解为：
            SELECT orders.*,
    (SELECT username FROM USER WHERE orders.user_id = user.id)username,
    (SELECT sex FROM USER WHERE orders.user_id = user.id)sex
     FROM orders
             -->
            <association property="user"  javaType="cn.itcast.mybatis.po.User"
             select="cn.itcast.mybatis.mapper.UserMapper.findUserById" column="user_id">
            <!-- 实现对用户信息进行延迟加载 -->
        
            </association>
            
    </resultMap>
```

##### 6.2.4 mapper.java
```java
//查询订单关联查询用户，用户信息是延迟加载
public List<Orders> findOrdersUserLazyLoading() throws Exception;
```

##### 6.2.5 测试
*  6.2.5.1 测试思路：
```
1、执行上边mapper方法（findOrdersUserLazyLoading），内部去调用cn.itcast.mybatis.mapper.OrdersMapperCustom中的findOrdersUserLazyLoading只查询orders信息（单表）。

2、在程序中去遍历上一步骤查询出的List<Orders>，当我们调用Orders中的getUser方法时，开始进行延迟加载。

3、延迟加载，去调用UserMapper.xml中findUserbyId这个方法获取用户信息。
```

* 6.2.5.2 延迟加载配置
```
mybatis默认没有开启延迟加载，需要在SqlMapConfig.xml中setting配置。
```
* 在SqlMapConfig.xml中配置：
```xml
    <settings>
        <!-- 打开延迟加载 的开关 -->
        <setting name="lazyLoadingEnabled" value="true"/>
        <!-- 将积极加载改为消极加载即按需要加载 -->
        <setting name="aggressiveLazyLoading" value="false"/>
        <!-- 开启二级缓存 -->
        <setting name="cacheEnabled" value="true"/>
    </settings>
```

##### 6.2.6   延迟加载思考
```
不使用mybatis提供的association及collection中的延迟加载功能，如何实现延迟加载？
实现方法如下：
定义两个mapper方法：
1、查询订单列表
2、根据用户id查询用户信息
实现思路：
先去查询第一个mapper方法，获取订单信息列表
在程序中（service），按需去调用第二个mapper方法去查询用户信息。

总之：
使用延迟加载方法，先去查询简单的sql（最好单表，也可以关联查询），再去按需要加载关联查询的其它信息。
```

### 7.查询缓存




















































