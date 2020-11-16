<template>
  <div class="main">
    <Header/>
    <div class="box">
      <div class="top">
        <div class="title">用户登录</div>
        <el-input v-model="formList.name" placeholder="用户名/注册邮箱/注册手机登录" class="input">
          <i slot="prefix" class="el-icon-user"/>
        </el-input>
        <el-input v-model="formList.passwd" placeholder="密码" class="input" type="password">
          <i slot="prefix" class="el-icon-lock"/>
        </el-input>
        <div type="text" class="blue tip curpp" @click="$router.push('/forgetPasswd')">忘记密码</div>
        <el-button class="btn" :loading="loading" @click="submitForm();">登录</el-button>
        <div type="text" class="blue assign curpp" @click="$router.push('/authentication')">立即注册</div>
      </div>
      <div class="bot">
        <div class="item">
          <svg-icon icon-class="WX" class="icon"/>
          <span>微信</span>
        </div>
        <div class="item">
          <svg-icon icon-class="QQ" class="icon"/>
          <span>QQ</span>
        </div>
        <div class="item">
          <svg-icon icon-class="WB" class="icon"/>
          <span>微博</span>
        </div>
      </div>
    </div>
    <div class="footer">
      <p class="big">Topb100.com</p>
      <p>TOP帮Copyright ©2020 北京TOP帮有限公司版权所有</p>
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header'
import { login } from '@/api/login'

export default {
  components: {
    Header
  },
  data() {
    return {
      loading: false,
      formList: {
        name: '',
        passwd: ''
      }
    }
  },
  methods: {
    submitForm() {
      this.loading = true
      login(this.formList.name, this.formList.passwd).then(response => {
        if (response.data.code === 0) {
          this.$message({
            message: '登录成功',
            type: 'success'
          })
          window.localStorage['token'] = response.data.data.token
          // 判断身份跳转到会员中心首页
          if (response.data.data.type === 1) {
            window.localStorage['userType'] = 'seller'
            this.$router.push({ path: '/memberCenter/sellerHome' })
          } else {
            window.localStorage['userType'] = 'buyer'
            this.$router.push({ path: '/memberCenter/buyerHome' })
          }
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
  min-width: 1200px;
  height: 100vh;
  background-image: url(../assets/pics/login.png);
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
}

.box {
  max-width: 420px;
  height: 410px;
  background: #fff;
  border: 10px solid rgba($color: #000000, $alpha: 0.1);
  position: absolute;
  right: 10%;
  top: 20%;
  padding: 40px 40px 0 40px;

  .title {
    font-weight: 600;
  }

  .input {
    margin-top: 24px;
  }

  .blue {
    margin: 5px 0 30px 0;
    font-size: 12px;
    color: #388ced;
  }

  .tip {
    text-align: right;
  }

  .assign {
    text-align: center;
  }

  .btn {
    width: 320px;
    background: #c34840;
    color: #fff;
    text-align: center;
  }
}

.bot {
  display: flex;
  align-items: center;
  justify-content: center;
  border-top: 1px solid #f0f0f0;
  padding-top: 16px;

  .icon {
    font-size: 24px;
    margin-right: 8px;
  }

  .item {
    margin: 0 20px;
    display: flex;
    align-items: center;
    color: #666;
  }
}

.footer {
  width: 100%;
  text-align: center;
  position: fixed;
  bottom: 10%;
  color: #666666;

  .big {
    font-size: 17px;
  }
}
</style>
<style>
.el-input__prefix,
.el-input__suffix {
  top: 10px;
}
</style>
