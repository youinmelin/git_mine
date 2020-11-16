<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        {{ role === 'seller' ? '产品试用管理' : '我的试用' }}
      </div>
      <!-- 筛选区域 -->
      <el-row class="header">
        <el-col :span="14">
          <el-tabs v-model="activeName" @tab-click="handleClick">
            <el-tab-pane label="全部试用" name="-1"/>
            <el-tab-pane name="0">
              <span slot="label">
                申请中<sup class="badge" v-if="countList.status0>0">{{ countList.status0 }}</sup>
              </span>
            </el-tab-pane>
            <el-tab-pane name="1">
              <span slot="label">
                待评价<sup class="badge" v-if="countList.status1>0">{{ countList.status1 }}</sup>
              </span>
            </el-tab-pane>
            <el-tab-pane name="3">
              <span slot="label">
                已评价<sup class="badge" v-if="countList.status3>0">{{ countList.status3 }}</sup>
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
        <div class="col-1">
          <el-select v-model="value2" placeholder="近三个月的试用" class="select">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
          {{ role === 'seller' ? '申请项目' : '项目详情' }}
        </div>
        <div class="col-2">{{ role === 'seller' ? '申请账号' : '项目企业' }}</div>
        <div class="col-3">状态</div>
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
              <img :src="item.videoImgUrl" alt="">
              <p>{{ item.name }}</p>
            </div>
            <div class="col-2">{{ item.userName }}</div>
            <div class="col-3">
              <div>{{ statusMap[item.status] }}</div>
            </div>
            <div class="col-4">
              <el-button v-if="item.status===0" type="text" :loading="loading" @click="auditProductTrial(item.id,1)">
                同意
              </el-button>
              <el-button v-if="item.status===0" type="text" :loading="loading" @click="auditProductTrial(item.id,2)">
                拒绝
              </el-button>
              <el-button v-if="item.status===1" type="text" :loading="loading" @click="evaluate(item)">
                立即评价
              </el-button>
              <el-button v-if="item.status===3" type="text">查看评价</el-button>
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
    <!-- 弹框 -->
    <el-dialog :title="form.name" :visible.sync="dialogVisible">
      <el-form>
        <el-form-item label="评分">
          <el-rate
            v-model="formList.score"
            :colors="colors">
          </el-rate>
        </el-form-item>
        <el-form-item label="评价内容">
          <el-input
            type="textarea"
            :autosize="{ minRows: 4, maxRows: 8}"
            placeholder="请输入内容"
            v-model="formList.content">
          </el-input>
        </el-form-item>
        <el-form-item label="图片上传">
          <el-upload
            class="upload-demo"
            :action="uploadUrl"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :on-change="handleChange"
            :file-list="fileList"
            list-type="picture-card"
            :limit="3"
          >
            <i slot="default" class="el-icon-plus"></i>
          </el-upload>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="loading" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog :visible.sync="imgDialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="">
    </el-dialog>
  </div>
</template>
<script>
import { auditProductTrial, getProductTrialList, productEvaluate } from '@/api/product'

export default {
  data() {
    return {
      uploadUrl: process.env.VUE_APP_BASE_API + '/web/upload/oss/image',
      loading: false,
      imageLoading: false,
      dialogImageUrl: '',
      dialogVisible: false,
      imgDialogVisible: false,
      form: {},
      role: '',
      value1: '',
      value2: '',
      options: [],
      list: [],
      fileList: [],
      formList: {
        videoList: [],
        productId: 0,
        trialId: 0,
        score: 0,
        content: ''
      },
      colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
      statusMap: {
        0: '申请中',
        1: '已同意，待评价',
        2: '已拒绝',
        3: '已评价'
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
        status3: 0
      }
    }
  },
  created() {
    this.role = localStorage.role
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
    // 获取试用列表
    fetchData() {
      getProductTrialList(this.listQuery).then(response => {
        if (response.data.code === 0) {
          this.list = response.data.data.list
          this.page.total = response.data.data.total
          this.countList.status0 = response.data.data.status0
          this.countList.status1 = response.data.data.status1
          this.countList.status3 = response.data.data.status3
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
    },
    handleRemove(file, fileList) {
      console.log(file, fileList)
    },
    // 好像是放大
    handlePreview(file) {
      this.dialogImageUrl = file.url
      this.imgDialogVisible = true
    },
    handleChange(file, fileList) {
      this.fileList = fileList
      // 每次更新都要初始化，防止报错
      this.formList.videoList = []
      // 这里传到后端没法直接用，所以要用另一个参数来代替
      for (let i = 0; i < this.fileList.length; i++) {
        if (this.fileList[i].response !== undefined) {
          this.formList.videoList.push(this.fileList[i].response.data.src)
        }
      }
    },
    // 文件上传
    beforeImageUpload(file) {
      this.imageLoading = true
      const isLt2M = file.size / 1024 / 1024 < 2

      if (!isLt2M) {
        this.$message.error('上传图片大小不能超过 2MB!')
      }
      return isLt2M
    },
    handleImageScucess(res) {
      if (res.code === 0) {
        this.formList.videoImgUrl = res.data.src
        this.imageLoading = false
      }
    },
    // 产品试用审核
    auditProductTrial(id, status) {
      this.$confirm('确定' + (status === 1 ? '通过' : '拒绝') + '该产品试用?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        auditProductTrial(id, status).then(response => {
          if (response.data.code === 0) {
            // 不用刷新全部
            this.fetchData()
            this.$message({
              type: 'success',
              message: '审核成功!'
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
          message: '已取消审核'
        })
      })
    },
    // 评价
    evaluate(item) {
      // 先赋值几个必须的参数
      this.formList.productId = item.prodId
      this.formList.trialId = item.id
      this.dialogVisible = true
    },
    // 提交评价
    submitForm() {
      this.loading = true
      productEvaluate(this.formList).then(response => {
        if (response.data.code === 0) {
          this.$alert('评价成功', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.loading = false
              this.dialogVisible = false
              // 列表页也要刷新
              this.fetchData()
              return false
            }
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
          return false
        }
      })
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
      width: 80px;
      height: 80px;
      object-fit: cover;
      margin-right: 10px;
    }
  }
}

.col-1 {
  width: 35%;
  display: flex;
  align-items: center;

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
