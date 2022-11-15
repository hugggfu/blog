<template>
 <div style="display: flex">
    <div style="flex: 1"></div>
<h2 class="h">
  <p>
    嘿！<br/>
    我的老朋友<br/>
    跟我说话请大点声
  </p>
</h2>
    <div style="flex: 1"></div>
  </div>
</template>

<script>
export default {
  name: "AboutMe"
}
</script>

<style type="text/css">
.h{
  font: 96px "微软雅黑"; /*设置字体和字体大小*/
  margin:50px auto; /*设置元素外边距*/
  font-weight: 500; /*设置字体粗细*/
  text-align: center; /*设置文字居中*/
  color: #42b983; /*设置文字颜色*/
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
