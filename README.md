# blog

#### 介绍

基于spring boot+vue的博客项目，项目分为博客前台和博客后台两部分，因为本人对前端不怎么熟练，前台界面比较简洁甚至丑陋，后台功能比较完善，非常适合学习完spring boot和vue，又想自己动手做一个前后端分离项目的同学用来练手。本来是想部署到服务器上面的，但是后台打包完成后在命令行中运行之后用postman测试登录接口报错，在idea中运行之后却能正常登录，一直找不到解决办法，再加上本人快期末考试了，实在没有精力解决这个问题，附上报错图片，希望有知道的小伙伴指点迷津。

![输入图片说明](https://foruda.gitee.com/images/1668508259815989375/078474a1_11425581.jpeg "Cache_-33789b4462dc13ca.jpg")

废话不多说接下来介绍一下项目

### 技术栈

- 前端： vue + vuex + vue-router + axios  + element 
- 后端： SpringBoot +  SpringSecurity + Swagger2 + MyBatisPlus + Mysql + Redis + Oss + Aop + 定时任务

项目使用spring security实现了认证授权登录，oss实现了图片上传存储，定时任务实现了将文章的浏览量每隔一段时间从redis存储到数据库里，aop实现了日志记录，这几个技术栈是我第一次使用到项目中，就单独拿出来说了，感兴趣的同学可以学习一下。

### 后台演示图

- 登录
  ![输入图片说明](https://foruda.gitee.com/images/1668509915616381650/db0cffb2_11425581.jpeg "retouch_2022111518564953.jpg")
- 首页
  ![输入图片说明](https://foruda.gitee.com/images/1668510049342425954/89625492_11425581.png "W66NYTH`W56588J)V(6O}[I.png")
- 写博客
  ![输入图片说明](https://foruda.gitee.com/images/1668510298029255731/dd038da2_11425581.png "屏幕截图")
- 用户管理
  ![输入图片说明](https://foruda.gitee.com/images/1668510233677543169/ce8041d7_11425581.png "V4R)]_`BFRQG5GAKP6Q[JAC.png")
- 角色管理
  ![输入图片说明](https://foruda.gitee.com/images/1668510276515544855/ca9f34f4_11425581.png "屏幕截图")
- 菜单管理
  ![输入图片说明](https://foruda.gitee.com/images/1668510315117614997/85dc0695_11425581.png "屏幕截图")
- 文章管理
  ![输入图片说明](https://foruda.gitee.com/images/1668510326683874882/54aea8f1_11425581.png "屏幕截图")
- 友链管理
  ![输入图片说明](https://foruda.gitee.com/images/1668510340454727698/4be22781_11425581.png "屏幕截图")

### 前台演示图

- 用户界面
  ![输入图片说明](https://foruda.gitee.com/images/1668510815557399553/e25ea272_11425581.png "屏幕截图")
- 文章界面
  ![输入图片说明](https://foruda.gitee.com/images/1668510827133730210/9c06963a_11425581.png "屏幕截图")
- 文章详情
  ![输入图片说明](https://foruda.gitee.com/images/1668510848957073397/932643af_11425581.png "屏幕截图")
- 文章评论
  ![输入图片说明](https://foruda.gitee.com/images/1668510860957556019/6537dee9_11425581.png "屏幕截图")
- 友链界面
  ![输入图片说明](https://foruda.gitee.com/images/1668510868812174070/fc02613b_11425581.png "屏幕截图")

### 准备工作

```
JDK >= 1.8 (推荐1.8版本)
Mysql >= 5.7.0 (推荐5.7版本)
Redis >= 3.0
Maven >= 3.0
Node >= 12
```

### 运行流程

1. 把仓库项目clone下来使用idea打开项目，并加载Maven依赖
2. 创建数据库dzl-blog并依次导入数据脚本
3. 启动 redis 服务 
4. 配置后台模块blog-admin和前台模块blog-front里面application.yml 里的数据库信息
5. 分别启动两个后端项目
6. 启动blog-vue里面的vue-admin,vue-blog两个前端项目
   npm install
   npm run dev
7. 访问 http://localhost:80 默认账户/密码 dzl/12345

### 项目总结

这是我第二次写前后端分离的项目了(第一次写的疫情管理系统，项目地址：[github地址](https://github.com/hugggfu/yiqing.git)，[gitee地址](http://gitee.com/dzlqd/yiqing)，感兴趣的同学可以去看看，也特别适合新人)，对于我这个新手来说，这次最大的收获就是整合了spring security和oss，再加上个定时任务，细节方面实现了一个评论功能。总归来说收获还是挺大的，本来想着部署服务器，结果后面遇到报错的bug(具体报错前面有提到)，算是一个遗憾，到后面要复习期末考试了，再然后就要准备考研了，希望有时间可以把这个bug解决掉成功部署服务器。在这里特别感谢一下我认识的一个朋友，算是我java学习道路上的一个引路人了，一路走来帮了我不少忙，他的项目写的都非常不错，想学习新项目的可以去他的[gitee](https://gitee.com/cxq21
)看看，还要感谢我的大学同学吴佬，真的特别强，教会了我特别多的东西，也帮了我不少忙，再次感谢一下吴佬。最后希望明年考研能考上理想的大学

