<template>
  <el-container>
    <!-- 头部 -->
    <el-header style="height: 100px;">
      <span>员工后台管理系统</span>
    </el-header>
    <!-- 页面主体区域 -->
    <el-container>
      <!-- 侧边栏 -->
      <el-aside width="300px">
        <el-menu
          :default-active="$route.path"
          class="el-menu-vertical-demo"
          background-color="#5d6371"
          text-color="#eee"
          active-text-color="#1391E3"
          router
          v-for="item1 in section"
          :key="item1.id"
        >
          <el-submenu :index="'/show/'+item1.id">
            <template slot="title">
              <span>{{item1.name}}</span>
            </template>
            <el-menu-item-group v-for="item2 in item1.children" :key="item2.id">
              <el-menu-item :index="'/show/'+item2.id">{{item2.name}}</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>
      <!-- 主体区域 -->
      <el-main>
        <show :post="post"></show>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import show from "../components/show.vue";
export default {
  name: "home",
  data() {
    return {
      section: [],
      post: []
    };
  },
  components: {
    show
  },
  created() {
    this.getsection();
    this.getpost();
  },
  methods: {
    // 请求部门数据
    getsection() {
      this.axios
        .get("/api/getsection")
        .then(response => {
          this.section = response.data;
        })
        .catch(error => {
          console.log(error);
        });
    },
    // 请求岗位数据
    getpost() {
      this.axios
        .get("/api/getpost")
        .then(response => {
          // console.log(response);
          this.post = response.data;
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>


<style lang="less" scoped>
.el-container {
  height: 100%;
  .el-header {
    background-color: #5d6371;
    color: #eee;
    font-size: 30px;
    text-align: center;
    line-height: 100px;
  }
  .el-aside {
    background-color: #5d6371;
    .toggle_btn {
      background-color: pink;
      color: #fff;
      font-size: 10px;
      line-height: 24px;
      text-align: center;
      letter-spacing: 2px;
      cursor: pointer;
    }
    h5 {
      text-align: center;
      margin: 10px 0;
      color: #eee;
      font-family: 幼圆;
      font-size: 30px;
    }
    .el-menu {
      // 清楚border
      border: none;
    }
  }
  .el-main {
    background-color: #eee;
  }
}
</style>