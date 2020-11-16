<template>
  <div class="app">
    <Header/>
    <div class="container">
      <div class="card">
        <div class="main">
          <div class="header">
            <div class="title">
              <img src="@/assets/icons/auth.png" alt="">
              <span>找回密码</span>
            </div>
          </div>
          <div class="form">
            <el-form ref="form" :model="form" label-width="320px">
              <el-form-item label="手机号码" :rules="[{ required: true}]">
                <el-input placeholder="请输入手机号码" v-model="formList.phone" class="input"/>
              </el-form-item>
              <el-form-item label="手机验证码" :rules="[{ required: true}]">
                <el-input placeholder="请输入手机验证码" v-model="formList.smsVeryCode" style="width:150px"/>
                <el-button plain type="danger" class="btn" :loading="loading" @click="sendForgetPhoneCode();">发送验证码
                </el-button>
              </el-form-item>

              <el-form-item label="登录密码" :rules="[{ required: true}]">
                <el-input
                  placeholder="请设置登录密码"
                  v-model="formList.passwd"
                  class="input"
                  minlength="6"
                  maxlength="18"
                  show-password/>
              </el-form-item>

              <el-form-item label="确认密码" :rules="[{ required: true}]">
                <el-input
                  placeholder="请再次输入登录密码"
                  v-model="formList.confirmPasswd"
                  class="input"
                  minlength="6"
                  maxlength="18"
                  show-password/>
              </el-form-item>
            </el-form>
            <div class="bot">
              <el-button class="btn" type="danger" :loading="loading" @click="submitForm">提交</el-button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { forgetPasswd, sendForgetPhoneCode } from '@/api/login'

export default {
  data() {
    return {
      loading: false,
      form: {},
      formList: {}
    }
  },
  methods: {
    submitForm() {
      forgetPasswd(this.formList).then(response => {
        if (response.data.code === 0) {
          this.$alert('密码找回成功，立即登录', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.$router.push('/login')
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
    sendForgetPhoneCode() {
      this.loading = true
      // 判断手机号
      if (!this.formList.phone) {
        this.$alert('请输入手机号', '错误', {
          confirmButtonText: '确定',
          callback: action => {
            this.loading = false
          }
        })
        return false
      } else {
        // 发送手机验证码
        sendForgetPhoneCode(this.formList.phone).then(response => {
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
    }
  }
}
</script>

<style lang="scss" scoped>
.app {
  background: #f0f0f0;
  width: 100%;
  height: 100%;
  overflow-y: scroll;

  .container {
    width: 100%;
    height: 100%;
    margin: 80px 0 90px 0;
    padding: 20px;
    position: relative;

    .steps {
      width: 600px;
      height: 100px;
      position: absolute;
      top: -70px;
      left: calc(50% - 200px);
    }
  }
}

.card {
  width: 800px;
  background: #fff;
  margin: 0 auto;

  .bot {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 10px 0 30px 0;

    .btn {
      width: 150px;
    }
  }

  .step {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
}

.el-icon-success {
  color: #67c23a;
  font-size: 50px;
  margin: 30px 0;
}

.checkbox {
  display: flex;
  justify-content: center;
}

.blue {
  color: #409eff;
}

.dialog {
  p {
    margin: 5px 0;
    line-height: 1.5;
  }

  .dialog-footer {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
}
</style>
<style>
.is-wait .el-step__icon.is-text,
.is-process .el-step__icon.is-text {
  border: 2px solid #ccc;
  background: #ccc;
  color: #999999;
}

.is-success .el-step__icon.is-text {
  background: #ffc2bc;
}

.el-step__head.is-success {
  border-color: #ffc2bc !important;
  color: #c34840;
}
</style>
<style lang="scss" scoped>
.header {
  line-height: 70px;
  display: flex;
  justify-content: center;
  margin-bottom: 50px;

  .title {
    font-size: 26px;
    font-weight: bold;
    display: flex;
    align-items: center;
    border-bottom: 4px solid #c34840;

    img {
      margin-right: 10px;
    }
  }
}

.input {
  width: 300px;
}

.btn {
  margin: 0 10px;
}

.tip {
  .blue {
    color: #409eff;
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
</style>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.el-checkbox__input {
  vertical-align: super;
}
</style>
