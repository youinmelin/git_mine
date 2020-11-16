<template>
  <div class="header-main">
    <div class="header">
      <span v-show="!showSearchFlag" class="logo2 curpp" @click="$router.push('/')">欢 迎 来 到 TOP 帮</span>
      <img v-show="showSearchFlag" class="logo" src="./../assets/logo.png" @click="$router.push('/')"/>
      <img v-show="showSearchFlag" class="logo2" src="./../assets/icons/logo2.png" @click="$router.push('/')"/>
      <el-input
        v-show="showSearchFlag"
        v-model="strSearch"
        @keydown.enter.native="btnSearch"
        placeholder="输入关键词进行搜索"
        class="top-input">
        <i slot="prefix" class="el-input__icon el-icon-search"></i>
      </el-input>
      <div class="right" v-if="loginMenu">
        <span class="item" @click="$router.push('/login')">登录</span>
        <span class="item" @click="$router.push('/authentication')">免费注册</span>
      </div>
      <div class="right" v-else>
        <span class="item">{{ topText }}</span>
        <span class="item" @click="jumpToHome()">会员中心</span>
        <span class="item" @click="logout()">退出登录</span>
      </div>
    </div>
  </div>
</template>

<script>
import { getInfo, logout } from '@/api/login'

export default {
  props: {
    showSearch: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      search: '',
      loginMenu: true,
      showSearchFlag: false,
      topText: '',
      role: '',
      strSearch: ''
    }
  },
  mounted() {
    // 判断当前路由
    if (this.$route.path !== '/') {
      this.showSearchFlag = true
    }
    window.addEventListener('scroll', this.handleScroll)
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.handleScroll)
  },
  created() {
    // 判断是否登录过
    if (localStorage.token) {
      // 有token的情况下去调用getInfo方法
      getInfo().then(response => {
        if (response.data.code === 0) {
          this.loginMenu = false
          this.topText = '您好，' + response.data.data.name
          this.role = response.data.data.type // 这里应该是role
          // 设置到存储中
          window.localStorage['userType'] = (response.data.data.type === 1 ? 'seller' : 'buyer')
        } else {
          // 拿不到或者报错，不要执行任何操作。这里应该登录获取一次之后保存在本地为最好，避免频繁调用
          return false
        }
      })
    }
  },
  methods: {
    showLogin() {
      this.loginMenu = !this.loginMenu
    },
    handleScroll() {
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop
      if (this.showSearch && scrollTop > this.showSearch) {
        this.showSearchFlag = true
      } else {
        this.showSearchFlag = false
      }
    },
    // 搜索
    btnSearch() {
      this.$router.push({ path: '/Search', query: { strSearch: this.strSearch } })
    },
    // 退出登录
    logout() {
      logout().then(response => {
        if (response.data.code === 0) {
          // 删除本地的token信息
          window.localStorage.removeItem('token')
          // 跳转回首页
          this.$router.push('/')
        } else {
          this.$alert(response.data.msg, '错误', {
            confirmButtonText: '确定',
            type: 'warning',
            callback: action => {
              return false
            }
          })
          return false
        }
      })
    },
    // 判断身份跳转到对应的页面（正常来说应该是在内页判断身份，但是这里做了两个页面）
    jumpToHome() {
      if (this.role === 0) {
        this.$router.push('/memberCenter/buyerHome')
      } else {
        this.$router.push('/memberCenter/sellerHome')
      }
    }
  }
}
</script>

<style lang="scss">
.top-input {
  position: absolute;
  top: 50%;
  left: 250px;
  transform: translateY(-50%);

  .el-input__inner {
    border-radius: 18px;
    width: 500px;
    height: 36px;
  }
}
</style>
<style lang="scss" scoped>
.header-main {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 54px;
  background: #ffffff;
  z-index: 4;
  overflow-x: auto;

  .header {
    position: relative;
    width: 1200px;
    height: 54px;
    margin: 0 auto;
  }

  .logo {
    position: absolute;
    width: 58px;
    height: 58px;
    left: 0;
    top: 0;
  }

  .logo2 {
    position: absolute;
    left: 74px;
    top: 22px;
  }
}

.el-icon-search {
  color: #CD4D42;
}

.right {
  position: absolute;
  right: 0;
  height: 100%;
  top: 50%;
  transform: translateY(-50%);

  .item {
    position: relative;
    display: inline-block;
    color: #666666;
    font-size: 16px;
    cursor: pointer;
    line-height: 54px;
    margin-left: 20px;

    &:hover {
      color: #CC141D;
    }

    .icon-1 {
      width: 33px;
      height: 33px;
      vertical-align: middle;
    }
  }
}
</style>
