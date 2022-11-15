<template>
  <div>
    <div style="margin: 10px 0">
      <el-carousel height="800px" :interval="10000">
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
        { url: require("../assets/img/1.png") },
        { url: require("../assets/img/2.jpg") },
        { url: require("../assets/img/3.jpg") },
      ]
    }
  },

}
</script>

<style scoped>

</style>

