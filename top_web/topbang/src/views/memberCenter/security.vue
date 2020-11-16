<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        账户安全
      </div>
      <el-row class="row">
        <el-col :span="8">
          <div>安全等级</div>
        </el-col>
        <el-col :span="12">
          <el-progress :stroke-width="12" :percentage="100" :format="format" color="#67C23A"/>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>登录密码</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">登录账户时需要输入的密码</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text" @click="resetPassword()">重置</el-button>
        </el-col>
      </el-row>

      <!--      <el-row class="row">-->
      <!--        <el-col :span="8">-->
      <!--          <div>支付密码</div>-->
      <!--        </el-col>-->
      <!--        <el-col :span="12">-->
      <!--          <div class="grey">支付所购买商品或服务时使用</div>-->
      <!--        </el-col>-->
      <!--        <el-col :span="4">-->
      <!--          <el-button type="text" @click="handleDialog(null)">重置</el-button>-->
      <!--        </el-col>-->
      <!--      </el-row>-->

      <el-row class="row">
        <el-col :span="8">
          <div>实名认证</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userCard.name }} | {{ userCard.cardno }} |
            {{ statusMap[userCard.status] }}
          </div>
        </el-col>
        <el-col :span="4">
          <el-button type="text" v-if="userInfo.type = 0" @click="realNameDialogVisible=true">查看</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>邮箱</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userInfo.email }}</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text" @click="updateEmailDialogVisible=true">修改</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>手机</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">{{ userInfo.phone }}</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text" @click="updatePhoneDialogVisible=true">修改</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>登录记录</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">上次登录网站时间：{{ securityInfo.lastLogin }}</div>
        </el-col>
      </el-row>
    </el-card>
    <el-dialog :title="form.name" :visible.sync="dialogVisible">
      <el-form>
        <el-form-item :label="form.label">
          <el-input v-model="form.text"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </div>
    </el-dialog>
    <!-- 修改密码 -->
    <el-dialog title="修改密码" :visible.sync="resetPasswdDialogVisible">
      <el-form>
        <el-form-item label="原密码">
          <el-input v-model="resetPasswordForm.oldPasswd"/>
        </el-form-item>
        <el-form-item label="新密码">
          <el-input v-model="resetPasswordForm.passwd"/>
        </el-form-item>
        <el-form-item label="确认密码">
          <el-input v-model="resetPasswordForm.confirmPasswd"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="resetPasswdDialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="loading" @click="resetPasswordSubmit">确 定</el-button>
      </div>
    </el-dialog>
    <!-- 实名认证 -->
    <el-dialog title="实名认证" :visible.sync="realNameDialogVisible">
      <el-form>
        <el-form-item label="真实姓名" :rules="[{ required: true}]">
          <el-input placeholder="请填写真实姓名" v-model="userCard.name" class="input"/>
        </el-form-item>
        <el-form-item label="证件号码" :rules="[{ required: true}]">
          <el-input placeholder="请填写证件上的号码" v-model="userCard.cardno" class="input"/>
        </el-form-item>
        <el-form-item label="证件期限" :rules="[{ required: true}]">
          <el-date-picker
            v-model="startTime"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            class="input"
          />
        </el-form-item>
        <el-form-item label="上传证件照" :rules="[{ required: true}]">
          <el-row>
            <el-upload
              class="avatar-uploader"
              :action="uploadUrl"
              :show-file-list="false"
              list-type="picture"
              :with-credentials="true"
              :before-upload="beforeImageUpload"
              :on-success="handleImageScucess"
            >
              <img v-if="userCard.imageUrl" :src="userCard.imageUrl" class="avatar">
              <i v-else class="el-icon-picture-outline avatar-uploader-icon"/>
            </el-upload>
            <el-upload
              class="avatar-uploader"
              :action="uploadUrl"
              :show-file-list="false"
              list-type="picture"
              :with-credentials="true"
              :before-upload="beforeImageUpload"
              :on-success="handleImageScucess2"
            >
              <img v-if="userCard.imageUrl2" :src="userCard.imageUrl2" class="avatar">
              <i v-else class="el-icon-picture-outline avatar-uploader-icon"/>
            </el-upload>
          </el-row>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="realNameDialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="loading" @click="realNameSubmit">确 定</el-button>
      </div>
    </el-dialog>
    <!-- 修改邮箱 -->
    <el-dialog title="修改邮箱" :visible.sync="updateEmailDialogVisible">
      <el-form>
        <el-form-item label="新邮箱">
          <el-input v-model="updateEmailForm.email"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="updateEmailDialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="loading" @click="updateEmailSubmit">确 定</el-button>
      </div>
    </el-dialog>
    <!-- 修改手机 -->
    <el-dialog title="修改密码" :visible.sync="updatePhoneDialogVisible">
      <el-form>
        <el-form-item label="手机号码" :rules="[{ required: true}]">
          <el-input placeholder="请输入手机号码" v-model="userInfo.phone" class="input"/>
        </el-form-item>
        <el-form-item label="手机验证码" :rules="[{ required: true}]">
          <el-input placeholder="请输入手机验证码" v-model="userInfo.phoneCaptcha" style="width:150px"/>
          <el-button plain type="danger" style="margin: 0 10px;" :loading="loading" @click="sendPhoneCode();">发送验证码
          </el-button>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="updatePhoneDialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="loading" @click="updatePhoneSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getSecurity, resetPassword, realName, updateEmail, updatePhone } from '@/api/user'
