<template>
  <div class="app">
    <Header />
    <div class="container">
      <SideBar />
      <!-- 嵌套的子路由 -->
      <router-view></router-view>
    </div>
  </div>
</template>

<script>

import Header from '@/components/Header'
import SideBar from './components/SideBar'
import '@/styles/index.scss'

export default {

  components: {
    Header,
    SideBar
  }
}
</script>

<style lang="scss" scoped>
.app {
  background: #f0f0f0;
  height: 100%;
  overflow: scroll;
  .container {
    display: flex;
    height: 100%;
    justify-content: center;
    margin-top: 90px;
    padding-top: 20px;
  }
}
</style>
