<template>
<div>
  <div style="margin: 10px 0">
    <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="name"></el-input>
    <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
    <el-button  type="warning" @click="reset" >重置</el-button>
  </div>

  <div style="margin: 10px 0">
    <el-button type="primary" @click="handleAddd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
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
  </div>

  <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"
            row-key="id"  @selection-change="handleSelectionChange">
    <el-table-column type="selection" width="55"></el-table-column>

    <el-table-column prop="menuName" label="菜单名称" ></el-table-column>
    <el-table-column prop="icon" label="图标" >
      <template slot-scope="scope">
        <i :class="scope.row.icon" style="font-size: 16px"></i>
      </template>
    </el-table-column>
    <el-table-column prop="orderNum" label="排序"></el-table-column>
    <el-table-column prop="path" label="路径"></el-table-column>
    <el-table-column prop="component" label="页面路径"></el-table-column>
    <el-table-column prop="status" label="状态" width="80">
      <template slot-scope="scope">
        <el-tag v-if="scope.row.status==0" type="success">正常</el-tag>
        <el-tag v-if="scope.row.status==1" type="danger">停用</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作"  width="300" align="center">
      <template slot-scope="scope">
        <el-button type="primary" @click="handleAdd(scope.row.id)" v-if=" scope.row.component">增加子菜单 <i class="el-icon-edit"></i></el-button>
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
  <el-dialog title="菜单信息" :visible.sync="dialogFormVisible" width="30%" >
    <el-form label-width="80px" size="small">
      <el-form-item label="名称">
        <el-input v-model="form.menuName" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="路径">
        <el-input v-model="form.path" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="页面路径">
        <el-input v-model="form.component" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="图标">
        <el-select v-model="form.icon" placeholder="请选择" autocomplete="off" style="width: 100%;">
          <el-option v-for="item in options" :key="item.name" :value="item.value" :label="item.name" >
            <i :class="item.value"></i> {{item.name}}
          </el-option>
        </el-select>
    </el-form-item>
      <el-form-item label="菜单顺序" prop="roleSort">
        <el-input-number
            v-model="form.orderNum"
            controls-position="right"
            :min="0"
        />
      </el-form-item>
      <el-form-item label="状态">
        <el-radio-group v-model="form.status">
          <el-radio :key="'0'" :label="'0'">正常</el-radio>
          <el-radio :key="'1'" :label="'1'">停用</el-radio>
        </el-radio-group>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="save">确 定</el-button>
    </div>
  </el-dialog>

</div>
</template>

<script>
import Aside from "@/components/Aside";
import Header from "@/components/Header";

export default {
  name: "Menu",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 2,
      menuName: "",
      orderNum:"",
      pagePath:"",
      dialogFormVisible: false,
      form: {},
      multipleSelection: [],
      options:[],
    }
  },
  created() {
    // 请求分页查询数据
    this.load()
  },

  methods: {
    collapse() {  // 点击收缩按钮触发
      this.isCollapse = !this.isCollapse
      if (this.isCollapse) {  // 收缩
        this.sideWidth = 64
        this.collapseBtnClass = 'el-icon-s-unfold'
        this.logoTextShow = false
      } else {   // 展开
        this.sideWidth = 200
        this.collapseBtnClass = 'el-icon-s-fold'
        this.logoTextShow = true
      }
    },
    load() {
      this.request.get("/menu/list", {
        params: {
          name: this.name,
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data
      })
    },
    handleAdd(pid){
      this.dialogFormVisible=true
      this.form={}
      if(pid){
        this.form.parentId=pid;
      }
    },
    handleAddd(){
      this.dialogFormVisible=true
      this.form={}
      this.request.get("/menu/icons").then(res=>{
        this.options=res.data
      })
    },
    save(){
      this.request.post("/menu",this.form).then(res => {
        if(res.code ===200){
          this.$message.success("保存成功")
          this.dialogFormVisible=false
          this.load()
        }else {
          this.$message.error("保存失败")
        }
      })
    },
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
      this.request.get("/menu/icons").then(res=>{
        this.options=res.data
      })
    },
    del(id) {
      this.request.delete("/menu/" + id).then(res => {
        if(res.code===200){
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    },
    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
    },
    delBatch() {
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/menu/del/batch", ids).then(res => {
        if(res.code===200){
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },
    reset(){
      this.name=""
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
    handleExcelImportSuccess() {
      this.$message.success("导入成功")
      this.load()
    },
    exp() {
      window.open("http://localhost:8081/menu/export")
    }
  }
}
</script>

<style>
.headerBg {
  background: #eee!important;
}
</style>
