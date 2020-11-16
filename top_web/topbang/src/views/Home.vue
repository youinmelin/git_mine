<template>
  <div class="home">
    <Header class="fix-header" :show-search="1280"/>
    <NavSticky :sticky="1280" :top="53" :hide="true"/>
    <Main/>
    <div class="banner">
      <div class="menu">
        <div class="list">
          <div class="industry">
            行业
          </div>
          <div
            v-for="(m, index) in menu"
            :key="index"
            class="other"
            @click="$router.push({path:'/industry',query:{id:m.categoryId}})"
          >
            {{ m.categoryName.slice(0, 5) }}
          </div>
        </div>

        <div class="center">
          <swiper
            ref="mySwiper"
            class="swiper"
            :options="swiperOptions"
          >
            <swiper-slide
              class="slide"
              v-for="(banner,index) in bannerList"
              :key="index">
              <img :src="banner.imgUrl"/>
            </swiper-slide>
            <div slot="pagination" class="swiper-pagination"/>
          </swiper>
        </div>

        <div class="recommend">
          <div class="title">为你精选</div>
          <div class="scroll">
            <p
              v-for="(item, index) in selectedList"
              :key="index"
              @mouseover="setVideoUrl(item)"
              @click="$router.push({path:'/productMain',query:{id:item.id}})">
              {{ item.name }}
            </p>
          </div>
        </div>
        <el-dialog :visible.sync="dialogVisible">
          <video-player
            class="video-player vjs-custom-skin"
            ref="videoPlayer"
            :playsinline="true"
            :options="playerOptions"
          >
          </video-player>
        </el-dialog>
      </div>

      <div
        class="intro"
        v-for="(items,index) in indexCategoryList"
        :key="index">
        <div class="head-title">
          <img class="icon" src="../assets/icons/home-icon2.png">
          <div class="name">{{ items.name }}</div>
        </div>
        <div class="desc">广泛应用于工业制造、城市交通、医疗健康、广泛应用于工业制造、城市交通、医疗健康、</div>
        <div class="intro-bg">
          <div class="list-content">
            <div class="left">
              <div class="img1">
                <img class="icon" src="../assets/pics/pic5.png">
                <img class="pic" src="../assets/pics/sample1.jpg">
                <div class="txt">因知而智 工业全息洞察</div>
              </div>
              <div class="img2">
                <img class="icon" src="../assets/pics/pic4.png">
                <img class="pic" src="../assets/pics/sample1.jpg">
                <div class="txt">因知而智 工业全息洞察</div>
              </div>
            </div>
            <div class="right">
              <VideoItemHome v-for="item in items.list" :key="item.id" class="right-item" :content="item"/>
            </div>
          </div>
          <div class="more" @click="$router.push({path:'/industry',query:{id:items.id}})">MORE</div>
        </div>
      </div>

      <div class="new-product">
        <div class="np-list">
          <div class="n-title">新品展示</div>
          <div class="new-list">
            <VideoItemHome v-for="item in newListSix" :key="item.id" class="right-item" :content="item"/>
          </div>
        </div>
        <div class="hot-list">
          <div class="n-title">热销产品 TOP 5</div>
          <div class="h-list">
            <div
              v-for="(item, index) in hotSaleListFive"
              :key="item.id"
              class="h-item"
              :class="{'not-active': +nowExpland !== +index}"
              @mouseenter="setActive(index)"
              @mouseleave="setActive(0)"
              @click="$router.push({path:'/productMain',query:{id:item.id}})"
            >
              <span class="no" :class="{'red': index <3 }">{{ index + 1 }}</span>
              <template v-if="+nowExpland === +index">
                <div class="pre-img">
                  <img :src="item.videoImgUrl">
                  <div class="play">
                    <svg-icon class="icon" icon-class="play"/>
                  </div>
                </div>
                <div class="t-star">
                  <div class="t-name">{{ item.name }}</div>
                  <span class="item">
                    <svg-icon class="like" icon-class="star"/>
                    4290
                  </span>
                </div>
              </template>
              <template v-else>
                <div class="t-name">{{ item.name }}</div>
              </template>
            </div>
          </div>
        </div>
      </div>

      <!-- ceo助力 -->
      <div class="intro">
        <div class="head-title">
          <img class="icon" src="../assets/icons/home-icon4.png">
          <div class="name">CEO 助力</div>
        </div>
        <div class="live-list">
          <LiveItemHome v-for="item in videoLiveList" :key="item.id" :content="item"/>
        </div>
      </div>

      <div class="finally">
        <div class="f-item">
          <div class="f-left">
            <img src="../assets/pics/home-b1.png">
          </div>
          <div class="f-right">
            <div class="f-content">两万家智能家居服务企业，提供定制合作，这些优秀的供应商将为您竭诚服务</div>
            <div class="f-icons">
              <div class="icon">
                <img src="../assets/icons/home-icon5.png">
                <span>行业标杆</span>
              </div>
              <div class="icon icon2">
                <img src="../assets/icons/home-icon6.png">
                <span>企业认证供应商</span>
              </div>
            </div>
          </div>
        </div>
        <div class="f-item">
          <div class="f-left">
            <img src="../assets/pics/home-b2.png">
          </div>
          <div class="f-right">
            <div class="f-content">两万家智能家居服务企业，提供定制合作，这些优秀的供应商将为您竭诚服务</div>
            <div class="f-icons">
              <div class="icon">
                <img src="../assets/icons/home-icon5.png">
                <span>行业标杆</span>
              </div>
              <div class="icon icon2">
                <img src="../assets/icons/home-icon6.png">
                <span>企业认证供应商</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <Footer/>
    <Nav/>
  </div>
