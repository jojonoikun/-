<template>
  <div class="show">
    <!-- 头部搜索 -->
    <div class="search">
      <el-row>
        <el-col :span="20">
          <div class="grid-content bg-purple">
            <el-select v-model="option" placeholder="所有岗位">
              <el-option v-for="item in post" :key="item.id" :label="item.name" :value="item.id"></el-option>
            </el-select>
            <el-input v-model="input" placeholder="输入你想搜索的员工名称" clearable></el-input>
            <el-button plain @click="findstaff">搜索</el-button>
          </div>
        </el-col>
        <el-col :span="4">
          <div class="grid-content bg-purple-light">
            <el-button type="primary" @click="adddialogVisible = true">添加员工</el-button>
          </div>
        </el-col>
      </el-row>
    </div>
    <!-- 表格 -->
    <el-table :data="staff_show" style="width: 100%" border stripe>
      <el-table-column align="center" type="index" label="#" width="40"></el-table-column>
      <el-table-column align="center" prop="name" label="姓名"></el-table-column>
      <el-table-column align="center" prop="sex" label="性别"></el-table-column>
      <el-table-column align="center" prop="birthday" label="年龄" width="280">
        <template v-slot="scope">{{ scope.row.birthday | toage }}</template>
      </el-table-column>
      <el-table-column align="center" prop="poid" label="岗位"></el-table-column>
      <el-table-column align="center" prop="other" label="备注"></el-table-column>
      <el-table-column align="center" label="操作" width="130">
        <template v-slot="scope">
          <!-- 修改 -->
          <el-tooltip class="item" effect="dark" content="修改" placement="top" :enterable="false">
            <el-button type="primary" icon="el-icon-edit" circle @click="show(scope.row.id)"></el-button>
          </el-tooltip>
          <!-- 删除 -->
          <el-tooltip class="item" effect="dark" content="删除" placement="top" :enterable="false">
            <el-button
              type="danger"
              icon="el-icon-delete-solid"
              circle
              @click="remove(scope.row.id)"
            ></el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加用户弹出层 -->
    <el-dialog title="添加用户" :visible.sync="adddialogVisible" width="50%">
      <el-form
        :model="addfrom"
        :rules="addrules"
        ref="addFormref"
        label-width="100px"
        class="demo-ruleForm"
      >
        <el-form-item label="用户名" prop="name">
          <el-input v-model="addfrom.name"></el-input>
        </el-form-item>

        <el-form-item label="性别" prop="sex">
          <el-radio-group v-model="addfrom.sex">
            <el-radio label="男"></el-radio>
            <el-radio label="女"></el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="岗位" prop="poid">
          <el-select v-model="addfrom.poid" placeholder="请选择岗位">
            <el-option v-for="item in post" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="出生日期" required>
          <el-col :span="9">
            <el-form-item prop="birthday">
              <el-date-picker
                format="yyyy 年 MM 月 dd 日"
                value-format="yyyy-MM-dd"
                placeholder="选择日期"
                v-model="addfrom.birthday"
                style="width: 100%;"
              ></el-date-picker>
            </el-form-item>
          </el-col>
        </el-form-item>

        <el-form-item label="备注" prop="other">
          <el-input type="textarea" v-model="addfrom.other"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="resetForm">清 空</el-button>
        <el-button type="primary" @click="upForm">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 修改员工信息弹出层 -->
    <el-dialog title="修改用户" :visible.sync="updateDialogVisible" width="50%">
      <el-form
        :model="updatefrom"
        :rules="updaterules"
        ref="updateFormref"
        label-width="100px"
        class="demo-ruleForm"
      >
        <el-form-item label="用户名" prop="name">
          <el-input v-model="updatefrom.name"></el-input>
        </el-form-item>

        <el-form-item label="性别" prop="sex">
          <el-radio-group v-model="updatefrom.sex">
            <el-radio label="男"></el-radio>
            <el-radio label="女"></el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="岗位" prop="poid">
          <el-select v-model="updatefrom.poid" placeholder="请选择岗位">
            <el-option v-for="item in post" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="出生日期" required>
          <el-col :span="9">
            <el-form-item prop="birthday">
              <el-date-picker
                format="yyyy 年 MM 月 dd 日"
                value-format="yyyy-MM-dd"
                placeholder="选择日期"
                v-model="updatefrom.birthday"
                style="width: 100%;"
              ></el-date-picker>
            </el-form-item>
          </el-col>
        </el-form-item>

        <el-form-item label="备注" prop="other">
          <el-input type="textarea" v-model="updatefrom.other"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="resetForm2">清 空</el-button>
        <el-button type="primary" @click="setForm">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
     