import { sendPhoneCode } from '@/api/login'

export default {
  data() {
    return {
      uploadUrl: process.env.VUE_APP_BASE_API + '/web/upload/oss/card',
      loading: false,
      dialogVisible: false,
      // 重置密码
      resetPasswdDialogVisible: false,
      // 实名认证
      realNameDialogVisible: false,
      // 修改邮箱
      updateEmailDialogVisible: false,
      // 修改手机
      updatePhoneDialogVisible: false,
      form: {
        name: '修改',
        label: '',
        text: ''
      },
      // 修改密码
      resetPasswordForm: {
        oldPasswd: '',
        passwd: '',
        confirmPasswd: ''
      },
      // 修改邮箱
      updateEmailForm: {
        email: ''
      },
      securityInfo: {
        lastLogin: ''
      },
      userInfo: {},
      userCard: {},
      statusMap: {
        0: '审核中',
        1: '已认证',
        2: '认证失败'
      },
      startTime: ''
    }
  },
  created() {
    this.getSecurity()
  },
  methods: {
    format(percentage) {
      return percentage === 100 ? '高' : `${percentage}%`
    },
    handleDialog(item) {
      // this.form = item
      this.dialogVisible = true
    },
    // 获取安全信息
    getSecurity() {
      getSecurity().then(response => {
        if (response.data.code === 0) {
          this.securityInfo = response.data.data
          this.userInfo = response.data.data.userInfo
          this.userCard = response.data.data.userCard
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
    // 重置密码
    resetPassword() {
      this.resetPasswdDialogVisible = true
    },
    resetPasswordSubmit() {
      resetPassword(this.resetPasswordForm).then(response => {
        if (response.data.code === 0) {
          this.$alert('修改成功，即将跳转到登录页', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              // 清理掉token信息
              window.localStorage.removeItem('token')
              this.loading = false
              this.resetPasswdDialogVisible = false
              // 这里直接跳转，防止出错
              this.$router.push('/Login')
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
    // 修改实名认证
    realNameSubmit() {
      if (this.startTime === null || this.startTime === '') {
        this.$message.info('证件期限不能为空')
        return false
      }
      // 时间参数要处理一下
      this.userCard.validStart = this.startTime[0]
      this.userCard.validEnd = this.startTime[1]
      realName(this.userCard).then(response => {
        if (response.data.code === 0) {
          this.$alert('修改成功，请等待审核', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.realNameDialogVisible = false
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
    // 修改邮箱
    updateEmailSubmit() {
      if (this.updateEmailForm.email === null || this.updateEmailForm.email === '') {
        this.$message.info('邮箱不能为空')
        return false
      }
      updateEmail(this.updateEmailForm).then(response => {
        if (response.data.code === 0) {
          this.$alert('修改成功', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.updateEmailDialogVisible = false
              this.userInfo.email = this.updateEmailForm.email
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
    // 发送验证码
    sendPhoneCode() {
      this.loading = true
      // 判断手机号
      if (!this.userInfo.phone) {
        this.$alert('请输入手机号', '错误', {
          confirmButtonText: '确定',
          callback: action => {
            this.loading = false
          }
        })
        return false
      } else {
        // 发送手机验证码
        sendPhoneCode(this.userInfo.phone).then(response => {
          if (response.data.code === 0) {
            this.$alert('发送成功', '提示', {
              confirmButtonText: '确定',
              callback: action => {
                this.loading = false
              }
            })
          } else {
            this.$alert(response.data.msg, '错误', {
              confirmButtonText: '确定',
              type: 'warning',
              callback: action => {
                this.loading = false
              }
            })
          }
        })
      }
    },
    // 修改手机号
    updatePhoneSubmit() {
      if (this.userInfo.phone === null || this.userInfo.phone === '') {
        this.$message.info('手机号不能为空')
        return false
      }
      updatePhone(this.userInfo).then(response => {
        if (response.data.code === 0) {
          this.$alert('修改成功', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.updatePhoneDialogVisible = false
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
        this.userCard.imageUrl = res.data.src
        this.imageLoading = false
      }
    },
    handleImageScucess2(res) {
      if (res.code === 0) {
        this.userCard.imageUrl2 = res.data.src
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
    width: 80px;
    height: 80px;
    border-radius: 100px;
  }

  .grey {
    color: #888;
  }
}

.avatar-uploader {
  width: 120px;
  display: inline-block;
  margin-right: 20px;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}

.avatar {
  width: 120px;
  height: 120px;
  display: block;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
</style>
