<template>
  <el-card style="width: 500px;">
    <el-form label-width="80px" size="small">
      <el-upload
          class="avatar-uploader"
          :action="'http://localhost:8787/front/upload'"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
      >
        <img v-if="form.avatar" :src="form.avatar" class="avatar">
        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
      </el-upload>
      <el-form-item label="用户名">
        <el-input v-model="form.userName" disabled autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="昵称">
        <el-input v-model="form.nickName" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="邮箱">
        <el-input v-model="form.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="电话">
        <el-input v-model="form.phonenumber" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="用户性别">
        <el-select v-model="form.sex" placeholder="请选择">
          <el-option :key="'0'" label="男" :value="'0'" />
          <el-option :key="'1'" label="女" :value="'1'" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="save" >确 定</el-button>
        <el-button type="warning" size="small"  autocomplete="off" @click="$router.push('/home')">返回</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>


export default {
  name: "Person",
  data() {
    return {
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {
    this.getUser().then(res => {
      console.log(res)
      this.form = res
    })
  },
  methods: {
    async getUser() {
      return (await this.request.get("/front/user/username/" + this.user.userName)).data
    },
    save() {
      this.request.post("/front/user/update", this.form).then(res => {
        if (res.code === 200) {
          this.$message.success("修改成功")
          // 触发父级更新User的方法
          this.$emit("refreshUser")
          // 更新浏览器存储的用户信息
          this.getUser().then(res => {
            res.token = JSON.parse(localStorage.getItem("user")).token
            localStorage.setItem("user", JSON.stringify(res))
          })

        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleAvatarSuccess(res,file) {
      console.log("res",res)
      this.form.avatar = res.data
    }
  }
}
</script>

<style>
.avatar-uploader {
  text-align: center;
  padding-bottom: 10px;
}
.avatar-uploader .el-upload {
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
  width: 138px;
  height: 138px;
  line-height: 138px;
  text-align: center;
}
.avatar {
  width: 138px;
  height: 138px;
  display: block;
}
</style>
