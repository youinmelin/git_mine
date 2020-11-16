<template>
  <div class="main">

    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        所有消息
      </div>
      <div class="list">
        <div class="cell" v-for="(item,index) in list" :key="index">
          <i class="el-icon-message" :class="[item.status?'read':'unread']"></i>
          <div>
            <span class="title">{{ item.title }}</span>
            <span class="grey">{{ item.gmtCreate }}</span>
            <p>{{ item.content }}</p>
          </div>
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
import { getNoticeList } from '@/api/user'

export default {
  data() {
    return {
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
    fetchData() {
      // 获取信息列表
      getNoticeList(this.listQuery).then(response => {
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
    margin-right: 10px;
  }

  .grey {
    color: #888;
  }
}

.cell {
  display: flex;
  justify-content: baseline;
  border: 1px solid #f0f0f0;
  margin: 20px 0;
  padding: 10px;
  font-size: 15px;
}

.el-icon-message {
  margin: 5px 10px;
}

.unread {
  color: crimson;
}
</style>
