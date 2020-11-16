<template>
  <div class="nav-bar">
    <div class="nav-side">
      <img class="img" src="../assets/nav/nav-icon7.png"/>
    </div>
    <div class="nav-item" @click="jumpToHome">
      <img class="nav-icon" src="../assets/nav/nav-icon6.png"/>
      个人中心
    </div>
    <div class="nav-item" @click="$router.push('/memberCenter/service')">
      <img class="nav-icon" src="../assets/nav/nav-icon5.png"/>
      人工客服
    </div>
    <div class="nav-item" @click="$router.push('/industryTable')">
      <img class="nav-icon" src="../assets/nav/nav-icon4.png"/>
      网站导航
    </div>
    <div class="nav-item" @click="$router.push('/memberCenter/videoHistory')">
      <img class="nav-icon" src="../assets/nav/nav-icon3.png"/>
      历史足迹
    </div>
    <div class="nav-item last-item">
      <img class="nav-icon" src="../assets/nav/nav-icon2.png"/>
      回到顶部
    </div>
    <div class="nav-side" @click="backTop">
      <img class="img" src="../assets/nav/nav-icon1.png"/>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    jumpToHome() {
      if (this.type === undefined) {
        this.$router.push('/login')
      } else if (this.type === 0) {
        this.$router.push('/memberCenter/buyerHome')
      } else {
        this.$router.push('/memberCenter/sellerHome')
      }
    },
    // 点击图片回到顶部方法，加计时器是为了过渡顺滑
    backTop() {
      const that = this
      const timer = setInterval(() => {
        const ispeed = Math.floor(-that.scrollTop / 5)
        document.documentElement.scrollTop = document.body.scrollTop = that.scrollTop + ispeed
        if (that.scrollTop === 0) {
          clearInterval(timer)
        }
      }, 16)
    }
  }
}
</script>

<style lang="scss" scoped>
div {
  cursor: pointer;
}

.nav-bar {
  position: fixed;
  right: 16%;
  bottom: 50px;
  width: 84px;
  background: #ffffff;
  z-index: 3;

  .nav-item {
    font-size: 16px;
    color: #666666;
    width: 100%;
    text-align: center;
    padding-top: 15px;

    .nav-icon {
      display: block;
      margin: 0 auto;
      margin-bottom: 10px;
    }

    &:not(.last-item):after {
      display: block;
      content: '';
      width: 40px;
      height: 1px;
      background: #eeeeee;
      margin: 10px auto;
    }
  }

  .nav-side {
    position: relative;
    width: 100%;
    height: 39px;

    .img {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
  }
}

@media screen and (min-width: 1399px) {
  .nav-bar {
    right: 10px;
  }
}
</style>
