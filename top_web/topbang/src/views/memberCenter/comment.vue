<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        我的评价
      </div>
      <!-- 筛选区域 -->
      <el-row class="header">
        <el-tabs v-model="activeName" @tab-click="handleClick">
          <el-tab-pane name="0">
            <span slot="label">
              待评价<sup class="badge" v-if="countList.status0>0">{{ countList.status0 }}</sup>
            </span>
          </el-tab-pane>
          <el-tab-pane name="3">
            <span slot="label">
              已评价<sup class="badge" v-if="countList.status3>0">{{ countList.status3 }}</sup>
            </span>
          </el-tab-pane>
        </el-tabs>
      </el-row>
      <div class="label">
        <div class="col-1">项目详情</div>
        <div class="col-2">项目企业</div>
        <div class="col-4">操作</div>
      </div>
      <div class="list">
        <div v-for="(item,index) in list" :key="index" class="cell">
          <div class="top">
            <div>{{ item.gmtCreate }}</div>
            <div>单号：<span>{{ item.id }}</span></div>
          </div>
          <div class="bot">
            <div class="col-1">
              <img :src="item.src" alt="">
              <p>{{ item.productName }}</p>
            </div>
            <div class="col-2" @click="$router.push({path:'/companyInfo',query:{id:item.companyId}})">
              {{ item.companyName }}
            </div>
            <div class="col-3">
              <el-button type="primary" v-if="item.status = 0 " size="mini" plain>评价</el-button>
              <div class="grey curpp" @click="$router.push({path:'/productMain',query:{id:item.productId}})">项目详情</div>
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
import { getProductEvaluateList } from '@/api/product'

export default {
  data() {
    return {
      active: '0',
      value1: '',
      value2: '',
      options: [],
      list: [],
      statusMap: {
        1: '试用中',
        2: '待评价',
        3: '已试用',
        4: '申请中'
      },
      activeName: '-1',
      page: {
        currentPage: 1,
        total: 0
      },
      listQuery: {
        page: 1,
        limit: 10,
        status: 0,
        strSearch: ''
      },
      countList: {
        status0: 0,
        status3: 0
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    handleClick() {
      if (this.activeName !== '-1') {
        this.listQuery.status = this.activeName
        this.fetchData()
      } else {
        this.listQuery.status = null
        this.fetchData()
      }
    },
    // 评价列表
    fetchData() {
      getProductEvaluateList(this.listQuery).then(response => {
        if (response.data.code === 0) {
          // 产品详情
          this.list = response.data.data.list
          this.page.total = response.data.data.total
          this.countList.status0 = response.data.data.status0
          this.countList.status3 = response.data.data.status3
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

  .badge {
    background: crimson;
    color: #fff;
    padding: 0 4px;
    border-radius: 20px;
  }
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

    .col-1 {
      display: flex;
      align-items: center;
    }
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
      width: 80px;
      height: 80px;
      object-fit: cover;
      margin-right: 10px;
    }
  }
}

.col-1 {
  width: 45%;

  .select {
    width: 150px;
  }
}

.col-2 {
  text-align: center;
  width: 35%;
}

.col-3 {
  text-align: center;
  width: 20%;
}

.col-4 {
  width: 10%;
  text-align: right;
}

::v-deep {
  .el-input__inner {
    background: none;

    &::placeholder {
      color: #000;
      text-align: right;
    }
  }
}
</style>
