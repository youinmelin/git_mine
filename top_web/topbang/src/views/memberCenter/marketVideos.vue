<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        营销推广
      </div>
      <div class="header">
        <el-tabs>
          <el-tab-pane label="全部推广"/>
          <el-tab-pane>
            <span slot="label">
              审核中<sup class="badge">1</sup>
            </span>
          </el-tab-pane>
          <el-tab-pane label="推广中"/>
          <el-tab-pane label="已结束"/>
        </el-tabs>

        <div class="grey">
          <router-link to="/memberCenter/marketing">
            返回<i class="el-icon-arrow-right"/>
          </router-link>
        </div>

      </div>
      <div class="label">
        <div class="col-1">推广类型</div>
        <div class="col-2">图片/产品</div>
        <div class="col-3">推广时长</div>
        <div class="col-4">金额（元）</div>
        <div class="col-5">状态</div>
        <div class="col-6">操作</div>
      </div>
      <div class="list">
        <div v-for="(item,index) in list" :key="index" class="cell">
          <div class="top">
            <div>单号：<span>{{ item.num }}</span></div>
            <div>{{ item.time }}</div>
          </div>
          <div class="bot">
            <div class="col-1">首页banner展示</div>
            <div class="col-2">
              <img :src="item.imgUrl" alt="">
            </div>
            <div class="col-3">{{ item.cycleNum }}</div>
            <div class="col-4">{{ item.price }}</div>
            <div class="col-5">
              <div :class="[item.status===3?'red':'']">{{ statusMap[item.status] }}</div>
              <div v-if="item.status===2">等待发布</div>
              <div v-if="item.status===3">（图片违规）</div>
              <div v-if="item.status===4" class="red">剩余推广时间6天</div>
            </div>
            <div class="col-4">
              <el-button v-if="item.status===3" type="text">重新上传图片</el-button>
              <el-button v-if="item.status===5" type="text">再次订购</el-button>
            </div>
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
import { marketBannerList } from '@/api/market'

export default {
  data() {
    return {
      role: '',
      value1: '',
      value2: '',
      options: [],
      list: [],
      statusMap: {
        0: '审核中',
        1: '推广中',
        3: '审核通过',
        4: '审核未通过',
        5: '已结束'
      },
      page: {
        currentPage: 1,
        total: 0
      },
      listQuery: {
        page: 1,
        limit: 10
      }
    }
  },
  created() {
    this.role = localStorage.role
    // 初始化加载推广列表
    this.fetchData()
  },
  methods: {
    fetchData() {
      // 获取推广banner列表
      marketBannerList(this.listQuery).then(response => {
        if (response.data.code === 0) {
          this.list = response.data.data.list
          this.page.total = response.data.data.total
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

  .grey {
    color: #888;
    margin: 0;
  }

  .red {
    color: crimson;
  }

  .badge {
    background: crimson;
    color: #fff;
    padding: 0 4px;
    border-radius: 20px;
  }
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 10px 0;
}

.label {
  line-height: 40px;
  background-color: #f0f0f0;
  margin-bottom: 20px;
  display: flex;
  align-content: center;

  .col-1 {
    text-align: center;
  }
}

.list {
  .cell {
    border: 1px solid #f0f0f0;
    margin-bottom: 20px;
  }

  .top {
    line-height: 40px;
    padding: 0 2%;
    background-color: #f0f0f0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #666;
    font-size: 15px;

    span {
      color: #000;
      font-weight: 600;
    }
  }

  .bot {
    height: 120px;
    padding-left: 2%;
    display: flex;
    align-items: center;

    img {
      width: 100px;
      height: 60px;
      object-fit: cover;
    }
  }
}

.col-1 {
  width: 20%;
}

.col-2 {
  text-align: center;
  width: 25%;
}

.col-3 {
  text-align: center;
  width: 10%;
}

.col-4 {
  width: 15%;
  text-align: center;
}

.col-5 {
  width: 15%;
  text-align: center;
}

.col-6 {
  width: 15%;
  text-align: center;
}
</style>
