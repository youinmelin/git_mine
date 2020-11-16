<template>
  <div class="main">
    <!-- 个人信息 -->
    <el-card v-if="role==='buyer'">
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        个人信息
      </div>
      <el-row class="row">
        <el-col :span="8">
          <div>用户名</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userInfo.userName }}</div>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>用户类型</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">个人用户</div>
        </el-col>
        <!--        <el-col :span="4">-->
        <!--          <el-button type="text">查看</el-button>-->
        <!--        </el-col>-->
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>真实姓名</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userCard.name }} | {{ userCard.cardno }} |
            {{ statusMap[userCard.status] }}
          </div>
        </el-col>
        <!--        <el-col :span="4">-->
        <!--          <el-button type="text">查看</el-button>-->
        <!--        </el-col>-->
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>邮箱</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userInfo.email }}</div>
        </el-col>
        <!--        <el-col :span="4">-->
        <!--          <el-button type="text">修改</el-button>-->
        <!--        </el-col>-->
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>手机</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userInfo.phone }}</div>
        </el-col>
        <!--        <el-col :span="4">-->
        <!--          <el-button type="text">修改 | 解绑</el-button>-->
        <!--        </el-col>-->
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>用户头像</div>
        </el-col>
        <el-col :span="12" class="avatar">
          <img :src="userInfo.headImg">
        </el-col>
        <el-col :span="4">
          <el-button type="text" @click="headDialog = true">修改</el-button>
        </el-col>
      </el-row>
    </el-card>
    <!-- 公司信息 -->
    <el-card v-else>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        公司信息
      </div>
      <el-row class="row">
        <el-col :span="8">
          <div>用户名</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userInfo.name }}</div>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>公司名</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userInfo.companyName }}</div>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>用户类型</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">企业账户</div>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>员工规模</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ companyInfo.staffSize }}</div>
        </el-col>
        <!--        <el-col :span="4">-->
        <!--          <el-button type="text">修改</el-button>-->
        <!--        </el-col>-->
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>业务范畴</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ companyInfo.businessScope }}</div>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>法定代表人</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ companyInfo.name }}</div>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>用户头像</div>
        </el-col>
        <el-col :span="12" class="avatar">
          <img :src="userInfo.headImg">
        </el-col>
        <el-col :span="4">
          <el-button type="text" @click="headDialog = true">修改</el-button>
        </el-col>
      </el-row>

      <el-row class="row bot">
        <el-col :span="8">
          <div>公司简介</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">
            {{ companyInfo.content }}
          </div>
        </el-col>
        <el-col :span="4">
          <el-button type="text" @click="dialogVisible = true">修改</el-button>
        </el-col>
      </el-row>
    </el-card>
    <!-- 公司简介 -->
    <el-dialog title="公司简介" :visible.sync="dialogVisible">
      <el-form>
        <el-form-item label="公司简介">
          <el-input v-model="tempContent"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="updateContentSubmit">确 定</el-button>
      </div>
    </el-dialog>
    <!-- 头像 -->
    <el-dialog title="头像" :visible.sync="headDialog">
      <el-upload
        class="avatar-uploader"
        :action="uploadUrl"
        :show-file-list="false"
        :before-upload="beforeImageUpload"
        :on-success="handleImageScucess"
      >
        <img v-if="headImg" :src="headImg" class="avatar-s">
        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button @click="headDialog = false">取 消</el-button>
        <el-button type="primary" @click="updateHeadImgSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import { getInfo } from '@/api/login'
import { getCompanyInfo, updateCompanyContent, updateHeadImg } from '@/api/user'

export default {
  data() {
    return {
      uploadUrl: process.env.VUE_APP_BASE_API + '/web/upload/oss/head',
      dialogVisible: false,
      headDialog: false,
      role: '',
      headImg: '',
      userInfo: {
        name: '',
        phone: '',
        email: '',
        headImg: ''
      },
      userCard: {},
      tempContent: '',
      companyInfo: {
        staffSize: '',
        businessScope: '',
        name: '',
        content: ''
      },
      statusMap: {
        0: '审核中',
        1: '已认证',
        2: '认证失败'
      }
    }
  },
  created() {
    this.role = localStorage.role
    this.getInfo()
    // 最好是合并到一起
    this.getCompanyInfo()
  },
  methods: {
    getInfo() {
      // 由于是已经登录的，直接获取用户信息，拿不到就提示，然后退出
      // 判断是否登录过
      if (localStorage.token) {
        // 有token的情况下去调用getInfo方法
        getInfo().then(response => {
          if (response.data.code === 0) {
            this.userInfo = response.data.data
            this.userCard = response.data.data.userCard
          } else {
            this.$alert('当前登录信息已失效，请重新登录', '错误', {
              confirmButtonText: '确定',
              type: 'warning',
              callback: action => {
                this.$router.push('/login')
                return false
              }
            })
            return false
          }
        })
      } else {
        this.$alert('当前登录信息已失效，请重新登录', '错误', {
          confirmButtonText: '确定',
          type: 'warning',
          callback: action => {
            this.$router.push('/login')
            return false
          }
        })
        return false
      }
    },
    // 获取企业信息
    getCompanyInfo() {
      getCompanyInfo().then(response => {
        if (response.data.code === 0) {
          this.companyInfo = response.data.data
        } else {
          this.$alert('当前登录信息已失效，请重新登录', '错误', {
            confirmButtonText: '确定',
            type: 'warning',
            callback: action => {
              this.$router.push('/login')
              return false
            }
          })
          return false
        }
      })
    },
    // 修改公司简介
    updateContentSubmit() {
      this.companyInfo.content = this.tempContent
      updateCompanyContent(this.companyInfo).then(response => {
        if (response.data.code === 0) {
          this.$alert('修改成功', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.dialogVisible = false
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
    },
    // 修改头像
    updateHeadImgSubmit() {
      this.userInfo.headImg = this.headImg
      updateHeadImg(this.userInfo).then(response => {
        if (response.data.code === 0) {
          this.$alert('修改成功', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.headDialog = false
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
        this.headImg = res.data.src
        this.imageLoading = false
      }
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

  .row {
    line-height: 100px;
    display: flex;
    align-items: center;
  }

  .avatar {
    display: flex;
    align-items: center;

    img {
      width: 80px;
      height: 80px;
      border-radius: 100px;
    }
  }

  .grey {
    padding: 0 10px;
    color: #888;
    line-height: 1.5;
  }

  .bot {
    display: flex;
    align-items: baseline;
  }
}
</style>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar-s {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
