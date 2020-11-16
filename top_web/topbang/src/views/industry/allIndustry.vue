<template>
  <div class="all-industry">
    <Header/>
    <NavSticky :sticky="60"/>
    <div class="main">
      <!-- 行业 -->
      <div class="industry">
        <div class="title">
          <span class="icon">
            <img src="../../assets/icons/industry1.png"/>
          </span>
          <span>农林牧渔业产品</span>
          <span class="more">
            更多
            <i class="el-icon-arrow-right"></i>
          </span>
        </div>
        <div class="list-content">
          <div class="left">
            <div class="img1" @click="$router.push('/productMain')">
              <img class="pic" src="../../assets/pics/sample1.jpg"/>
            </div>
            <div class="img2" @click="$router.push('/productMain')">
              <img class="pic" src="../../assets/pics/sample1.jpg"/>
            </div>
          </div>
          <div class="right">
            <VideoItem v-for="item in contentData" :key="item.id" class="right-item" :content="item"/>
          </div>
        </div>
      </div>

      <!-- 行业 -->
      <div class="industry">
        <div class="title">
          <span class="icon">
            <img src="../../assets/icons/industry2.png"/>
          </span>
          <span>采矿业产品</span>
          <span class="more">
            更多
            <i class="el-icon-arrow-right"></i>
          </span>
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
            <VideoItem v-for="item in contentData" :key="item.id" class="right-item" :content="item"/>
          </div>
        </div>
      </div>

      <!-- 行业 -->
      <div class="industry">
        <div class="title">
          <span class="icon">
            <img src="../../assets/icons/industry3.png"/>
          </span>
          <span>制造业产品</span>
          <span class="more">
            更多
            <i class="el-icon-arrow-right"></i>
          </span>
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
            <VideoItem v-for="item in contentData" :key="item.id" class="right-item" :content="item"/>
          </div>
        </div>
      </div>

      <!-- 行业 -->
      <div class="industry">
        <div class="title">
          <span class="icon">
            <img src="../../assets/icons/industry4.png"/>
          </span>
          <span>建筑业产品</span>
          <span class="more">
            更多
            <i class="el-icon-arrow-right"></i>
          </span>
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
            <VideoItem v-for="item in contentData" :key="item.id" class="right-item" :content="item"/>
          </div>
        </div>
      </div>

      <!-- 行业 -->
      <div class="industry">
        <div class="title">
          <span class="icon">
            <img src="../../assets/icons/industry5.png"/>
          </span>
          <span>批发和零售业产品</span>
          <span class="more">
            更多
            <i class="el-icon-arrow-right"></i>
          </span>
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
            <VideoItem v-for="item in contentData" :key="item.id" class="right-item" :content="item"/>
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
      contentData: [
        {
          id: 1,
          title: '视频分析'
        }, {
          id: 2,
          title: '在线教育'
        }, {
          id: 3,
          title: '智能家居'
        }, {
          id: 4,
          title: '语音识别'
        }, {
          id: 5,
          title: '车辆追踪'
        }, {
          id: 6,
          title: '智慧社区'
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
.all-industry {
  padding-top: 120px;
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
    padding-top: 25px;
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
}
</style>
