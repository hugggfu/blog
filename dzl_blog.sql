/*
 Navicat Premium Data Transfer

 Source Server         : dzl
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:3306
 Source Schema         : dzl_blog

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 16/11/2022 03:00:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_article
-- ----------------------------
DROP TABLE IF EXISTS `sys_article`;
CREATE TABLE `sys_article`  (
  `id` bigint(200) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容',
  `summary` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章摘要',
  `category_id` bigint(20) NULL DEFAULT NULL COMMENT '所属分类id',
  `thumbnail` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `is_top` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否置顶（0否，1是）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '状态（0已发布，1草稿）',
  `view_count` bigint(200) NULL DEFAULT 1 COMMENT '访问量',
  `is_comment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否允许评论 1是，0否',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_article
-- ----------------------------
INSERT INTO `sys_article` VALUES (1, 'SpringSecurity从入门到精通', '## 课程介绍\n![image20211219121555979.png](https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/31/e7131718e9e64faeaf3fe16404186eb4.png)\n\n## 0. 简介1\n\n​	**Spring Security** 是 Spring 家族中的一个安全管理框架。相比与另外一个安全框架**Shiro**，它提供了更丰富的功能，社区资源也比Shiro丰富。\n\n​	一般来说中大型的项目都是使用**SpringSecurity** 来做安全框架。小项目有Shiro的比较多，因为相比与SpringSecurity，Shiro的上手更加的简单。\n\n​	 一般Web应用的需要进行**认证**和**授权**。\n\n​		**认证：验证当前访问系统的是不是本系统的用户，并且要确认具体是哪个用户**\n\n​		**授权：经过认证后判断当前用户是否有权限进行某个操作**\n\n​	而认证和授权也是SpringSecurity作为安全框架的核心功能。\n\n\n\n## 1. 快速入门\n\n### 1.1 准备工作\n\n​	我们先要搭建一个简单的SpringBoot工程\n\n① 设置父工程 添加依赖\n\n~~~~\n    <parent>\n        <groupId>org.springframework.boot</groupId>\n        <artifactId>spring-boot-starter-parent</artifactId>\n        <version>2.5.0</version>\n    </parent>\n    <dependencies>\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-web</artifactId>\n        </dependency>\n        <dependency>\n            <groupId>org.projectlombok</groupId>\n            <artifactId>lombok</artifactId>\n            <optional>true</optional>\n        </dependency>\n    </dependencies>\n~~~~\n\n② 创建启动类\n\n~~~~\n@SpringBootApplication\npublic class SecurityApplication {\n\n    public static void main(String[] args) {\n        SpringApplication.run(SecurityApplication.class,args);\n    }\n}\n\n~~~~\n\n③ 创建Controller\n\n~~~~java\n\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RestController;\n\n@RestController\npublic class HelloController {\n\n    @RequestMapping(\"/hello\")\n    public String hello(){\n        return \"hello\";\n    }\n}\n\n~~~~\n\n\n\n### 1.2 引入SpringSecurity\n\n​	在SpringBoot项目中使用SpringSecurity我们只需要引入依赖即可实现入门案例。\n\n~~~~xml\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-security</artifactId>\n        </dependency>\n~~~~\n\n​	引入依赖后我们在尝试去访问之前的接口就会自动跳转到一个SpringSecurity的默认登陆页面，默认用户名是user,密码会输出在控制台。\n\n​	必须登陆之后才能对接口进行访问。\n\n\n\n## 2. 认证\n\n### 2.1 登陆校验流程\n![image20211215094003288.png](https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/31/414a87eeed344828b5b00ffa80178958.png)', 'SpringSecurity框架教程-Spring Security+JWT实现项目级前端分离认证授权', 2, 'https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/31/948597e164614902ab1662ba8452e106.png', '1', '0', 148, '0', NULL, '2022-11-16 02:22:55', NULL, NULL, 0);
INSERT INTO `sys_article` VALUES (2, 'weq', 'adadaeqe', 'adad', 2, 'https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/15/fd2e9460c58a4af3bbeae5d9ed581688.png', '1', '0', 22, '0', NULL, '2022-01-21 14:58:30', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (3, 'dad', 'asdasda', 'sadad', 1, 'https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/15/737a0ed0b8ea430d8700a12e76aa1cd1.png', '1', '0', 33, '0', NULL, '2022-01-18 14:58:34', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (5, 'sdad', '![Snipaste_20220115_165812.png](https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/15/1d9d283f5d874b468078b183e4b98b71.png)\r\n\r\n## sda \r\n\r\n222\r\n### sdasd newnewnew', '143', 2, 'http://localhost:8888/file/55050d8464ef4d7d97e5609860894c2a.png', '1', '0', 44, '0', NULL, '2022-10-22 21:24:34', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (8, '13', '131313![无标题.png](www)', '123', 1, 'www', '1', '0', 0, '0', 1, '2022-10-07 12:17:33', NULL, '2022-10-07 12:18:51', 1);
INSERT INTO `sys_article` VALUES (9, '123', '131**313133![无标题.png](http://localhost:8888/file/55050d8464ef4d7d97e5609860894c2a.png)**', '123', 1, 'http://localhost:8888/file/55050d8464ef4d7d97e5609860894c2a.png', '1', '0', 0, '0', NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (10, '1313', '131313131qwrqrqr![无标题.png](http://localhost:8888/file/55050d8464ef4d7d97e5609860894c2a.png)', '131313', 5, 'http://localhost:8888/file/9ef4e13833ec4436a86bd9006aca2725.jpeg', '1', '0', 0, '0', NULL, '2022-10-22 21:24:36', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (11, '4141', '', '414144', 1, '', '1', '0', 0, '0', NULL, '2022-10-22 21:24:37', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (12, '41414', '522525252', '1414', 5, 'http://localhost:8888/file/b51759d7738a42a78ed8f5508a15dd0e.jpg', '1', '1', 0, '0', NULL, '2022-10-22 21:24:40', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (14, '1341', '1424', '134', 5, '', '1', '0', 0, '0', NULL, '2022-10-22 21:24:41', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (15, '122', '13', '123', NULL, NULL, '0', '1', 12, '1', NULL, '2022-11-13 02:14:56', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (16, '我的第一篇博客', '这是我的第一篇文章，我很开心![无标题.png](http://localhost:8888/file/55050d8464ef4d7d97e5609860894c2a.png)', '你好', 1, 'http://localhost:8888/file/a751415ce1f649acb951fb3e6f45cb48.jpg', '0', '0', 23, '0', NULL, '2022-11-13 02:14:58', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (17, '我的第一篇博客', '你好，这是我的第一篇博客，我很开心，虽然有很多bug![无标题.png](http://localhost:8888/file/55050d8464ef4d7d97e5609860894c2a.png)', '你好', 1, 'http://localhost:8888/file/a751415ce1f649acb951fb3e6f45cb48.jpg', '1', '0', 12, '0', NULL, '2022-11-13 02:14:53', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (18, '我的第一篇博客', '**这是我的第一篇博客，我很开心，虽然到目前为止有很多bug**\n![wallhavenj5dpd5.png](https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/e487f376f5494eff82ddd2c83c431966wallhaven-j5dpd5.png)', '第一', 1, 'https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/8f8dbf4bbdd84a7d9cfe5cd5b47d7b39wallhaven-j5dpd5.png', '1', '0', 9, '0', NULL, '2022-11-15 19:12:05', NULL, NULL, 0);
INSERT INTO `sys_article` VALUES (19, '乱七八糟', '# 一塌糊涂\n## 不知所措![无标题.png](http://localhost:8888/file/55050d8464ef4d7d97e5609860894c2a.png)', '无', 6, 'http://localhost:8888/file/a751415ce1f649acb951fb3e6f45cb48.jpg', '0', '0', 13, '0', NULL, '2022-11-13 02:14:49', NULL, NULL, 1);
INSERT INTO `sys_article` VALUES (20, '乱七八糟', '# 一塌糊涂![无标题.png](https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/dc339f8e6ced47fcadc92524e8821be3无标题.png)', '无', 7, 'http://localhost:8888/file/a751415ce1f649acb951fb3e6f45cb48.jpg', '1', '0', 6, '0', NULL, '2022-11-14 23:09:25', NULL, NULL, 0);
INSERT INTO `sys_article` VALUES (21, '1', '1![wallhaven4lzljp.jpg](http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg)', '1', 7, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', '1', '0', 12, '0', NULL, '2022-11-13 02:15:06', NULL, NULL, 0);
INSERT INTO `sys_article` VALUES (22, '测试OSS', '![1667044329483.jpg](https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/6db27c080a7c4edab43cfaf9aa168e6c1667044329483.jpg))', '测试', 7, 'https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/7d63dc257a144c43b5707bdd0c82459c1832021607.jpeg.jpeg', '0', '0', 6, '0', NULL, '2022-11-14 17:51:05', NULL, NULL, 0);
INSERT INTO `sys_article` VALUES (23, '123', '123', '123', 5, '', '1', '0', 1, '0', NULL, '2022-11-16 01:32:31', NULL, NULL, 0);

-- ----------------------------
-- Table structure for sys_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `sys_article_tag`;
CREATE TABLE `sys_article_tag`  (
  `article_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `tag_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '标签id',
  PRIMARY KEY (`article_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章标签关联表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_article_tag
-- ----------------------------
INSERT INTO `sys_article_tag` VALUES (1, 4);
INSERT INTO `sys_article_tag` VALUES (2, 1);
INSERT INTO `sys_article_tag` VALUES (2, 4);
INSERT INTO `sys_article_tag` VALUES (3, 4);
INSERT INTO `sys_article_tag` VALUES (3, 5);
INSERT INTO `sys_article_tag` VALUES (5, 4);
INSERT INTO `sys_article_tag` VALUES (8, 1);
INSERT INTO `sys_article_tag` VALUES (11, 7);
INSERT INTO `sys_article_tag` VALUES (12, 4);
INSERT INTO `sys_article_tag` VALUES (14, 4);
INSERT INTO `sys_article_tag` VALUES (14, 7);
INSERT INTO `sys_article_tag` VALUES (16, 7);
INSERT INTO `sys_article_tag` VALUES (17, 7);
INSERT INTO `sys_article_tag` VALUES (18, 7);
INSERT INTO `sys_article_tag` VALUES (19, 7);
INSERT INTO `sys_article_tag` VALUES (20, 9);
INSERT INTO `sys_article_tag` VALUES (21, 9);
INSERT INTO `sys_article_tag` VALUES (22, 9);
INSERT INTO `sys_article_tag` VALUES (23, 4);

-- ----------------------------
-- Table structure for sys_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_category`;
CREATE TABLE `sys_category`  (
  `id` bigint(200) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  `pid` bigint(200) NULL DEFAULT -1 COMMENT '父分类id，如果没有父分类为-1',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态0:正常,1禁用',
  `create_by` bigint(200) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint(200) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_category
-- ----------------------------
INSERT INTO `sys_category` VALUES (1, 'java', -1, 'wsd', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_category` VALUES (2, 'PHP', -1, 'wsd', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_category` VALUES (3, '123', -1, '123', '0', NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_category` VALUES (4, '123', -1, '124', '0', NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_category` VALUES (5, 'python', -1, '123', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_category` VALUES (6, '乱七八糟', -1, '无', '0', NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_category` VALUES (7, '乱七八糟', -1, '无', '0', NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for sys_comment
-- ----------------------------
DROP TABLE IF EXISTS `sys_comment`;
CREATE TABLE `sys_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '评论人',
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时间',
  `pid` bigint(20) NULL DEFAULT -1 COMMENT '父id',
  `origin_id` bigint(20) NULL DEFAULT -1 COMMENT '最上级评论id',
  `article_id` bigint(20) NULL DEFAULT NULL COMMENT '关联文章的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_comment
-- ----------------------------
INSERT INTO `sys_comment` VALUES (7, '点赞', 1, '2022-10-25 21:17:58', -1, -1, 1);
INSERT INTO `sys_comment` VALUES (14, '111', 1, '2022-10-25 22:39:35', 7, 7, 1);
INSERT INTO `sys_comment` VALUES (15, '123', 1, '2022-10-25 22:54:23', 1, 1, 1);
INSERT INTO `sys_comment` VALUES (38, 'me安抚', 1, NULL, 7, 7, 1);
INSERT INTO `sys_comment` VALUES (45, '3发顺丰', 1, NULL, 7, 7, 1);
INSERT INTO `sys_comment` VALUES (53, '你也好', 1, '2022-10-26 23:00:05', 52, 52, 1);
INSERT INTO `sys_comment` VALUES (54, '啦啦啦', 1, '2022-10-26 23:10:33', -1, -1, 1);
INSERT INTO `sys_comment` VALUES (55, '你哈匹马', 1, '2022-10-26 23:10:42', 54, 54, 1);
INSERT INTO `sys_comment` VALUES (56, '1231442', 1, '2022-10-26 23:11:42', 55, 54, 1);
INSERT INTO `sys_comment` VALUES (57, '1231414', 1, '2022-10-26 23:11:56', 53, 52, 1);
INSERT INTO `sys_comment` VALUES (58, 'bug', 1, '2022-10-26 23:13:20', -1, -1, 1);
INSERT INTO `sys_comment` VALUES (64, '123', 1, '2022-10-26 23:18:02', 58, 58, 1);
INSERT INTO `sys_comment` VALUES (65, '123', 1, '2022-10-26 23:18:02', 58, 58, 1);
INSERT INTO `sys_comment` VALUES (66, '啦啦啦', 1, '2022-10-26 23:18:23', -1, -1, 1);
INSERT INTO `sys_comment` VALUES (67, '吐了呀', 2, '2022-10-26 23:19:21', 66, 66, 1);
INSERT INTO `sys_comment` VALUES (68, '我在写bug', 2, '2022-10-26 23:19:44', 67, 66, 1);
INSERT INTO `sys_comment` VALUES (69, '好像还是有bug', 2, '2022-10-26 23:20:19', 65, 58, 1);
INSERT INTO `sys_comment` VALUES (70, 'lalal', 2, '2022-10-26 23:25:13', 66, 66, 1);
INSERT INTO `sys_comment` VALUES (71, '在测试一波', 2, '2022-10-26 23:47:50', -1, -1, 1);
INSERT INTO `sys_comment` VALUES (72, 'bug成功解决', 1, '2022-10-26 23:48:28', 71, 71, 1);
INSERT INTO `sys_comment` VALUES (73, '是吗', 1, '2022-10-26 23:48:40', 72, 71, 1);
INSERT INTO `sys_comment` VALUES (74, '吐了呀', 1, '2022-10-26 23:48:56', 71, 71, 1);
INSERT INTO `sys_comment` VALUES (75, '你好\n', 2, '2022-10-27 00:17:02', 55, 54, 1);
INSERT INTO `sys_comment` VALUES (76, '好多bug', 2, '2022-10-27 00:18:42', -1, -1, 18);
INSERT INTO `sys_comment` VALUES (77, '是的', 1, '2022-10-27 00:19:40', 76, 76, 18);
INSERT INTO `sys_comment` VALUES (78, '还行', 1, '2022-10-27 00:19:52', -1, -1, 18);
INSERT INTO `sys_comment` VALUES (79, 'nihao', 8, '2022-10-27 20:58:00', -1, -1, 20);
INSERT INTO `sys_comment` VALUES (81, '一般', 13, '2022-11-11 16:57:03', -1, -1, 18);
INSERT INTO `sys_comment` VALUES (82, '我来了\n', 1, '2022-11-14 11:42:04', -1, -1, 1);
INSERT INTO `sys_comment` VALUES (83, '测试一下评论', 1, '2022-11-14 11:56:56', -1, -1, 22);
INSERT INTO `sys_comment` VALUES (84, '123', 8, '2022-11-16 02:23:01', -1, -1, 1);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('user', 'el-icon-user', 'icon');
INSERT INTO `sys_dict` VALUES ('house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` VALUES ('menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` VALUES ('role', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES ('grid', 'el-icon-s-grid', 'icon');
INSERT INTO `sys_dict` VALUES ('email', 'el-icon-message', 'icon');
INSERT INTO `sys_dict` VALUES ('edit', 'el-icon-edit', 'icon');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小(kb)',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件md5',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用链接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (138, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (139, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (140, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (141, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (142, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (143, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (144, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (145, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (146, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (147, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (148, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (149, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (150, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (151, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (152, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (153, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (154, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (155, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (156, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (157, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (158, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (159, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (160, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (161, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (162, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (163, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (164, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (165, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (166, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (167, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (168, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (169, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (170, 'qq_pic_merged_1666626055547.jpg.jpg', 'jpg', 58, 'http://localhost:8888/file/2f56a48e91e44967b09913404c45a448.jpg', '7775c63cd9bf29aa9c3f97fcdcc7e33c', 0, 1);
INSERT INTO `sys_file` VALUES (171, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (172, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (173, '1651725211971.jpeg', 'jpeg', 492, 'http://localhost:8888/file/ec94f6b5870a44de84011123de7b32ee.jpeg', '1e9c0b0897a6ebf70f7718598a5b8442', 0, 1);
INSERT INTO `sys_file` VALUES (174, 'IMG_20221005_135257.jpg', 'jpg', 5207, 'http://localhost:8888/file/babe66e3803047d18d67838bc8f3fb11.jpg', '55465424cca2db9bf017cdded1288621', 0, 1);
INSERT INTO `sys_file` VALUES (175, '-10d1562764e16506.jpg', 'jpg', 377, 'http://localhost/8888/file/2dbf65fc2b8f46f0915c5d9a3a724030.jpg', '732bfc4b17facc4c482b58579042aceb', 0, 1);
INSERT INTO `sys_file` VALUES (176, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (177, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (178, '无标题 - 副本.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (179, 'wallhaven-j5dpd5.png', 'png', 3677, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', 'fe93dbc430eb4cc8d98c6c5bf17dd45f', 0, 1);
INSERT INTO `sys_file` VALUES (180, 'wallhaven-j5dpd5.png', 'png', 3677, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', 'fe93dbc430eb4cc8d98c6c5bf17dd45f', 0, 1);
INSERT INTO `sys_file` VALUES (181, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (182, 'wallhaven-j5dpd5.png', 'png', 3677, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', 'fe93dbc430eb4cc8d98c6c5bf17dd45f', 0, 1);
INSERT INTO `sys_file` VALUES (183, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (184, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (185, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (186, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (187, 'wallhaven-4lzljp.jpg', 'jpg', 520, 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', 'fec000405e55a7df6a9e67793749457a', 0, 1);
INSERT INTO `sys_file` VALUES (188, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (189, 'wallhaven-j5dpd5.png', 'png', 3677, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', 'fe93dbc430eb4cc8d98c6c5bf17dd45f', 0, 1);
INSERT INTO `sys_file` VALUES (190, 'wallhaven-4ydmwx.jpg', 'jpg', 830, 'http://localhost/8888/file/d7ba8e20bd9a40b4bc0cb0e5fe7b7211.jpg', '0a947e6ccc6d7c0eed0b6d5038b7036a', 0, 1);
INSERT INTO `sys_file` VALUES (191, 'wallhaven-j5dpd5.png', 'png', 3677, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', 'fe93dbc430eb4cc8d98c6c5bf17dd45f', 0, 1);
INSERT INTO `sys_file` VALUES (192, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (193, 'wallhaven-j5dpd5.png', 'png', 3677, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', 'fe93dbc430eb4cc8d98c6c5bf17dd45f', 0, 1);
INSERT INTO `sys_file` VALUES (194, 'IMG_20221005_135257.jpg', 'jpg', 5207, 'http://localhost:8888/file/babe66e3803047d18d67838bc8f3fb11.jpg', '55465424cca2db9bf017cdded1288621', 0, 1);
INSERT INTO `sys_file` VALUES (195, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (196, '1667044329483.jpg', 'jpg', 199, 'http://localhost:8888/file/803e2d858e454d4191f1e7a5fd641afa.jpg', '17b86d5c3c6dfd5988a6fc89590b6edb', 0, 1);
INSERT INTO `sys_file` VALUES (197, '无标题 - 副本.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (198, '无标题.png', 'png', 104, 'http://localhost/8888/file/3f1c8ad2131047d58877f48506005406.png', '83eda878a2ad2f29b55d66bfdd578cb1', 0, 1);
INSERT INTO `sys_file` VALUES (199, '2052303293.jpeg', 'jpeg', 21, 'http://localhost:8888/file/308b3449257341e882134322750a1de9.jpeg', '90ab02a221197095b0556d571a8cbc62', 0, 1);
INSERT INTO `sys_file` VALUES (200, '1601375898.jpeg', 'jpeg', 98, 'http://localhost:8888/file/a2cc77151c104ab291b08dc100d2aacb.jpeg', '7797e07712587fd81b7908bf59bf5350', 0, 1);
INSERT INTO `sys_file` VALUES (201, 'wallhaven-j5dpd5.png', 'png', 3677, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', 'fe93dbc430eb4cc8d98c6c5bf17dd45f', 0, 1);

-- ----------------------------
-- Table structure for sys_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_link`;
CREATE TABLE `sys_link`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blogAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `blogName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pictureAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_link
-- ----------------------------
INSERT INTO `sys_link` VALUES (20, 'www.baidu.com', '百度', NULL, '2022-11-14 15:17:00');
INSERT INTO `sys_link` VALUES (22, 'www.csdn.net', 'csdn', NULL, '2022-11-14 16:05:39');
INSERT INTO `sys_link` VALUES (21, 'www.taobao.com ', '淘宝', 'https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/fcea3bdd88704210a3778dd57682d037无标题.png', '2022-11-14 16:02:58');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'sys:list' COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, '', 'System', '0', 'sys:manage', 'el-icon-s-grid', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (2, '用户管理', 1, 0, '/user', 'User', '0', 'sys:user:list', 'el-icon-user', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (3, '角色管理', 1, 0, '/role', 'Role', '0', 'sys:role:list', 'el-icon-s-custom', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (18, '写博客', 0, 0, '/write', 'write', '0', 'sys:write', '#', NULL, NULL, NULL, NULL, '', '1');
INSERT INTO `sys_menu` VALUES (21, '主页', 0, 0, '/home', 'Home', '0', 'sys:home', 'el-icon-house', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (22, '内容管理', 0, 1, '', 'Content', '0', 'sys:content', 'el-icon-edit', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (24, '菜单管理', 1, 3, '/menu', 'Menu', '0', 'sys:menu:list', 'el-icon-menu', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (25, 'xxx', 0, 6, '/xxx', 'XXX', '0', '', 'el-icon-message', NULL, NULL, NULL, NULL, '', '1');
INSERT INTO `sys_menu` VALUES (26, 'SSS', 25, 0, '/sss', 'SSS', '0', '', 'el-icon-s-custom', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (27, '文章管理', 22, 0, '/article', 'Article', '0', 'sys:content', 'el-icon-edit', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (28, '标签管理', 22, 1, '/tag', 'Tag', '0', 'sys:tag:list', 'el-icon-message', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (29, '分类管理', 22, 0, '/category', 'Category', '0', 'sys:category:list', 'el-icon-message', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (30, '友链管理', 22, 4, '/link', 'Link', '0', 'sys:link:list', 'el-icon-edit', NULL, NULL, NULL, NULL, '', '1');
INSERT INTO `sys_menu` VALUES (32, '写博文', 0, 0, '/write', 'Write', '0', 'sys:write', 'el-icon-edit', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (37, '添加用户', 2, 0, NULL, NULL, '0', 'sys:user:save', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (39, '删除用户', 2, 0, NULL, NULL, '0', 'sys:user:delete', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (40, '编辑用户', 2, 0, NULL, NULL, '0', 'sys:user:edit', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (41, '添加角色', 3, 0, NULL, NULL, '0', 'sys:role:save', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (42, '删除角色', 3, 0, NULL, NULL, '0', 'sys:role:delete', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (43, '编辑角色', 3, 0, NULL, NULL, '0', 'sys:role:edit', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (44, '添加菜单', 24, 0, NULL, NULL, '0', 'sys:menu:save', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (45, '删除菜单', 24, 0, NULL, NULL, '0', 'sys:menu:delete', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (46, '编辑菜单', 24, 0, NULL, NULL, '0', 'sys:menu:edit', '#', NULL, NULL, NULL, NULL, '', '0');
INSERT INTO `sys_menu` VALUES (47, '友链管理', 22, 3, '/link', 'Link', '0', 'sys:link:list', 'el-icon-edit', NULL, NULL, NULL, NULL, '', '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NULL DEFAULT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '0', '0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '0', '0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (3, '测试', 'test', 3, '0', '1', NULL, '2022-09-24 11:17:08', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (4, '121', '132', 0, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (5, '111', '111', 2, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (6, '测试', 'test', 4, '0', '0', NULL, '2022-09-24 11:27:12', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (7, '11', '11', 4, '0', '1', NULL, '2022-09-24 11:30:33', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (8, '13', '313', 5, NULL, '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (9, '123', '1234', 0, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (10, '1234', '123', 0, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (11, '132412', '1241', 0, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (12, '131', '123', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (13, '123', '123', 1, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (14, '1', '1', 1, '0', '1', NULL, '2022-10-24 16:57:21', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES (15, '211', '31313', 1313, NULL, '1', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 0);
INSERT INTO `sys_role_menu` VALUES (1, 1);
INSERT INTO `sys_role_menu` VALUES (1, 2);
INSERT INTO `sys_role_menu` VALUES (1, 3);
INSERT INTO `sys_role_menu` VALUES (1, 21);
INSERT INTO `sys_role_menu` VALUES (1, 22);
INSERT INTO `sys_role_menu` VALUES (1, 24);
INSERT INTO `sys_role_menu` VALUES (1, 27);
INSERT INTO `sys_role_menu` VALUES (1, 28);
INSERT INTO `sys_role_menu` VALUES (1, 29);
INSERT INTO `sys_role_menu` VALUES (1, 32);
INSERT INTO `sys_role_menu` VALUES (1, 37);
INSERT INTO `sys_role_menu` VALUES (1, 39);
INSERT INTO `sys_role_menu` VALUES (1, 40);
INSERT INTO `sys_role_menu` VALUES (1, 41);
INSERT INTO `sys_role_menu` VALUES (1, 42);
INSERT INTO `sys_role_menu` VALUES (1, 43);
INSERT INTO `sys_role_menu` VALUES (1, 44);
INSERT INTO `sys_role_menu` VALUES (1, 45);
INSERT INTO `sys_role_menu` VALUES (1, 46);
INSERT INTO `sys_role_menu` VALUES (1, 47);
INSERT INTO `sys_role_menu` VALUES (2, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 21);
INSERT INTO `sys_role_menu` VALUES (2, 24);
INSERT INTO `sys_role_menu` VALUES (6, 0);
INSERT INTO `sys_role_menu` VALUES (6, 1);
INSERT INTO `sys_role_menu` VALUES (6, 2);
INSERT INTO `sys_role_menu` VALUES (6, 3);
INSERT INTO `sys_role_menu` VALUES (6, 21);
INSERT INTO `sys_role_menu` VALUES (6, 32);
INSERT INTO `sys_role_menu` VALUES (7, 1);
INSERT INTO `sys_role_menu` VALUES (7, 2);
INSERT INTO `sys_role_menu` VALUES (7, 3);
INSERT INTO `sys_role_menu` VALUES (7, 21);
INSERT INTO `sys_role_menu` VALUES (10, 1);
INSERT INTO `sys_role_menu` VALUES (10, 2);
INSERT INTO `sys_role_menu` VALUES (10, 3);
INSERT INTO `sys_role_menu` VALUES (10, 21);
INSERT INTO `sys_role_menu` VALUES (10, 22);
INSERT INTO `sys_role_menu` VALUES (14, 22);
INSERT INTO `sys_role_menu` VALUES (14, 27);

-- ----------------------------
-- Table structure for sys_tag
-- ----------------------------
DROP TABLE IF EXISTS `sys_tag`;
CREATE TABLE `sys_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签名',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_tag
-- ----------------------------
INSERT INTO `sys_tag` VALUES (1, 'Mybatis', NULL, NULL, NULL, '2022-01-11 09:20:50', 0, 'weqwe');
INSERT INTO `sys_tag` VALUES (2, 'asdas', NULL, '2022-01-11 09:20:55', NULL, '2022-01-11 09:20:55', 1, 'weqw');
INSERT INTO `sys_tag` VALUES (3, 'weqw', NULL, '2022-01-11 09:21:07', NULL, '2022-01-11 09:21:07', 1, 'qweqwe');
INSERT INTO `sys_tag` VALUES (4, 'Java', NULL, '2022-01-13 15:22:43', NULL, '2022-01-13 15:22:43', 0, 'sdad');
INSERT INTO `sys_tag` VALUES (5, 'WAD', NULL, '2022-01-13 15:22:47', NULL, '2022-01-13 15:22:47', 1, 'ASDAD');
INSERT INTO `sys_tag` VALUES (6, '123', NULL, NULL, NULL, NULL, 1, '1234');
INSERT INTO `sys_tag` VALUES (7, '1234', NULL, NULL, NULL, NULL, 1, '1234');
INSERT INTO `sys_tag` VALUES (8, 'HTML', NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_tag` VALUES (9, '随随便便', NULL, NULL, NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NULL' COMMENT '用户名',
  `nick_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NULL' COMMENT '昵称',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NULL' COMMENT '密码',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户类型：0代表普通用户，1代表管理员',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phonenumber` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户性别（0男，1女，2未知）',
  `avatar` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人的用户id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'dzl', '超级管理员', '$2a$10$90NbROjzFMByM23e.2X85es5nSXejMokDo66JtC/yLBJBiZQimM1S', '0', '0', '2354315459@qq.com', '18709405205', '0', 'https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/6cc3774242d74c9382a28a4c46a682dbwallhaven-4ydmwx.jpg', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (2, '123', '1232', '$2a$10$55zpn9NVMnMh8MBNLB.SN.C2pFqgzOKMe9TAsKVTloZ0fTd8kfquW', '0', '0', '123', NULL, NULL, 'http://localhost:8888/file/308b3449257341e882134322750a1de9.jpeg', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (3, '1314', '441', '$2a$10$Qe6R3Xqt75/dHT5ty1g73eQPHJZ5IFTzvwODID286H5Rs1GQv/1tO', '0', '1', '441', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (4, '134', '114', '$2a$10$E3f9jKZZfN/j7tMdIffe..uysW5JKWz0DftwcXSIqqAelOMp./xU.', '0', '0', '1441', NULL, NULL, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', NULL, '2022-10-25 04:13:34', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (5, 'qd', '123', '$2a$10$0MJ0RveoDTk6FpOZYRgpBurAj1l5.5.ZoFVzTA4tvedXGokp3J75a', '0', '0', '12345', NULL, NULL, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', NULL, '2022-10-25 04:46:33', NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (6, 'hsy', 'test', '$2a$10$uwKIj0pEGa38GbyH5zHOJOAjm9lkByAMNe9L3tQOPlfQ787glw/.a', '0', '0', 'luthl2wj@163.com', NULL, NULL, 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (7, 'lzk', 'we', '$2a$10$/QeGp.o4jL9.M2WH4oT7iuzycGliO2VHqeEiL6Cz80hmkGBUH7JLu', '0', '0', '2354315459@qq.com', '18709405205', '0', 'http://localhost:8888/file/56532990207f441e8d3dee72b130e042.jpg', NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (8, 'qdd', '123de ', '$2a$10$iTm8kgZE4ESfQQUsPqdj3OAy13iwuxQa1v4hUed2Q2eeUQ217eA9C', '0', '0', '23254315459@qq.com', '123', NULL, 'https://dzl-blog.oss-cn-beijing.aliyuncs.com/2022/11/14/8375f25ca4b6446382bf38ce82ee6c021832021607.jpeg.jpeg', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (9, 'fqwf', 'faa', '$2a$10$qdP6r7WeYPC82pnrDOmoFeMoi0tM6dxx/mYa5FeuNZGFkB.cO3M0O', '0', '0', 'luthlawj@163.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (10, 'dee', 'qewr', '$2a$10$VGr43UGgKlclDD2yUCsjJuWH9hRo6xE7fLj2CXhX5PRAgBHXz8CJG', '0', '0', '23542315459@qq.com', NULL, NULL, NULL, NULL, '2022-10-29 07:38:44', NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (11, 'dee', 'qewr', '$2a$10$FoNC6erle5HVjH4PFI5guebnXpSHxN/Vs66dubVPvIdCZLItr8Hgm', '0', '0', '23542315459@qq.com', NULL, NULL, NULL, NULL, '2022-10-29 07:38:44', NULL, NULL, 1);
INSERT INTO `sys_user` VALUES (12, 'xxx', 'dad', '$2a$10$NblkA4Jdf4.cPcaAx0jpQOGVpcAbh9GrZWDOJCkHVvM8yCHk1hmj2', '0', '0', '23524315459@qq.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (13, 'qww', 'qw', '$2a$10$E/XPQgTN6vIfOeT7Q0i/ROZJ6IyRDuTmYHuVdA5rYRNBpr6/TxNni', '0', '0', '2354315459@qq.com', '18709405205', '0', 'http://localhost:8888/file/224f581a0c104645b523f545ae2f5c17.png', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (14, '13', '123', '$2a$10$2eFZFW/QPmNmDlCZfxJsVumzFxmLqWO7OwJDYaQJZQiA1UDyBHGF2', '0', '0', '213', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(255) NOT NULL COMMENT '用户ID',
  `role_id` bigint(255) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (1, 2);
INSERT INTO `sys_user_role` VALUES (2, 6);
INSERT INTO `sys_user_role` VALUES (3, 1);
INSERT INTO `sys_user_role` VALUES (4, 2);
INSERT INTO `sys_user_role` VALUES (5, 14);
INSERT INTO `sys_user_role` VALUES (7, 2);
INSERT INTO `sys_user_role` VALUES (8, 6);
INSERT INTO `sys_user_role` VALUES (9, 14);
INSERT INTO `sys_user_role` VALUES (10, 6);
INSERT INTO `sys_user_role` VALUES (11, 6);
INSERT INTO `sys_user_role` VALUES (12, 6);
INSERT INTO `sys_user_role` VALUES (13, 2);
INSERT INTO `sys_user_role` VALUES (14, 6);

SET FOREIGN_KEY_CHECKS = 1;
