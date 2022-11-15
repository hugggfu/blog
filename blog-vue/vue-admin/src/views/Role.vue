<template>
<div>
  <div style="margin: 10px 0">
    <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="roleName"></el-input>
    <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
    <el-button  type="warning" @click="reset" >重置</el-button>
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
  </div>

  <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'" @selection-change="handleSelectionChange">
    <el-table-column type="selection" width="55"></el-table-column>
    <el-table-column prop="id" label="ID" width="80"></el-table-column>
    <el-table-column prop="roleName" label="角色名称" ></el-table-column>
    <el-table-column prop="roleKey" label="权限字符"></el-table-column>
    <el-table-column prop="roleSort" label="显示顺序"></el-table-column>
    <el-table-column prop="status" label="状态" align="center">
      <template slot-scope="scope">
        <el-switch
            v-model="scope.row.status"
            active-value="0"
            inactive-value="1"
            @change="handleStatusChange(scope.row)"
        />
      </template>
    </el-table-column>
    <el-table-column prop="description" label="创建时间"></el-table-column>
    <el-table-column label="操作"  width="280" align="center">
      <template slot-scope="scope">
        <el-button type="info" @click="selectMenu(scope.row)">分配菜单 <i class="el-icon-menu"></i></el-button>
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
  <el-dialog title="角色信息" :visible.sync="dialogFormVisible" width="30%" >
    <el-form label-width="80px" size="small">
      <el-form-item label="角色名称">
        <el-input v-model="form.roleName" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="权限字符">
        <el-input v-model="form.roleKey" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="角色顺序" prop="roleSort">
        <el-input-number
            v-model="form.roleSort"
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
      <el-form-item label="新增时间">
        <el-date-picker v-model="form.createTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="选择日期时间"></el-date-picker>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="submitForm">确 定</el-button>
    </div>
  </el-dialog>
  <el-dialog title="菜单分配" :visible.sync="menuDialogVis" width="30%" >
    <el-tree
        :props="props"
        :data="menuData"
        node-key="id"
        ref="tree"
        :default-expanded-keys="expends"
        :default-checked-keys="checks"
        show-checkbox
        check-strictly
        >
       <span class="custom-tree-node" slot-scope="{ node, data }">
            <span><i :class="data.icon"></i> {{ data.menuName }}</span>
         </span>
    </el-tree>
    <div slot="footer" class="dialog-footer">
      <el-button @click="menuDialogVis = false">取 消</el-button>
      <el-button type="primary" @click="saveRoleMenu">确 定</el-button>
    </div>
  </el-dialog>

</div>
</template>

<script>
import Aside from "@/components/Aside";
import Header from "@/components/Header";

export default {
  name: "Role",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      roleName: "",
      roleKey: '',
      roleSort: "",
      status: "",
      time: "",
      dialogFormVisible: false,
      menuDialogVis: false,
      form: {},
      multipleSelection: [],
      menuData:  [],
      props:{
        label:'name',
      },
      expends:[],
      checks:[],
      roleId: 0,
      roleFlag:'',
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
      this.request.get("/role/list", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          roleName: this.roleName,
          description: this.description,
        }
      }).then(res => {
        console.log(res)

        this.tableData = res.data.rows
        this.total = res.data.total

      })
    },
    handleAdd(){
      this.dialogFormVisible=true
      this.form={}

    },
    submitForm(){
      if (this.form.id !== undefined){
        this.request.put("/role", this.form).then(res => {
          if (res.code===200) {
            this.$message.success("修改成功")
            this.dialogFormVisible = false
            this.load()
          } else {
            this.$message.error(res.msg)
          }
        })
      }else
        this.request.post("/role", this.form).then(res => {
          if (res.code===200) {
            this.$message.success("保存成功")
            this.dialogFormVisible = false
            this.load()
          } else {
            this.$message.error(res.msg)
          }
        })
    },
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
    },
    del(id) {
      this.request.delete("/role/" + id).then(res => {
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
      this.request.post("/role/"+ ids).then(res => {
        if (res.code===200) {
          this.$message.success("批量删除成功")
          this.load()
        }

        else {
          this.$message.error(res.msg)
        }
      })
    },
    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
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
    saveRoleMenu(){
      this.request.post("/role/roleMenu/" + this.roleId, this.$refs.tree.getCheckedKeys()).then(res => {
        if(res.code===200){
          this.$message.success("绑定成功")
          this.menuDialogVis=false
          // 操作管理员角色后需要重新登录
           if (this.roleKey === 'admin') {
             this.$store.commit("logout")
           }
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    selectMenu(role){
      this.menuDialogVis=true
      this.roleId=role.id;
      this.roleFlag=role.roleKey;
      //请求菜单数据
      this.request.get("/menu/list").then(res => {
        this.menuData = res.data
        //把后台返回的菜单数据处理成id数组
        this.expends=this.menuData.map(v => v.id)
      })
      this.request.get("/role/roleMenu/" +this.roleId).then(res => {
        this.checks= res.data

        this.request.get("/menu/ids").then(r =>{

          const ids=r.data;
          ids.forEach(id =>{
            if (!this.checks.includes(id)) {
              // 可能会报错：Uncaught (in promise) TypeError: Cannot read properties of undefined (reading 'setChecked')
              this.$refs.tree.setChecked(id, false)
            }
          })
          this.menuDialogVis = true
        })

      })
    },

  }
}
</script>

<style>
.headerBg {
  background: #eee!important;
}
</style>
