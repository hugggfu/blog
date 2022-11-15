<template>
  <div>
    <h1>欢迎来到我的博客</h1>
    <div style="margin: 10px 0">
      <el-carousel height="600px" :interval="10000">
        <el-carousel-item v-for="item in imgs" :key="item">
          <img :src="item.url" alt="" style="width: 100%">
        </el-carousel-item>
      </el-carousel>
    </div>

  </div>
</template>

<script>
export default {
  name: "Home",
  data() {
    return {
      imgs: [

        { url: require("../assets/img/5.jpg") },
        { url: require("../assets/img/1.png") },
        { url: require("../assets/img/2.jpg") },
        { url: require("../assets/img/3.jpg") },
      ]
    }
  },

}
</script>

<style>
h1{
  font: 96px "微软雅黑"; /*设置字体和字体大小*/
  margin:50px auto; /*设置元素外边距*/
  font-weight: 500; /*设置字体粗细*/
  text-align: center; /*设置文字居中*/
  color: dodgerblue; /*设置文字颜色*/
  -webkit-animation:bounce 2s infinite;/*设置动画*/
}
@-webkit-keyframes bounce{/*创建动画*/
  0%,100%,20%,50%,80%{
    -webkit-transform:translateY(0);
  }40%{
     -webkit-transform:translateY(-30px);
   }60%{
      -webkit-transform:translateY(-15px);
    }
}
</style>
