<template>

  <div style="color: #666" >
    <div style="margin: 10px 0">
      <el-input size="small" style="width: 300px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="title"></el-input>
      <el-button class="ml-5" type="primary" @click="load" size="small">搜索</el-button>
      <el-button type="warning" @click="reset" size="small">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <div style="padding: 10px 0; border-bottom: 1px dashed #ccc" v-for="item in tableData" :key="item.id">
        <div class="pd-10" style="font-size: 20px; color: #3F5EFB; cursor: pointer" @click="$router.push('/articleDetail?id=' + item.id)">{{ item.title }}</div>
        <div style="font-size: 14px; margin-top: 10px">
          <i class="el-icon-user-solid"></i> <span>发表于</span>
          <i class="el-icon-time" style="margin-left: 10px"></i> <span>{{ item.createTime }} • </span>
          <i class="el-icon-view" ></i> <span>{{item.viewCount}} 次浏览 •</span>
          <i class="el-icon-reading"  style="font-size: larger"  ></i> <span style="color: red">分类 {{item.categoryName}} •</span>

        </div>
      </div>
    </div>


    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="parseInt(total)"
          >

      </el-pagination>
    </div>
  </div>

</template>

<script>

import axios from "axios";

export default {
  name: "Article",
  data() {
    return {
      form: {},
      tableData: [],
      title: '',
      categoryId:'0',
      multipleSelection: [],
      pageNum: 1,
      pageSize: 10,
      total: [],
      dialogFormVisible: false,
      teachers: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      content: '',
      viewDialogVis: false
    }
  },
  watch: {
    '$route' (to, from) { //监听路由是否变化
      if(to.query.categoryId != from.query.categoryId){
        this.categoryId = to.query.categoryId
        this.load();//重新加载数据
      }
    }
  },
  created() {
    if(this.$route.query) {
      this.categoryId = (this.$route.query.categoryId==undefined?null:parseInt(this.$route.query.categoryId))
      this.load();
    }

  },
  methods: {
    load() {
      this.request.get("/front/article/articleList", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title,
          categoryId:this.categoryId,
        }
      }).then(res => {

        this.tableData = res.data.rows
        this.total = res.data.total

      })

    },


    reset() {
      this.title = ""
      this.load()
    },
    handleSizeChange(pageSize) {
      console.log(pageSize)
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },
    download(url) {
      window.open(url)
    },

  }
}
</script>

<style scoped>


</style>
