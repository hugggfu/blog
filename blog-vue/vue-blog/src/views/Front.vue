<template>
  <div>
    <!--    头部-->
    <div style="display: flex; height: 60px; line-height: 60px; border-bottom: 1px solid #eee">
      <div style="width: 300px; display: flex; padding-left: 30px">
        <div style="width: 60px">
          <img src="@/assets/img/logo.jpg" style="width: 50px;height: 50px; position: relative; top: 5px; right: 0">
        </div>
        <div style="flex: 1">欢迎来到DQ博客系统</div>
      </div>
      <div style="flex: 1">
        <!--        导航菜单-->
        <!--        <ul style="list-style: none; background-color: 	#98FB98; ">-->
        <!--          <li class="item">-->
        <!--            <el-dropdown size="medium">-->
        <!--              <span>更多菜单<i class="el-icon-arrow-down el-icon&#45;&#45;right"></i></span>-->
        <!--              <el-dropdown-menu slot="dropdown">-->
        <!--                <el-dropdown-item icon="el-icon-plus">黄金糕</el-dropdown-item>-->
        <!--                <el-dropdown-item>狮子头</el-dropdown-item>-->
        <!--                <el-dropdown-item>螺蛳粉</el-dropdown-item>-->
        <!--                <el-dropdown-item>双皮奶</el-dropdown-item>-->
        <!--                <el-dropdown-item>蚵仔煎</el-dropdown-item>-->
        <!--              </el-dropdown-menu>-->
        <!--            </el-dropdown>-->
        <!--          </li>-->
        <!--          <li class="item"><a href="/">菜单2</a></li>-->
        <!--          <li class="item"><a href="/">菜单3</a></li>-->
        <!--          <li class="item"><a href="/">菜单4</a></li>-->
        <!--        </ul>-->

        <el-menu :default-active="'1'" class="el-menu-demo" mode="horizontal" router>
          <el-menu-item index="/home">首页</el-menu-item>
          <el-menu-item index="/article">文章列表</el-menu-item>
          <el-submenu>
            <template slot="title"><i class="fa fa-wa fa-archive"></i> 分类</template>
            <el-menu-item v-for="(item,index) in classListObj" :key="'class1'+index" :index="'/article?categoryId='+item.id">{{item.name}}</el-menu-item>
          </el-submenu>
          <el-menu-item index="/link">友链</el-menu-item>
          <el-menu-item index="/aboutMe">关于我</el-menu-item>
        </el-menu>
      </div>
      <div style="width: 200px">
        <div v-if="!user.userName" style="text-align: right; padding-right: 30px">
          <el-button @click="$router.push('/login')">登录</el-button>
          <el-button @click="$router.push('/register')">注册</el-button>
        </div>
        <div v-else>
          <el-dropdown style="width: 150px; cursor: pointer; text-align: right">
            <div style="display: inline-block">
              <img :src="user.avatar" alt=""
                   style="width: 30px;height: 30px; border-radius: 50%; position: relative; top: 10px; right: 5px">
              <span>{{ user.nickName }}</span><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
            </div>
            <el-dropdown-menu slot="dropdown" style="width: 100px; text-align: center">
              <el-dropdown-item style="font-size: 14px; padding: 5px 0">
                <router-link to="/person">个人信息</router-link>
              </el-dropdown-item>
              <el-dropdown-item style="font-size: 14px; padding: 5px 0">
                <span style="text-decoration: none" @click="logout">退出</span>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>

    <div style="width: 1000px; margin: 0 auto">
      <router-view @refreshUser="getUser"/>
    </div>
  </div>
</template>

<script>
export default {
  name: "Front",


  data() {
    return {
      classListObj:'',
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    // 从后台获取最新的User数据
    this.getUser()
    this.getCategoryList()
  },
  methods: {
    logout() {
      this.$store.commit("logout")
      this.$message.success("退出成功")
      location.reload();
      this.$router.push("/home")
    },
    getUser() {
      let username = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).userName : ""
      if (username) {
        // 从后台获取User数据
        this.request.get("/front/user/username/" + username).then(res => {
          // 重新赋值后台的最新User数据
          this.user = res.data
        })
      }
    },
    getCategoryList(){
      this.request.get("/front/category/listAllCategory").then(res => {
        this.classListObj = res.data
      })
    }
  }
}
</script>

<style>
.item{
  display: inline-block;
  width: 100px;

  text-align: center;
  cursor: pointer
}
.item a {
  color: 	#1E90FF;
}
.item:hover{
  background-color: 	LightPink;
}
</style>
