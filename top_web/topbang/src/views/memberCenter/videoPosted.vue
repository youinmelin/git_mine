<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        已发布的视频
      </div>
      <!-- 筛选区域 -->
      <el-row class="header">
        <el-col :span="14">
          <el-tabs v-model="activeName" @tab-click="handleClick">
            <el-tab-pane label="全部视频" name="-1"/>
            <el-tab-pane name="0">
              <span slot="label">
                审核中<sup class="badge" v-if="countList.status0>0">{{ countList.status0 }}</sup>
              </span>
            </el-tab-pane>
            <el-tab-pane name="1">
              <span slot="label">
                已发布<sup class="badge" v-if="countList.status1>0">{{ countList.status1 }}</sup>
              </span>
            </el-tab-pane>
            <el-tab-pane name="2">
              <span slot="label">
                未发布<sup class="badge" v-if="countList.status2>0">{{ countList.status2 }}</sup>
              </span>
            </el-tab-pane>
          </el-tabs>
        </el-col>
        <el-col :span="8">
          <el-input v-model="listQuery.strSearch" class="input">
            <el-button slot="append" icon="el-icon-search" :loading="loading" @click="search"/>
          </el-input>
        </el-col>
        <el-col :span="2">
          <el-select v-model="value2" placeholder="筛选" class="select">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-col>
      </el-row>

      <div class="label">
        <div class="col-1">视频名称</div>
        <div class="col-2">上传时间</div>
        <div class="col-3">状态</div>
        <div class="col-4">操作</div>
      </div>
      <div class="list">
        <div v-for="(item,index) in list" :key="index" class="cell">
          <div class="top">
            <div>编号：<span>{{ item.id }}</span></div>
          </div>
          <div class="bot">
            <div class="col-1">
              <img :src="item.videoImgUrl" alt="">
              <div>
                <p>{{ item.name }}</p>
                <span v-if="item.status===2||item.status===4" class="num">播放次数 4290</span>
                <span v-if="item.status===2||item.status===4" class="num">试用申请次数 4290</span>
              </div>

            </div>
            <div class="col-2">{{ item.gmtCreate }}</div>
            <div class="col-3">
              <div>{{ statusMap[item.status] }}</div>
              <div class="grey curpp" @click="$router.push({path:'/productMain',query:{id:item.id}})">视频详情</div>
            </div>
            <div class="col-4">
              <el-button v-if="item.status===1" type="text">取消发布</el-button>
              <el-button v-if="item.status===4" type="text">重新发布</el-button>
              <el-button
                v-if="item.status===0||item.status===2"
                type="text"
                @click="$router.push({path:'/memberCenter/videoRelease',query:{id:item.id}})">重新编辑
              </el-button>
              <el-button v-if="item.status===2" type="text">下架视频</el-button>
              <el-button type="text" @click="deleteVideo(item.id)">删除视频</el-button>
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
import { deleteProduct, getProductList } from '@/api/product'

export default {
  data() {
    return {
      loading: false,
      value1: '',
      value2: '',
      options: [],
      list: [],
      statusMap: {
        1: '审核中',
        2: '已发布',
        3: '审核失败',
        4: '已下架'
      },
      activeName: '-1',
      page: {
        currentPage: 1,
        total: 0
      },
      listQuery: {
        page: 1,
        limit: 10,
        status: '',
        strSearch: ''
      },
      countList: {
        status0: 0,
        status1: 0,
        status2: 0
      }
    }
  },
  created() {
    // 初始化加载列表
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
    // 搜索
    search() {
      this.loading = true
      this.fetchData()
    },
    deleteVideo(prodId) {
      this.$confirm('此操作将永久删除该产品, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteProduct(prodId).then(response => {
          if (response.data.code === 0) {
            this.fetchData()
            this.$message({
              type: 'success',
              message: '删除成功!'
            })
          } else {
            this.$alert(response.data.msg, '错误', {
              confirmButtonText: '确定',
              type: 'warning',
              callback: action => {
                this.loading = false
                return false
              }
            })
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    fetchData() {
      // 获取产品列表
      getProductList(this.listQuery).then(response => {
        if (response.data.code === 0) {
          this.list = response.data.data.list
          this.page.total = response.data.data.total
          this.countList.status0 = response.data.data.status0
          this.countList.status1 = response.data.data.status1
          this.countList.status2 = response.data.data.status2
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

  .grey {
    font-size: 15px;
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

.header {
  .right {
    .input {
      float: right;
      width: 200px;
    }

    .select {
      float: right;
      width: 80px;
    }
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
  .col-1 {
    display: flex;
    align-items: center;
  }

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
      width: 80px;
      height: 80px;
      object-fit: cover;
      margin-right: 10px;
    }

    .num {
      font-size: 12px;
      color: #999;
      margin-right: 20px;
    }
  }
}

.col-1 {
  width: 35%;

  .select {
    width: 150px;
  }
}

.col-2 {
  text-align: center;
  width: 30%;
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