</template>

<script>
// @ is an alias to /src
import Header from '@/components/Header'
import Footer from '@/components/Footer'
import Nav from '@/components/Nav'
import { Swiper, SwiperSlide } from 'vue-awesome-swiper'
import VideoItemHome from './components/VideoItemHome'
import LiveItemHome from './components/LiveItemHome'
import Main from './Main'

import 'swiper/css/swiper.min.css'
import NavSticky from '@/components/NavSticky'
import { index } from '@/api/index'
import { getIndexCategory } from '@/api/common'
import { videoPlayer } from 'vue-video-player'
import 'video.js/dist/video-js.css'
import { getProductInfo } from '@/api/product'

export default {
  name: 'Home',
  components: {
    Header,
    Footer,
    Swiper,
    SwiperSlide,
    VideoItemHome,
    LiveItemHome,
    NavSticky,
    Nav,
    Main,
    videoPlayer
  },
  data() {
    return {
      words: ['covid-19对全球的经济影响', '美国大学', '非洲暴动'],
      menu: [],
      news: [
        'AI机器人-智能养老服务好帮手',
        '智能家居AI本地推理模块开发（一）',
        '智能和目安防传感器S1，提升质量',
        '5G、物联网、云计算行业竞争格局',
        'AI机器人-智能养老服务好帮手 拷贝 4',
        '智能家居AI本地推理模块开发（一）',
        '智能和目安防传感器S1，提升质量',
        '5G、物联网、云计算行业竞争格局',
        'AI机器人-智能养老服务好帮手 拷贝 4'
      ],
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
        }
      ],
      swiperOptions: {
        pagination: {
          el: '.swiper-pagination'
        },
        autoplay: true,
        loop: true
      },
      // 视频播放
      playerOptions: {},
      dialogVisible: false,
      nowExpland: 0,
      // 热门搜索
      hotSearchList: [],
      // banner 列表
      bannerList: [],
      // 为您精选
      selectedList: [],
      // 新品 6
      newListSix: [],
      // TOP 5
      hotSaleListFive: [],
      // 直播 5
      videoLiveList: [],
      // 动态栏目
      indexCategoryList: []
    }
  },
  computed: {
    swiper() {
      return this.$refs.mySwiper.$swiper
    }
  },
  created() {
    this.index()
    this.getIndexCategory()
  },
  mounted() {
    // console.log('Current Swiper instance object', this.swiper)
    // this.swiper.slideTo(3, 1000, false)
    // this.swiper.init()
  },
  methods: {
    setActive(index) {
      this.nowExpland = index
    },
    // 首页分类
    getIndexCategory() {
      getIndexCategory().then(response => {
        if (response.data.code === 0) {
          this.menu = response.data.data
        } else {
          return false
        }
      })
    },
    // 首页大接口
    index() {
      index().then(response => {
        if (response.data.code === 0) {
          // 热门搜索
          this.hotSearchList = response.data.data.hotSearchList
          // banner
          this.bannerList = response.data.data.bannerList
          // 为您精选
          this.selectedList = response.data.data.selectedList
          // 新品6
          this.newListSix = response.data.data.newListSix
          // TOP 5
          this.hotSaleListFive = response.data.data.hotSaleListFive
          // 直播
          this.videoLiveList = response.data.data.videoLiveList
          // 动态栏目
          this.indexCategoryList = response.data.data.indexCategoryList
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
    // 弹出视频播放
    setVideoUrl(item) {
      let videoUrl = ''
      // 获取一次产品信息
      getProductInfo(item.id).then(response => {
        if (response.data.code === 0) {
          const videoList = response.data.data.videoList
          if (videoList != null && videoList.length > 0) {
            videoUrl = videoList[0].videoUrl
          }
          this.playerOptions = {
            muted: true,
            fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
            sources: [{
              type: 'video/mp4', // 类型
              src: videoUrl // url地址
            }],
            poster: item.videoImgUrl // 封面地址
          }
          this.dialogVisible = true
        }
      })
    }
  }
}
</script>
<style>
.video-js .vjs-big-play-button {
  top: 45%;
  left: 45%;
}

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

.fix-header {
  position: fixed;
  top: 0;
}

.home {
  position: relative;
  // background: #F2F2F2;
  background: #ffffff;

  .banner {
    min-width: 1200px;
    overflow: auto;
    // background: url(./../assets/pics/banner2.jpg) no-repeat;
    // background-position-x: center;
    // background-position-y: top;
    // background-size: 1920px;
  }

  .search {
    position: absolute;
    left: 50%;
    top: 386px;
    transform: translateX(-50%);

    .search-input {
      input {
        width: 720px;
        height: 60px;
        background: #ffffff;
        border-radius: 6px;
        color: rgba(0, 0, 0, .85);
        font-size: 18px;
        padding-left: 30px;
        padding-right: 60px;

        &::-webkit-input-placeholder {
          /* placeholder颜色 */
          color: #999999;
          /* placeholder字体大小 */
          font-size: 18px;
        }
      }

      .button {
        position: absolute;
        top: 12px;
        right: 20px;
        width: 90px;
        height: 36px;
        background: #c34840;
        border-radius: 4px;
        font-size: 24px;
        color: #ffffff;
        text-align: center;
        line-height: 36px;
        cursor: pointer;
      }
    }

    .hot-words {
      color: #ffffff;
      font-size: 18px;
      margin-top: 30px;
      text-align: center;

      .word {
        color: rgba(255, 255, 255, .8);
        margin-right: 20px;
        font-size: 18px;
      }
    }
  }

  .menu {
    display: flex;
    justify-content: flex-start;
    width: 1200px;
    height: 348px;
    background: #ffffff;
    margin: 0 auto;
    margin-top: 60px;

    .list {
      width: 161px;
      height: 348px;
      font-size: 18px;
      color: #9F9F9F;
      background: #F7F7F7;
      margin-left: 13px;

      .industry {
        width: 120px;
        height: 35px;
        line-height: 35px;
        padding-left: 35px;
        background: url(../assets/pics/pic9.png) no-repeat;
        background-size: 120px;
        font-size: 20px;
        color: #ffffff;
        cursor: pointer;
        margin: 0 auto;
        margin-bottom: 15px;
      }

      .other {
        height: 40px;
        line-height: 40px;
        text-align: center;
        background: #F7F7F7;
        border-bottom: 1px solid #E0E0E0;
        cursor: pointer;

        &:hover {
          background: #EDEDED;
        }

        &:last-child {
          line-height: 50px;
          border-bottom: none;
        }
      }
    }
  }

  .center {
    width: 700px;
    height: 335px;
    margin-top: 13px;
    margin-left: 21px;

    .swiper {
      display: inline-block;
      width: 100%;
      height: 335px;
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
}

.recommend {
  position: relative;
  width: 305px;
  height: 100%;

  .title {
    width: 100%;
    height: 80px;
    line-height: 80px;
    text-align: center;
    font-size: 20px;
    letter-spacing: 3px;
    color: #cc141d;

    &:before {
      position: absolute;
      top: 0;
      content: '';
      width: 96px;
      height: 2px;
      background: #cc141d;
    }
  }

  .scroll {
    width: 260px;
    height: 250px;
    overflow-y: auto;
    font-size: 14px;
    color: #333333;
    margin-left: auto;
    margin-right: auto;

    p {
      margin-top: 24px;
      margin-bottom: 24px;
      line-height: 1;
      cursor: pointer;

      &:before {
        display: inline-block;
        content: '';
        width: 2px;
        height: 2px;
        border-radius: 50%;
        background: #474747;
        vertical-align: middle;
        margin-right: 5px;
      }

      &:last-child {
        margin-bottom: 0;
      }

      &:first-child {
        margin-top: 0;
      }

      &:hover {
        color: #2693FF;
        text-decoration: underline;
      }
    }

    &::-webkit-scrollbar-track {
      background-color: #ffffff;
    }

    &::-webkit-scrollbar {
      width: 2px;
      background-color: #cccccc;;
    }

    &::-webkit-scrollbar-thumb {
      background-color: #cccccc;;
    }
  }
}

.intro {
  position: relative;
  width: 1200px;
  margin: 96px auto;
}

.intro-bg {
  position: relative;
  width: 1210px;
  height: 410px;
  background: #f7f7f7;
  margin-top: 66px;
}

.head-title {
  text-align: center;

  .icon {
    width: 50px;
    height: 50px;
    margin-right: 21px;
    vertical-align: middle;
  }

  .name {
    display: inline-block;
    font-size: 30px;
    color: #333333;
    font-weight: bold;
    vertical-align: middle;
  }
}

.desc {
  font-size: 14px;
  font-weight: 400;
  color: #a4a4a4;
  letter-spacing: 1px;
  text-align: center;
  margin-top: 28px;
}

.list-content {
  position: absolute;
  min-width: 1200px;
  height: 370px;
  top: -13px;
  left: 13px;
  display: flex;
  justify-content: space-between;

  .left {
    display: flex;
    width: 505px;
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

      &:hover {
        &:after {
          position: absolute;
          content: '';
          width: 100%;
          height: 5px;
          background: #cc151d;
          bottom: 0;
          left: 0;
        }
      }
    }

    .img1 {
      position: relative;
      width: 248px;
      height: 370px;
    }

    .img2 {
      position: relative;
      width: 242px;
      height: 370px;
      margin-left: 15px;
    }
  }

  .right {
    width: 681px;
  }

  .right-item {
    margin-right: 12px;
    margin-bottom: 58px;

    &:nth-child(3n) {
      margin-right: 0;
    }
  }
}

.more {
  position: absolute;
  width: 52px;
  height: 19px;
  bottom: 13px;
  right: 9px;
  color: #ffffff;
  font-size: 12px;
  line-height: 19px;
  background: #adadad;
  border-radius: 10px;
  cursor: pointer;
  text-align: center;
}

.new-product {
  width: 1200px;
  margin: 73px auto;
  display: flex;
  justify-content: space-between;
  align-items: top;

  .n-title {
    font-size: 22px;
    color: #333333;

    &:before {
      display: inline-block;
      content: '';
      width: 4px;
      height: 20px;
      border-radius: 2px;
      background: #CC151D;
      vertical-align: middle;
      margin-right: 15px;
    }
  }

  .np-list {
    width: 661px;
    height: 488px;

    .new-list {
      margin-top: 32px;

      .right-item {
        margin-right: 9px;
        margin-bottom: 57px;

        &:nth-child(3n) {
          margin-right: 0;
        }
      }
    }
  }

  .hot-list {
    width: 453px;
    height: 488px;

    .h-list {
      height: 369px;
      overflow-y: auto;
      margin-top: 32px;

      .h-item {
        display: flex;
        justify-content: flex-start;
        align-items: top;
        padding: 10px 8px;

        &:nth-child(odd) {
          background: #F7F7F7;
        }

        &.not-active {
          padding-top: 20px;
          padding-bottom: 20px;
        }
      }

      .no {
        font-size: 14px;
        font-weight: bold;
        color: #111111;
        margin-right: 19px;

        &.red {
          color: #cc151d;
        }
      }

      .pre-img {
        position: relative;;
        width: 112px;
        height: 82px;

        img {
          width: 112px;
          height: 82px;
          object-fit: cover;
        }

        .play {
          position: absolute;
          width: 35px;
          height: 35px;
          border-radius: 50%;
          background: rgba(255, 255, 255, .4);
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);

          .icon {
            position: absolute;
            color: #ffffff;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
          }
        }
      }

      .t-star {
        display: flex;
        justify-content: space-between;
        flex-direction: column;
        height: 53px;
        margin-top: 15px;
        margin-left: 19px;

        .item {
          font-size: 14px;
          color: #CC151D;
        }
      }

      .t-name {
        color: #474747;
        font-size: 14px;
      }
    }
  }
}

.live-list {
  display: flex;
  justify-content: space-between;
  margin-top: 68px;
}

.finally {
  display: flex;
  width: 1200px;
  margin: 0 auto;
  justify-content: space-between;

  .f-item {
    display: flex;
    justify-content: flex-start;
    width: 583px;
    height: 253px;
    background: #f7f7f7;
    padding: 14px 16px;

    .f-left {
      width: 207px;
    }

    .f-right {
      padding-top: 36px;
      padding-left: 29px;

      .f-content {
        width: 280px;
        font-size: 18px;
        color: #474747;
        letter-spacing: 1px;
        line-height: 22px;
      }

      .f-icons {
        margin-top: 23px;
      }

      .icon {
        display: inline-block;
        width: 58px;
        text-align: center;
        font-size: 14px;
        font-weight: 400;
        color: #474747;
        margin-left: 43px;

        img {
          display: block;
          margin: 0 auto;
        }
      }

      .icon2 {
        width: 101px;
      }
    }
  }
}
</style>
