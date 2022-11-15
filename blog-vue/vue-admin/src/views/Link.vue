<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="blogName"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='我再想想'
          icon="el-icon-info"
          icon-color="red"
          title="您确定批量删除这些数据吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
      <el-upload action="http://localhost:8082/user/import" :show-file-list="false" accept="xlsx" :on-success="handleExcelImportSuccess" style="display: inline-block">
        <el-button type="primary" class="ml-5">导入 <i class="el-icon-bottom"></i></el-button>
      </el-upload>
      <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-top"></i></el-button>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="pictureaddress" label="友链图片" >
        <!-- 图片的显示 -->
        <template   slot-scope="scope">
          <img :src="scope.row.pictureaddress"  min-width="70" height="70" />
        </template>

      </el-table-column>
      <el-table-column prop="blogname" label="友链名称"></el-table-column>
      <el-table-column prop="blogaddress" label="友链地址" align="center">
      </el-table-column>
      <el-table-column label="操作"  width="200" align="center">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="red"
              title="您确定删除吗？"
              @confirm="del(scope.row.id)"
          >
            <el-button type="danger" slot="reference">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="parseInt(total)">
      </el-pagination>
    </div>

    <el-dialog title="友链信息" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" size="small">

        <el-form-item label="友链名称">
          <el-input v-model="form.blogname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="友链地址">
          <el-input v-model="form.blogaddress" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="博客图片">
          <el-upload
              class="avatar-uploader"
              :action="'http://localhost:8888/upload'"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
          >
            <img v-if="form.pictureaddress" :src="form.pictureaddress" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>

      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Link",
  data() {
    return {
      tableData: [],
      fileList:[],
      total: "0",
      blogName:"",
      pageNum: 1,
      pageSize: 10,
      form: {},
      dialogFormVisible: false,

    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      this.request.get("/link/list", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data.rows
        this.total = res.data.total

      })

    },
    submitForm(){
      if (this.form.id !== undefined){
        this.request.put("/link", this.form).then(res => {
          if (res.code===200) {
            this.$message.success("修改成功")
            this.dialogFormVisible = false
            this.load()
          } else {
            this.$message.error(res.msg)
          }
        })
      }else
        this.request.post("/link", this.form).then(res => {
          if (res.code===200) {
            this.$message.success("保存成功")
            this.dialogFormVisible = false
            this.load()
          } else {
            this.$message.error(res.msg)
          }
        })
    },
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },
    handleEdit(row) {
      this.dialogFormVisible = true
      this.form = JSON.parse(JSON.stringify(row));
      const userId = row.id
      this.request.get("/link/"+userId).then(res =>{
        this.form = res.data

      })

    },

    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
    },
    del(id) {
      this.request.delete("/link/" + id).then(res => {
        if(res.code ===200){
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    delBatch() {
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/link/"+ ids).then(res => {
        if (res.code===200) {
          this.$message.success("批量删除成功")
          this.load()
        }

        else {
          this.$message.error(res.msg)
        }
      })
    },
    reset() {
      this.username = ""
      this.email = ""
      this.load()
    },
    handleSizeChange(pageSize) {
      console.log(pageSize)
      this.pageSize = pageSize
      this.load()
    },
    handleAvatarSuccess(res,file) {
      this.form.pictureaddress = res.data
    },
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },
    handleExcelImportSuccess() {
      this.$message.success("导入成功")
      this.load()
    },
    exp() {
      window.open("http://localhost:8082/user/export")
    }
  }
}
</script>


<style>
.headerBg {
  background: #eee!important;
}
</style>
