<template>
  <div class="industry-main">
    <Header/>
    <NavSticky :sticky="60"/>
    <div class="main">
      <div class="industry">
        <div class="title">
          <span class="icon">
            <img src="../../assets/icons/industry6.png"/>
          </span>
          <span>{{ industryInfo.name }}</span>
        </div>
        <div class="list-content">
          <div class="left">
            <div class="img1">
              <img class="pic" src="../../assets/pics/sample1.jpg"/>
            </div>
            <div class="img2">
              <img class="pic" src="../../assets/pics/sample1.jpg"/>
            </div>
          </div>
          <div class="right">
            <VideoItem v-for="item in newListSix" :key="item.id" class="right-item" :content="item"/>
          </div>
        </div>
      </div>

      <div class="industry">
        <div class="title">
          <span class="icon">
            <img src="../../assets/icons/star.png"/>
          </span>
          <span>只为你</span>
        </div>
        <div class="star-list">
          <div v-for="(item, index) in selectedList" :key="index" class="wrap">
            <VideoItem :content="item" :show-bottom="true" :bottom-style="2"/>
          </div>
        </div>
      </div>
    </div>
    <Footer/>
    <Nav/>
  </div>
</template>

<script>
import Header from '@/components/Header'
import NavSticky from '@/components/NavSticky'
import Footer from '@/components/Footer'
import Nav from '@/components/Nav'

import VideoItem from '../components/VideoItem'

import { getIndustryProdList } from '@/api/product'

export default {
  components: {
    Header,
    Nav,
    NavSticky,
    Footer,
    VideoItem
  },
  data() {
    return {
      array: [],
      contentData: [],
      newListSix: [],
      selectedList: [],
      industryInfo: {}
    }
  },
  created() {
    this.getIndustryProdList()
  },
  methods: {
    // 获取产品详情
    getIndustryProdList() {
      getIndustryProdList(this.$route.query.id).then(response => {
        if (response.data.code === 0) {
          this.industryInfo = response.data.data.industryInfo
          // 产品详情
          this.newListSix = response.data.data.productList
          this.selectedList = response.data.data.selectedList
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
.industry-main {
  width: 100vw;
  overflow: hidden;
  background: url(../../assets/pics/banner2.jpg) no-repeat;
  background-position-x: center;
  background-position-y: top;
  background-size: 1920px;

  .main {
    width: 1200px;
    margin-left: auto;
    margin-right: auto;
    padding-top: 120px;
  }

  .industry {
    margin-right: 20px;
    margin-bottom: 58px;
    margin-top: 20px;

    .title {
      display: flex;;
      font-size: 30px;
      color: #333333;
      font-weight: bold;
      justify-content: flex-start;
      align-items: center;
      margin-bottom: 10px;

      .icon {
        display: inline-block;
        position: relative;
        width: 50px;
        height: 50px;
        background: #ffffff;
        margin-right: 21px;

        img {
          position: absolute;
          width: 30px;
          height: 30px;
          object-fit: cover;
          left: 50%;
          top: 50%;
          transform: translate(-50%, -50%);
        }
      }
    }
  }

  .list-content {
    width: 1200px;
    height: 296px;
    display: flex;
    justify-content: space-between;
    padding: 20px;
    background: #ffffff;

    .left {
      display: flex;
      width: 470px;
      justify-content: space-between;

      .img1, .img2 {
        display: inline-block;

        .icon {
          position: absolute;
          top: 43px;
          left: 50%;
          transform: translateX(-50%);
        }

        .pic {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .txt {
          position: absolute;
          width: 100%;
          top: 103px;
          text-align: center;
          font-size: 14px;
          color: #ffffff;
        }
      }

      .img1 {
        position: relative;
        width: 260px;
        height: 256px;
      }

      .img2 {
        position: relative;
        width: 190px;
        height: 256px;
        margin-left: 20px;
      }
    }

    .right {
      width: 670px;
    }

    .right-item {
      margin-right: 20px;
      margin-bottom: 20px;

      &:nth-child(3n) {
        margin-right: 0;
        margin-bottom: 0;
      }
    }
  }

  .star-list {
    width: 1200px;
    margin-left: auto;
    margin-right: auto;
    background: #ffffff;
    padding: 20px;

    .wrap {
      display: inline-block;
      margin-right: 27px;
      margin-bottom: 27px;

      &:nth-child(5n) {
        margin-right: 0;
      }
    }
  }
}
</style>
