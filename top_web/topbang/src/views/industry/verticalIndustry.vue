<template>
  <div class="industry-main">
    <Header />
    <NavSticky :sticky="60" />
    <div class="main">

      <div class="top-content">
        <div class="left">
          <div class="title">
            <img class="icon" src="../../assets/icons/picx.png" />
            <span>分类目录</span>
            <div class="change">
              <i class="t-left el-icon-arrow-left"></i>
              <i class="t-right el-icon-arrow-right"></i>
            </div>
          </div>
          <div v-for="menu in menuList" :key="menu" class="menu">
            <span>{{ menu }}</span>
            <i class="m-right el-icon-arrow-right"></i>
          </div>
        </div>

        <div class="center">
          <swiper class="swiper" ref="mySwiper" :options="swiperOptions">
            <swiper-slide class="slide"><img src="../../assets/pics/scroll-banner.png"></swiper-slide>
            <swiper-slide class="slide"><img src="../../assets/pics/scroll-banner.png"></swiper-slide>
            <swiper-slide class="slide"><img src="../../assets/pics/scroll-banner.png"></swiper-slide>
            <div slot="pagination" class="swiper-pagination" />
          </swiper>
        </div>

        <div class="right">
          <div class="title">分类热门产品</div>
          <div v-for="(item, index) in itemList" :key="index" class="item">
            <div class="r-left">
              <div class="name">{{ item.name }}</div>
              <div class="desc">{{ item.desc }}</div>
            </div>
            <img class="r-img" src="../../assets/pics/sample3.png" />
          </div>
        </div>
      </div>
      <div class="bottom">
        <div class="industry">
          <div class="title">
            <span>语音识别</span>
            <span class="more">
              更多
              <i class="el-icon-arrow-right"></i>
            </span>
          </div>
          <div class="star-list">
            <div v-for="(item, index) in array" :key="index" class="wrap">
              <VideoItem :content="item" :show-bottom="true" :bottom-style="2" />
            </div>
          </div>
        </div>

        <div class="industry">
          <div class="title">
            <span>在线教育</span>
            <span class="more">
              更多
              <i class="el-icon-arrow-right"></i>
            </span>
          </div>
          <div class="star-list">
            <div v-for="(item, index) in array" :key="index" class="wrap">
              <VideoItem :content="item" :show-bottom="true" :bottom-style="2" />
            </div>
          </div>
        </div>
      </div>

    </div>
    <Footer />
    <Nav />
  </div>
</template>

<script>
import Header from '@/components/Header'
import NavSticky from '@/components/NavSticky'
import Footer from '@/components/Footer'
import Nav from '@/components/Nav'

import VideoItem from '../components/VideoItem'
import { Swiper, SwiperSlide } from 'vue-awesome-swiper'
import 'swiper/css/swiper.min.css'
export default {
  components: {
    Swiper,
    SwiperSlide,
    Header,
    Nav,
    NavSticky,
    Footer,
    VideoItem
  },
  computed: {
    swiper() {
      return this.$refs.mySwiper.$swiper
    }
  },
  data() {
    return {
      menuList: ['语音识别', '在线教育', '机器人', '语义理解', '深度学习', '深度学习'],
      array: [],
      itemList: [{
        name: '智能蓝牙耳机',
        desc: '智能蓝牙耳机'
      }, {
        name: '智能学习机',
        desc: '智能蓝牙耳机'
      }, {
        name: '扫地机器人',
        desc: '智能蓝牙耳机'
      }],
      swiperOptions: {
        pagination: {
          el: '.swiper-pagination'
        },
        autoplay: true,
        loop: true
      },
    }
  },
  created() {
    for(let i = 0; i < 20; i++) {
      this.array.push({
        id: i+1,
        other: 'test'
      })
    }
  }
}
</script>
<style lang="scss">
.swiper-pagination-bullet {
  background: #fff;
  opacity: 1;
}
.swiper-pagination-bullet-active {
  width: 40px;
  height: 8px;
  border-radius: 3px;
}
</style>
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
    .top-content {
      width: 100%;
      height: 290px;
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
      overflow: hidden;
      .left {
        width: 260px;
        height: 290px;
        background: #ffffff;
        padding: 16px 10px 12px 10px;
        margin-right: 10px;
        .icon {
          width: 8px;
          height: 18px;
          margin-right: 9px;
        }
        .title {
          font-size: 20px;
          color: #333333;
          font-weight: 500;
          margin-bottom: 10px;
        }
        .change {
          float: right;
          position: relative;
          width: 45px;
          height: 16px;
          background: #eeeeee;
          border-radius: 8px;
          margin-top: 6px;
          .t-left, .t-right {
            cursor: pointer;
            &:hover {
              color: #E7554C;
            }
          }
          .t-left {
            position: absolute;
            top: 3px;
            left: 10px;
            font-size: 12px;
          }
          .t-right {
            position: absolute;
            top: 3px;
            right: 10px;
            font-size: 12px;
          }
        }
        .menu {
          display: flex;
          justify-content: space-between;
          align-items: center;
          height: 38px;
          line-height: 38px;
          padding-left: 27px;
          padding-right: 20px;
          font-size: 14px;
          color: #333333;
          cursor: pointer;
          &:hover {
            color: #E7554C;
          }
        }
      }
      .center {
        width: 650px;
        height: 290px;
        margin-right: 10px;
        .swiper {
          display: inline-block;
          width: 100%;
          height: 290px;
        }
        .slide {
          width: 100%;
          height: 100%;
          img {
            width: 100%;
            height: 100%;
            object-fit: cover;
          }
        }
      }
      .right {
        width: 270px;
        height: 290px;
        background: #ffffff;
        .title {
          width: 180px;
          height: 26px;
          line-height: 26px;
          background: #c34840;
          font-size: 16px;
          font-weight: 500;
          text-align: center;
          color: #ffffff;
          margin: 12px auto;
          margin-bottom: 20px;
        }
        .item {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding-left: 25px;
          padding-right: 25px;
          margin-bottom: 20px;
          .r-left {
            .name {
              font-size: 16px;
              color: #333333;
              font-weight: 500;
            }
            .desc {
              font-size: 12px;
              color: #333333;
            }
          }
          .r-img {
            max-height: 60px;
            max-width: 80px;
            object-fit: contain;
          }
        }
      }
    }
    .bottom {
      margin-top: 50px;
    }
  }
  .industry {
    position: relative;
    margin-right: 20px;
    margin-bottom: 58px;
    .title {
      display: flex;;
      font-size: 30px;
      color: #333333;
      font-weight: bold;
      justify-content: flex-start;
      align-items: center;
      margin-bottom: 10px;
    }
    .more {
      position: absolute;
      right: 0;
      width: 66px;
      height: 22px;
      border: 1px solid #cccccc;
      border-radius: 2px;
      color: #999999;
      font-size: 14px;
      padding-left: 12px;
      cursor: pointer;
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