<script>
export default {
  name: "show",
  data() {
    return {
      // 搜索 选择的岗位
      option: "",
      // 输入的搜索内容
      input: "",
      // 员工信息
      staff_show: [],
      //   添加对话框的显示隐藏
      adddialogVisible: false,
      //   添加表单的信息
      addfrom: {
        name: "",
        sex: "",
        poid: "",
        seid: "",
        birthday: "",
        other: ""
      },
      //   添加表单的验证规则
      addrules: {
        name: [
          { required: true, message: "请输入活动名称", trigger: "blur" },
          { min: 1, max: 8, message: "长度在 1 到 8 个字符", trigger: "blur" }
        ],
        sex: [{ required: true, message: "请选择性别", trigger: "change" }],
        post: [{ required: true, message: "请选择岗位", trigger: "change" }],
        birthday: [
          {
            required: true,
            message: "请选择日期",
            trigger: "change"
          }
        ]
      },
      // 员工编辑对话框的显示与隐藏
      updateDialogVisible: false,
      // 获取的用户对象
      updatefrom: {
        name: "",
        sex: "",
        poid: "",
        seid: "",
        birthday: "",
        other: ""
      },
      // 修改提示框的用户规则
      updaterules: {
        name: [
          { required: true, message: "请输入活动名称", trigger: "blur" },
          { min: 1, max: 8, message: "长度在 1 到 8 个字符", trigger: "blur" }
        ],
        sex: [{ required: true, message: "请选择性别", trigger: "change" }],
        post: [{ required: true, message: "请选择岗位", trigger: "change" }],
        birthday: [
          {
            required: true,
            message: "请选择日期",
            trigger: "change"
          }
        ]
      }
    };
  },
  props: ["post"],
  created() {},
  methods: {
    // 根据部门  请求员工数据
    getstaff() {
      this.axios
        .get("/api/getstaff?id=" + this.$route.params.id)
        .then(response => {
          this.staff_show = response.data;
          for (let i = 0; i < this.staff_show.length; i++) {
            for (let j = 0; j < this.post.length; j++) {
              if (this.staff_show[i].poid === this.post[j].id) {
                this.staff_show[i].poid = this.post[j].name;
              }
            }
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    // 提交添加用户表单
    upForm() {
      this.$refs.addFormref.validate(valid => {
        if (valid) {
          this.addfrom.seid = this.$route.params.id;
          this.axios.post("/api/addstaff", this.addfrom).then(res => {
            if (res.data.code !== 200) {
              return this.$message.error({
                duration: 800,
                message: "添加失败"
              });
            }
            this.$message.success({
              duration: 800,
              message: "添加成功"
            });
            // 隐藏对话框
            this.adddialogVisible = false;
            // 刷新员工列表数据
            this.getstaff();
            // 清空输入表单
            this.resetForm();
          });
        } else {
          console.log("表单数据有错误");
          return false;
        }
      });
    },
    // 清空添加用户表单
    resetForm() {
      this.$refs.addFormref.resetFields();
    },
    // 按照搜索内容搜索员工
    findstaff() {
      this.axios
        .get("/api/findstaff", {
          params: {
            seid: this.$route.params.id,
            poid: this.option,
            name: this.input
          }
        })
        .then(response => {
          this.staff_show = response.data;
          for (let i = 0; i < this.staff_show.length; i++) {
            for (let j = 0; j < this.post.length; j++) {
              if (this.staff_show[i].poid === this.post[j].id) {
                this.staff_show[i].poid = this.post[j].name;
              }
            }
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    // 删除员工
    async remove(id) {
      const confirmRes = await this.$confirm(
        "是否确定永久删除该员工, ?",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      ).catch(err => err);
      // 确认删除返回的是 confirm 字符串
      // 取消删除返回的是 cancel 字符串
      if (confirmRes !== "confirm") {
        return this.$message.error({
          duration: 800,
          message: "已取消删除"
        });
      }

      this.axios
        .get("/api/removestaff", {
          params: {
            id: id
          }
        })
        .then(res => {
          if (res.data.code !== 200) {
            return this.$message.error({
              duration: 800,
              message: "删除失败"
            });
          }
          this.$message.success({
            duration: 800,
            message: "删除成功"
          });
          // 刷新员工列表
          this.getstaff();
        });
    },
    // 展示编辑员工对话框
    show(id) {
      // 请求该员工的数据
      console.log("请求该员工的数据" + id);
      this.axios
        .get("/api/staff_id", {
          params: {
            id: id
          }
        })
        .then(response => {
          this.updatefrom = response.data[0];
        })
        .catch(error => {
          console.log(error);
        });
      // 展示编辑对话框
      this.updateDialogVisible = true;
    },
    // 弹出框关闭事件
    resetForm2() {
      this.$refs.updateFormref.resetFields();
    },
    // 提交修改信息
    setForm() {
      this.$refs.updateFormref.validate(valid => {
        if (!valid) return;
        console.log(this.updatefrom.birthday);
        this.updatefrom.birthday = this.formateDate(this.updatefrom.birthday);
        this.axios.post("/api/update", this.updatefrom).then(res => {
          // console.log(res)
          if (res.data.code !== 200) {
            return this.$message.error({
              duration: 800,
              message: "修改失败"
            });
          }
          // 关闭修改对话框
          this.updateDialogVisible = false;
          // 刷新数据
          this.getstaff();
          this.$message.success({
            duration: 800,
            message: "修改成功"
          });
        });
      });
    },
    // 格式化事件
    formateDate(datetime) {
      // let  = "2019-11-06T16:00:00.000Z"
      function addDateZero(num) {
        return num < 10 ? "0" + num : num;
      }
      let d = new Date(datetime);
      let formatdatetime =
        d.getFullYear() +
        "-" +
        addDateZero(d.getMonth() + 1) +
        "-" +
        addDateZero(d.getDate());
      return formatdatetime;
    }
  },

  watch: {
    // 如果路由有变化，会再次执行该方法
    $route: "getstaff"
  },
  filters: {
    // 过滤生日
    toage: function(value) {
      let birthday = new Date(value);
      let d = new Date();
      // 当前年份 - 出生年份  当前月份 < 出生月份 则 直接减 1岁  当前月份 = 出生月份 且 当前日期 < 出生日期 也减 1岁
      let age =
        d.getFullYear() -
        birthday.getFullYear() -
        (d.getMonth() < birthday.getMonth() ||
        (d.getMonth() === birthday.getMonth() &&
          d.getDate() < birthday.getDate())
          ? 1
          : 0);
      return age;
    }
  }
};
</script>


<style lang="less" scoped>
.show {
  .search {
    margin-top: 15px;
    .el-input {
      width: 300px;
      margin: 0 30px;
    }
    .el-button {
      width: 100px;
    }
  }
  .el-table {
    margin-top: 40px;
  }
}
</style>
