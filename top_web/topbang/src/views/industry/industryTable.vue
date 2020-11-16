<template>
  <div class="industry-table">
    <Header/>
    <div class="main">
      <div class="left">
        <div class="title">行业分类</div>
        <div
          v-for="(item,index) in menuList"
          :key="item.id"
          class="l-item"
          :class="{'active': activeMenu.id === item.id}"
          @click="activeMenu = item">
          <!-- 图标区分 这里是为了避开webpack打包，届时上传到图床组合名字即可 -->
          <!-- start -->
          <img v-if="index+1 === 1" src="../../assets/industry/ad-icon1.png"/>
          <img v-else-if="index+1 === 2" src="../../assets/industry/ad-icon2.png"/>
          <img v-else-if="index+1 === 3" src="../../assets/industry/ad-icon3.png"/>
          <img v-else-if="index+1 === 4" src="../../assets/industry/ad-icon4.png"/>
          <img v-else-if="index+1 === 5" src="../../assets/industry/ad-icon5.png"/>
          <img v-else-if="index+1 === 6" src="../../assets/industry/ad-icon6.png"/>
          <img v-else-if="index+1 === 7" src="../../assets/industry/ad-icon7.png"/>
          <img v-else-if="index+1 === 8" src="../../assets/industry/ad-icon8.png"/>
          <img v-else-if="index+1=== 9" src="../../assets/industry/ad-icon9.png"/>
          <img v-else-if="index+1 === 10" src="../../assets/industry/ad-icon10.png"/>
          <img v-else-if="index+1 === 11" src="../../assets/industry/ad-icon11.png"/>
          <img v-else-if="index+1 === 12" src="../../assets/industry/ad-icon12.png"/>
          <img v-else-if="index+1 === 13" src="../../assets/industry/ad-icon13.png"/>
          <img v-else-if="index+1 === 14" src="../../assets/industry/ad-icon14.png"/>
          <img v-else-if="index+1 === 15" src="../../assets/industry/ad-icon15.png"/>
          <img v-else-if="index+1 === 16" src="../../assets/industry/ad-icon16.png"/>
          <img v-else-if="index+1 === 17" src="../../assets/industry/ad-icon17.png"/>
          <img v-else-if="index+1 === 18" src="../../assets/industry/ad-icon18.png"/>
          <img v-else src="../../assets/industry/ad-icon19.png"/>
          <!-- end -->
          {{ item.name }}
        </div>
      </div>
      <div class="right">
        <el-breadcrumb class="breadcrumb" separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>所有行业</el-breadcrumb-item>
        </el-breadcrumb>
        <div class="r-content" v-if="activeMenu && activeMenu.id">
          <div class="title">
            <!-- 图标区分 这里是为了避开webpack打包，届时上传到图床组合名字即可 -->
            <!-- start -->
            <img v-if="activeMenu.id === '1'" src="../../assets/industry/ad-icon1.png"/>
            <img v-else-if="activeMenu.id === '2'" src="../../assets/industry/ad-icon2.png"/>
            <img v-else-if="activeMenu.id === '3'" src="../../assets/industry/ad-icon3.png"/>
            <img v-else-if="activeMenu.id === '4'" src="../../assets/industry/ad-icon4.png"/>
            <img v-else-if="activeMenu.id === '5'" src="../../assets/industry/ad-icon5.png"/>
            <img v-else-if="activeMenu.id === '6'" src="../../assets/industry/ad-icon6.png"/>
            <img v-else-if="activeMenu.id === '7'" src="../../assets/industry/ad-icon7.png"/>
            <img v-else-if="activeMenu.id === '8'" src="../../assets/industry/ad-icon8.png"/>
            <img v-else-if="activeMenu.id === '9'" src="../../assets/industry/ad-icon9.png"/>
            <img v-else-if="activeMenu.id === '10'" src="../../assets/industry/ad-icon10.png"/>
            <img v-else-if="activeMenu.id === '11'" src="../../assets/industry/ad-icon11.png"/>
            <img v-else-if="activeMenu.id === '12'" src="../../assets/industry/ad-icon12.png"/>
            <img v-else-if="activeMenu.id === '13'" src="../../assets/industry/ad-icon13.png"/>
            <img v-else-if="activeMenu.id === '14'" src="../../assets/industry/ad-icon14.png"/>
            <img v-else-if="activeMenu.id === '15'" src="../../assets/industry/ad-icon15.png"/>
            <img v-else-if="activeMenu.id === '16'" src="../../assets/industry/ad-icon16.png"/>
            <img v-else-if="activeMenu.id === '17'" src="../../assets/industry/ad-icon17.png"/>
            <img v-else-if="activeMenu.id === '18'" src="../../assets/industry/ad-icon18.png"/>
            <img v-else src="../../assets/industry/ad-icon19.png"/>
            <!-- end -->
            {{ activeMenu.name }}
          </div>
          <div class="r-list">
            <div
              v-for="pitem in activeMenu.children"
              :key="pitem.id"
              class="rl-item curpp"
              @click="$router.push({path:'/industry',query:{id:pitem.id}})"
            >
              <div class="rl-title">{{ pitem.name }}</div>
              <div class="rll-list">
                <div
                  v-for="citem in pitem.children"
                  :key="citem.id"
                  class="rll-item curpp"
                  @click="$router.push({path:'/industry',query:{id:citem.id}})"
                >
                  {{ citem.name }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <Footer/>
  </div>
</template>

<script>
import Header from '@/components/Header'
import Footer from '@/components/Footer'
import { getIndustry } from '@/api/common'

export default {
  components: {
    Header,
    Footer
  },
  data() {
    return {
      menuList: [],
      activeMenu: null
    }
  },
  created() {
    this.getIndustry()
  },
  methods: {
    // 获取行业
    getIndustry() {
      getIndustry().then(response => {
        if (response.data.code === 0) {
          this.menuList = response.data.data
          this.activeMenu = this.menuList[0]
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
.industry-table {
  width: 100%;
  background: #F2F2F2;
}

.main {
  display: flex;
  justify-content: space-between;
  align-items: top;
  width: 1200px;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 50px;
  padding-top: 54px;

  .left {
    width: 300px;
    height: 990px;
    background: #ffffff;

    .title {
      font-size: 18px;
      color: #333333;
      font-weight: bold;
      padding: 17px 20px;
    }

    .l-item {
      padding: 12px 20px;
      font-size: 14px;
      color: #333333;

      &:hover, &.active {
        background: #C34840;
        color: #ffffff;
      }

      img {
        width: 16px;
        height: 16px;
        object-fit: contain;
        vertical-align: middle;
        margin-right: 4px;
      }
    }
  }

  .right {
    width: 900px;
    padding-left: 29px;

    .breadcrumb {
      margin-top: 17px;
    }

    .r-content {
      margin-top: 42px;

      .title {
        font-size: 20px;
        font-weight: bold;
        color: #333333;

        img {
          width: 24px;
          height: 24px;
          object-fit: contain;
          vertical-align: middle;
          margin-right: 5px;
        }
      }
    }

    .r-list {
      width: 100%;
      display: flex;
      flex-flow: row wrap;
      align-content: flex-start;

      .rl-item {
        width: 50%;
        padding-left: 36px;
        margin-top: 23px;

        .rl-title {
          font-size: 16px;
          color: #3c8ced;
        }
      }
    }

    .rll-list {
      margin-top: 17px;
      display: flex;
      flex-flow: row wrap;
      align-content: flex-start;

      .rll-item {
        width: 50%;
        font-size: 14px;
        color: #333333;
      }
    }
  }
}
</style>
