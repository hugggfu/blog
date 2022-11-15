<template>
  <div class="app-container">

    <el-form ref="form" :model="form" label-width="90px">
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="文章标题" prop="title">
            <el-input
                v-model="form.title"
                placeholder="请输入文章标题"
                maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="分类">
            <el-select v-model="form.categoryId" placeholder="请选择">
              <el-option
                  v-for="category in categoryList"
                  :key="category.id"
                  :label="category.name"
                  :value="category.id"
              />
              <!-- <el-option :key="'1'" label="女" :value="'1'" /> -->
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="标签">
            <el-select v-model="form.tags" placeholder="请选择" multiple>
              <el-option
                  v-for="tag in tagList"
                  :key="tag.id"
                  :label="tag.name"
                  :value="tag.id"
              />
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="文章摘要">
            <el-input v-model="form.summary" type="textarea" />
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="允许评论">
            <el-radio-group v-model="form.isComment">
              <el-radio :key="'0'" :label="'0'">正常</el-radio>
              <el-radio :key="'1'" :label="'1'">停用</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="是否置顶">
            <el-radio-group v-model="form.isTop">
              <el-radio :key="'0'" :label="'0'">是</el-radio>
              <el-radio :key="'1'" :label="'1'">否</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>

      </el-row>
      <el-row :gutter="20" />

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="缩略图">
            <el-upload
                class="avatar-uploader"
                :action="'http://localhost:8888/upload'"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
            >
              <img v-if="form.thumbnail" :src="form.thumbnail" class="avatar">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item>
            <el-button type="primary" size="medium" @click="handleSubmit">{{ aId?"更新":"发布" }}</el-button>
          </el-form-item>
          <el-form-item>
            <el-button v-if="!aId" type="info" @click="handleSave">保存到草稿箱</el-button>
          </el-form-item>

        </el-col>
      </el-row>
      <el-row>
        <mavon-editor ref="md" v-model="form.content" @imgAdd="imgAdd" />
      </el-row>
    </el-form>
  </div>
</template>

<script>

import axios from "axios";

export default {
  name: 'Write',
  data() {
    return {
      form: {
        title: '',
        thumbnail: '',
        isTop: '1',
        isComment: '0',
        content: ''
      },
      categoryList: [],
      tagList: [],
      aId: -1,
      fileList: []

    }
  },
  watch: {
    $route: {
      handler: function(route) {
        this.aId = route.query && route.query.id
        console.log(this.aId)
      },
      immediate: true
    }
  },
  created() {
    this.getCategoryAndTag()
    if (this.aId) {
      this.getArticle()
    }
  },
  methods: {
    getArticle() {
      this.request.get("/article/"+ this.aId).then(res =>{
        this.form = res.data
        this.fileList.push({ name: '缩略图', url: res.thumbnail })
      })
    },
    handleSave() {
      this.form.status = '1'
      this.request.post("/article", this.form).then(res => {
        if (res.code===200) {
          this.$message.success("保存成功")
          this.$router.push({path: '/article'})
        }
      })
    },
    handleSubmit() {
      if (!this.aId) {
        this.form.status = '0'
        this.request.post("/article", this.form).then(res => {
          if (res.code===200) {
            this.$message.success("保存成功")
            this.$router.push({path: '/article'})
          }
        })
      } else {
        // 更新博客信息
       this.request.put("/article", this.form).then(res => {
         if (res.code===200) {
           this.$message.success("保存成功")
           this.$router.push({path: '/article'})
         }
        })
      }
    },

    // 绑定@imgAdd event
    imgAdd(pos, $file) {
      let $vm = this.$refs.md
      // 第一步.将图片上传到服务器.
      const formData = new FormData();
      formData.append('file', $file);
      axios({
        url: 'http://localhost:8888/upload',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
      }).then((res) => {
        // 第二步.将返回的url替换到文本原位置![...](./0) -> ![...](url)
        $vm.$img2Url(pos, res.data.data);
      })
    },
    getCategoryAndTag() {
      this.request.get("/category/listAllCategory").then(res=>{
        this.categoryList=res.data
      })
      this.request.get("/tag/listAllTag").then(res=>{
        this.tagList=res.data
      })

    },
    handleAvatarSuccess(res,file) {
      this.form.thumbnail = res.data
    }
  }
}
</script>
<style scoped>
div .upload-demo {
  /* padding-left: 80px; */
}
.el-col .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;

  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
