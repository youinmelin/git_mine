<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        我的浏览记录
      </div>
      <div class="header">
        <el-button size="mini" @click="handleDel">批量管理</el-button>
        <!--        <el-input v-model="input" placeholder="产品搜索" class="input">-->
        <!--          <el-button slot="append" icon="el-icon-search"/>-->
        <!--        </el-input>-->
      </div>
      <div class="videos">
        <div
          v-for="item in list"
          :key="item.id"
          class="video-card"
          :body-style="{ padding: '0px' }"
        >
          <i v-if="isDel" class="el-icon-delete-solid"/>
          <VideoItem :content="item" :show-bottom="true" :bottom-style="2"/>
        </div>
      </div>
      <div class="block">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="page.currentPage"
          :page-sizes="[10,20,30,40,50]"
          :page-size="10"
          layout="total, sizes, prev, pager, next, jumper"
          :total="page.total">
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
import VideoItem from './../components/VideoItem'
import { getProductHistoryList } from '@/api/product'

export default {
  components: {
    VideoItem
  },
  data() {
    return {
      input: '',
      isDel: false,
      contentData: [],
      list: [],
      page: {
        currentPage: 1,
        total: 0
      },
      listQuery: {
        page: 1,
        limit: 10,
        status: '',
        strSearch: ''
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    handleDel() {
      this.isDel = !this.isDel
    },
    fetchData() {
      // 获取历史记录
      getProductHistoryList(this.listQuery).then(response => {
        if (response.data.code === 0) {
          this.list = response.data.data.list
          this.page.total = response.data.data.total
          this.loading = false
        } else {
          this.$alert(response.data.msg, '错误', {
            confirmButtonText: '确定',
            type: 'warning',
            callback: action => {
              this.loading = false
              return false
            }
          })
          return false
        }
      })
    },
    // 每页显示条目数点击事件
    handleSizeChange(val) {
      this.listQuery.limit = val
      this.listQuery.page = 1
      this.fetchData()
    },
    // 分页点击事件
    handleCurrentChange(val) {
      this.listQuery.page = val
      this.fetchData()
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  width: 970px;

  .title {
    font-weight: 600;
  }

  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 100px;

    .input {
      width: 300px;
    }
  }

  .videos {
    display: flex;
    flex-wrap: wrap;

    .video-card {
      margin: 0 20px 20px 0;
      position: relative;

      .el-icon-delete-solid {
        position: absolute;
        top: 0;
        right: 0;
        z-index: 10;
        color: crimson;
      }
    }
  }
}
</style>
