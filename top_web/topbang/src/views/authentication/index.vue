<template>
  <div class="app">
    <Header/>
    <div class="container">
      <el-steps class="steps" :space="200" :active="active" finish-status="success">
        <el-step/>
        <el-step/>
        <el-step/>
      </el-steps>
      <div class="card">
        <div v-if="active===0">
          <Register @tabVal="tabVal" ref="reg" @callback="regCall"/>
        </div>
        <div v-else-if="active===1 || active===3" class="step">
          <i class="el-icon-success"/>
          <p>{{ notice }}</p>
        </div>
        <div v-else-if="active===2">
          <PersonalAuth v-if="role==='buyer'" ref="personal" @callback="personalCall"/>
          <BusinessAuth v-else ref="business" @callback="businessCall"/>
        </div>
        <div class="checkbox">
          <el-checkbox v-if="active===0" v-model="checked" label="1">
            <p class="tip">创建网站账号的同时：我同意遵守 <span
              class="blue"
              @click="dialogVisible=true"
            >TOP帮企业认证协议</span>,<br>愿意接收相关来自TOP帮的会员及服务信息。</p>
          </el-checkbox>
        </div>
        <div class="bot">
          <el-button class="btn" type="danger" :loading="loading" @click="next()">{{ btnText }}</el-button>
          <el-button class="btn" type="text" @click="botBtn()">{{ botText }}</el-button>
        </div>
      </div>
    </div>
    <!-- 协议 -->
    <el-dialog title="注册协议" :visible.sync="dialogVisible" width="40%" class="dialog">
      <div v-html="regAgree"/>
      <div class="dialog-footer">
        <el-button type="danger" @click="dialogVisible = false;checked = true">同意协议</el-button>
        <el-button type="text" @click="dialogVisible = false">关闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>

import Header from '@/components/Header'
import PersonalAuth from './PersonalAuth'
import BusinessAuth from './BusinessAuth'
import Register from './Register'
import '@/styles/index.scss'
import { getRegAgree } from '@/api/common'

export default {

  components: {
    Header,
    PersonalAuth,
    BusinessAuth,
    Register
  },
  data() {
    return {
      active: 0,
      value: '',
      role: 'buyer',
      dialogVisible: true,
      loading: false,
      checked: false,
      // 协议内容
      regAgree: ''
    }
  },
  computed: {
    btnText() {
      if (this.active === 0) {
        return '同意并注册'
      } else if (this.active === 1) {
        return this.role === 'buyer' ? '前往实名认证' : '前往企业认证'
      } else if (this.active === 2) {
        return '提交认证'
      } else {
        return '返回会员中心'
      }
    },
    botText() {
      if (this.active > 0 && this.active < 3) {
        return '返回会员中心'
      } else {
        return ''
      }
    },
    notice() {
      if (this.active === 1) {
        return this.role === 'buyer' ? '您的账号已注册成功！进行实名认证享受更多服务。' : '您的账号已注册成功！进行企业认证享受更多服务。'
      } else if (this.active === 3) {
        return this.role === 'buyer' ? '已成功提交实名认证，请耐心等待审核。' : '已成功提交企业认证，请耐心等待审核。'
      } else {
        return ''
      }
    }
  },
  created() {
    this.getRegAgree()
  },
  methods: {
    // 获取注册协议内容
    getRegAgree() {
      getRegAgree().then(response => {
        if (response.data.code === 0) {
          this.regAgree = response.data.data.content
        } else {
          return false
        }
      })
    },
    next() {
      // 提交表单？
      // this.loading = true // 这里不知道为什么，无法取消该状态
      if (this.active === 0) {
        // 这里做一些简单的前端校验
        if (this.checked === false) {
          this.$message.info('请先勾选协议')
          return false
        }
        this.$refs.reg.submitForm()
      } else if (this.active === 1) {
        if (this.active++ > 2) this.active = 0
        return this.role === 'buyer' ? '前往实名认证' : '前往企业认证'
      } else if (this.active === 2) {
        if (this.role === 'buyer') {
          this.$refs.personal.submitForm()
        } else {
          this.$refs.business.submitForm()
        }
      } else if (this.active === 3) {
        this.role === 'buyer' ? this.$router.push({ path: '/memberCenter/buyerHome' }) : this.$router.push({ path: '/memberCenter/sellerHome' })
        // return this.role === 'buyer' ? '已成功提交实名认证，请耐心等待审核。' : '已成功提交企业认证，请耐心等待审核。'
      } else {
        this.$router.push({ path: '/memberCenter/information' })
      }
      // if () {
      //   console.log('执行成功')
      //   if (this.active++ > 2) this.active = 0
      // }
      // register(this.$refs.reg.formList).then(response => {
      //   console.log('fa')
      // })
    },
    botBtn() {
      this.$router.push({ path: '/memberCenter/information' })
    },
    // 接收提交方法的回调
    regCall(data) {
      this.loading = false
      if (data) {
        if (this.active++ > 2) this.active = 0
      }
    },
    // 个人认证回调
    personalCall(data) {
      this.loading = false
      if (data) {
        if (this.active++ > 2) this.active = 0
      }
    },
    // 企业认证回调
    businessCall(data) {
      this.loading = false
      if (data) {
        if (this.active++ > 2) this.active = 0
      }
    },
    tabVal(v) {
      this.role = v ? 'seller' : 'buyer'
    },
    loadingE(v) {
      this.loading = false
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
    margin: 180px 0 90px 0;
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
