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

```
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

```
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
```
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

#### 2.6 更新用户



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



### 3.mybatis开发Dao的方法


#### 3.1 原始dao开发方法:需要写dao接口和dao实现类


#### 3.2 mapper代理方法:只需要mapper接口(相当于dao接口)


### 4.SqlMapConfig.xml


#### 4.1 properties属性


#### 4.2 settings全局参数配置


#### 4.3 typeAliases(别名)


#### 4.4 typeHandlers(类型处理器)


#### 4.5 mappers(映射配置)

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

* mapper.xml
``` 
在UserMapper.xml中定义用户信息综合查询（查询条件复杂，通过高级查询进行复杂关联查询）
```


* mapper.java

* 测试代码



### 6.输出映射:resultType&resultMap
#### 6.1 resultType
```
使用resultType进行输出映射，只有查询出来的列名和pojo中的属性名一致，该列才可以映射成功.
如果查询出来的列名和pojo中的属性名全部不一致，没有创建pojo对象.
只要查询出来的列名和pojo中的属性有一个一致，就会创建pojo对象.
```
##### 输出简单类型

##### 输出pojo对象和pojo列表


#### 6.2 resultMap
```
mybatis中使用resultMap完成高级输出结果映射
```
##### resultMap使用方法
```
如果查询出来的列名和pojo的属性名不一致，通过定义一个resultMap对列名和pojo属性名之间作一个映射关系。
1、定义resultMap
2、使用resultMap作为statement的输出映射类型
```

#### 6.3 小结
```
使用resultType进行输出映射，只有查询出来的列名和pojo中的属性名一致，该列才可以映射成功。
如果查询出来的列名和pojo的属性名不一致，通过定义一个resultMap对列名和pojo属性名之间作一个映射关系。
```




### 7.动态sql




## mybatis进阶

### 1.订单商品数据模型

### 2.一对一查询

### 3.一对多查询

### 4.多对多查询

### 5.resultMap总结

### 6.延迟加载

### 7.查询缓存




















































