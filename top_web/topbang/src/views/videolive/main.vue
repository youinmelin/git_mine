<template>
  <div class="product-main">
    <Header/>
    <NavSticky :sticky="60"/>
    <div class="main-content">
      <div style="width: 1200px; margin: 0 auto;">
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item :to="{path:'industryTable'}">所有行业</el-breadcrumb-item>
          <el-breadcrumb-item
            v-for="(item,index) in crumbs"
            :key="index"
            :to="{path:'/industry',query:{id:item.id}}"
          >
            {{ item.name }}
          </el-breadcrumb-item>
        </el-breadcrumb>

        <div class="center">
          <swiper class="swiper" ref="mySwiper" :options="swiperOptions">
            <swiper-slide
              class="slide">
              <img :src="productInfo.videoImgUrl">
            </swiper-slide>
            <div class="swiper-button-prev" slot="button-prev"></div>
            <div class="swiper-button-next" slot="button-next"></div>
          </swiper>
          <div class="info">
            <div class="title">{{ productInfo.title }}</div>
            <div class="rate">
              <el-rate show-score v-model="productScore" disabled text-color="#FF5040"></el-rate>
              <div class="icons">
                <svg-icon class="icon" icon-class="heart" @click="productCollection(productInfo.id)"/>
                <i class="el-icon-share icon"></i>
              </div>
            </div>
            <div class="item">
              <span class="name">价格</span>
              <span class="price">¥<span class="num">{{ productInfo.price }}</span></span>
            </div>
            <div class="item">
              <span class="name">定制</span>
              <span class="value">
                {{ productInfo.isCustom === 1 ? '支持定制' : '不支持定制' }}
                <i v-if="productInfo.isCustom===1" class="el-icon-circle-check"></i>
              </span>
            </div>
            <!--            <div class="item">-->
            <!--              <span class="name">商家</span>-->
            <!--              <span class="value curpp" @click="$router.push({path:'/companyInfo',query:{id:companyInfo.userId}})">-->
            <!--                {{ companyInfo.name }}-->
            <!--                <svg-icon class="renzhen" icon-class="renzhen"/>-->
            <!--              </span>-->
            <!--            </div>-->
            <div class="try" @click="productGiveTrial(productInfo.id)">申请试用</div>
            <div class="buy" @click="jumpToUrl(productInfo.buyUrl)">立即购买</div>
          </div>
        </div>
      </div>
    </div>

    <div class="product-detail">
      <div class="pd-left">
        <div class="pd-desc">
          <div class="pd-title">
            直播详情
          </div>
          <div class="pd-content" v-html="productInfo.content">
          </div>
        </div>
      </div>
      <div class="pd-right">
        <div class="video-title">相关直播</div>
        <!-- 视频列表 -->
        <div
          v-for="item in recommendList"
          :key="item.id"
          class="video-wrap"
          @click="$router.push({path:'/productMain',query:{id:item.id}})"
        >
          <img :src="item.videoImgUrl"/>
          <span class="bottom">
            <span class="time">00:00:10</span>
          </span>
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

import { Swiper, SwiperSlide } from 'vue-awesome-swiper'
import 'swiper/css/swiper.min.css'

import { getWebPageProductEvaluate, getVideoLiveInfo, productGiveTrial, productCollection } from '@/api/product'

export default {
  components: {
    Header,
    Footer,
    Nav,
    NavSticky,
    Swiper,
    SwiperSlide
  },
  data() {
    return {
      loading: false,
      value1: 4.0,
      activeTag: -1,
      activeType: -1,
      checked: false,
      swiperOptions: {
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev'
        },
        autoplay: false,
        loop: true
      },
      playerOptions: [],
      tagList: ['吸力强劲(42)', '清洁能力强(24)', '全自动智能(13)', '多档可调(6)'],
      otherList: ['全部评价(500+)', '晒图(500)', '视频晒单(60+)', '追评(20+)', '好评(200+)', '中评(2)', '差评(4)'],
      evelList: [],
      // 产品评分
      productScore: 0,
      // 面包屑导航
      crumbs: [],
      // 产品信息
      productInfo: {
        id: 0,
        name: '',
        price: '',
        isCustom: '',
        content: '',
        score: 0,
        buyUrl: ''
      },
      // 企业信息
      companyInfo: {
        name: ''
      },
      // 视频信息
      videoList: [],
      recommendList: [],
      page: {
        currentPage: 1,
        total: 0
      },
      listQuery: {
        page: 1,
        limit: 10,
        status: '',
        strSearch: '',
        productId: 0
      }
    }
  },
  computed: {
    swiper() {
      return this.$refs.mySwiper.$swiper
    }
  },
  created() {
    this.getVideoLiveInfo()
    this.getWebPageProductEvaluate()
  },
  watch: {
    '$route': function(to, from) {
      location.reload()
    }
  },
  methods: {
    jumpToUrl(url) {
      window.open(url, '_blank')
    },
    // 获取产品详情
    getVideoLiveInfo() {
      getVideoLiveInfo(this.$route.query.id).then(response => {
        if (response.data.code === 0) {
          // 面包屑导航
          this.crumbs = response.data.data.crumbs
          // 产品详情
          this.productInfo = response.data.data.productInfo
          // 企业信息
          // this.companyInfo = response.data.data.companyInfo
          // 相关推荐
          this.recommendList = response.data.data.recommendList
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
    // 评价列表
    getWebPageProductEvaluate() {
      this.listQuery.productId = this.$route.query.id
      getWebPageProductEvaluate(this.listQuery).then(response => {
        if (response.data.code === 0) {
          // 评价列表
          this.evelList = response.data.data.list
          this.page.total = response.data.data.total
          // 评分(这里应该有更好的写法)
          this.productScore = response.data.data.productScore
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
    // 分页点击事件
    handleCurrentChange(val) {
      this.listQuery.page = val
      this.getWebPageProductEvaluate()
    },
    // 产品试用
    productGiveTrial(prodId) {
      // 判断是否登录，没登录跳转登录页
      if (localStorage.token) {
        this.$confirm('申请产品试用?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          productGiveTrial(prodId).then(response => {
            if (response.data.code === 0) {
              this.$alert('申请成功，请等待商家审核', '提示', {
                callback: action => {
                  this.loading = false
                  return false
                }
              })
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
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消申请'
          })
        })
      } else {
        this.$alert('申请试用请先登录', '提示', {
          confirmButtonText: '确定',
          type: 'warning',
          callback: action => {
            this.$router.push('/login')
            return false
          }
        })
      }
    },
    // 产品收藏
    productCollection(prodId) {
      this.loading = true
      // 判断是否登录，没登录跳转登录页
      if (localStorage.token) {
        productCollection(prodId).then(response => {
          if (response.data.code === 0) {
            this.$alert('收藏成功', '提示', {
              callback: action => {
                this.loading = false
                return false
              }
            })
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
      } else {
        this.$alert('收藏产品请先登录', '提示', {
          confirmButtonText: '确定',
          type: 'warning',
          callback: action => {
            this.loading = false
            this.$router.push('/login')
            return false
          }
        })
      }
    }
  }
}
</script>
<style>
.el-rate__icon {
  font-size: 24px;
}

.el-rate__text {
  font-size: 24px;
}

.el-checkbox__input.is-checked + .el-checkbox__label {
  color: #C34840;
}

.el-checkbox__input.is-checked .el-checkbox__inner, .el-checkbox__input.is-indeterminate .el-checkbox__inner {
  background-color: #C34840;
  border-color: #C34840;
}

.el-pagination.is-background .el-pager li:not(.disabled).active {
  background: none;
  color: #C34840;
}

.el-pagination.is-background .el-pager li:not(.disabled):hover {
  color: #C34840
}
</style>

<style lang="scss" scoped>
.product-main {
  background: #f2f2f2;
}

.main-content {
  margin-top: 140px;
  width: 100%;
  background: #ffffff;

  .center {
    display: flex;
    justify-content: space-between;
    align-items: top;
    width: 100%;
    height: 540px;
    margin-top: 22px;

    .swiper {
      width: 800px;
      height: 450px;
    }

    .info {
      width: 350px;
      height: 450px;
      padding-left: 25px;
      padding-right: 25px;

      .title {
        font-size: 18px;
        font-weight: bold;
        color: #000000;
        text-align: left;
      }

      .rate {
        margin-top: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 49px;
      }

      .icons {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 87px;
        color: #7E7E7E;

        .icon {
          cursor: pointer;
        }
      }

      .item {
        display: flex;
        justify-content: flex-start;
        margin-bottom: 30px;

        .name {
          font-size: 14px;
          color: #666666;
          margin-right: 22px;
        }

        .value {
          font-size: 14px;
          color: #333333;
        }

        .renzhen {
          font-size: 20px;
        }
      }

      .price {
        color: #FF5040;
        font-size: 14px;

        .num {
          font-size: 18px;
        }
      }
    }

    .el-icon-circle-check {
      color: #8cd65a;
      margin-left: 5px;
    }

    .try, .buy {
      width: 100%;
      height: 50px;
      line-height: 50px;
      text-align: center;
      cursor: pointer;
      border-radius: 4px;
    }

    .try {
      border: 2px solid #c34840;
      font-size: 20px;
      color: #C34840;
      margin-top: 50px;
    }

    .buy {
      background: #C34840;
      color: #ffffff;
      margin-top: 20px;
    }
  }
}

.product-detail {
  display: flex;
  margin-top: 20px;
  width: 1200px;
  margin-left: auto;
  margin-right: auto;
  justify-content: space-between;
  align-items: top;

  .pd-left {
    width: 850px;
  }

  .pd-right {
    width: 310px;

    .video-title {
      font-size: 20px;
      color: #333333;
      font-weight: bold;
    }

    .video-wrap {
      position: relative;
      width: 100%;
      height: 174px;
      margin-top: 20px;

      img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }

      .bottom {
        position: absolute;
        width: 100%;
        height: 59px;
        bottom: 0;
        left: 0;
        background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, .4));

        .time {
          position: absolute;
          right: 10px;
          bottom: 10px;
          font-size: 12px;
          color: #ffffff;
        }
      }
    }
  }

  .pd-desc {
    background: #ffffff;
    width: 100%;
    margin-bottom: 50px;
  }

  .pd-title {
    position: relative;
    font-size: 20px;
    color: #333333;
    font-weight: bold;
    border-bottom: 1px solid #eeeeee;
    padding: 16px 30px;

    &:after {
      position: absolute;
      content: '';
      left: 45px;
      bottom: 0;
      width: 50px;
      height: 2px;
      background: #C34840;
    }

    .sort {
      float: right;
      color: #333333;
      font-size: 14px;
      margin-top: 5px;
    }
  }

  .pd-content {
    position: relative;
    padding: 30px;
    font-size: 14px;
    color: #333333;

    &:after {
      content: '';
      position: absolute;
      width: 790px;
      height: 1px;
      background: #EEEEEE;
      left: 50%;
      bottom: 30px;
      transform: translateX(-50%);
    }

    .user {
      display: inline-block;
      width: 140px;
      vertical-align: top;

      .avatar {
        width: 25px;
        height: 25px;
        border-radius: 50%;
        vertical-align: middle;
      }

      .name {
        font-size: 12px;
        color: #666666;
        margin-left: 9px;
      }
    }

    .user-comment {
      display: inline-block;
      width: 650px;
      padding-bottom: 20px;
      border-bottom: 1px solid #eeeeee;

      .comment {
        font-size: 14px;
        color: #333333;
        margin-top: 22px;
      }

      .c-pics {
        margin-top: 17px;

        img {
          width: 50px;
          height: 50px;
          object-fit: cover;

          &:not(:last-child) {
            margin-right: 20px;
          }
        }
      }

      .c-foot {
        display: flex;
        justify-content: space-between;
        font-size: 12px;
        color: #999999;
        margin-top: 20px;

        .c-operate {
          .co {
            cursor: pointer;
          }

          .co:not(:last-child) {
            margin-right: 20px;
          }

          .co.jb {
            margin-right: 30px;
          }

          img {
            width: 16px;
            margin-right: 5px;
          }
        }
      }
    }

    .reply {
      color: #3c8ced;
      font-size: 14px;
      line-height: 24px;
      padding-top: 18px;
      padding-left: 140px;
      padding-bottom: 20px;

      .reply-time {
        font-size: 12px;
        color: #999999;
        margin-right: 20px;
      }
    }
  }

  .comment-top {
    font-size: 14px;
    color: #666666;
    padding: 22px 30px;
    border-bottom: 1px solid #eeeeee;

    .good-comment {
      display: inline-block;
      vertical-align: middle;
      width: 80px;
      height: 100%;

      .gc-name-rate {
        font-size: 30px;
        color: #c34840;
        font-weight: 500;
      }
    }

    .gd-tags {
      display: inline-block;
      vertical-align: middle;
      margin-left: 56px;

      .tag {
        display: inline-block;
        border: 1px solid #CCCCCC;
        border-radius: 2px;
        color: #666666;
        padding: 6px 10px;
        cursor: pointer;
        margin-right: 20px;

        &.active {
          border: 1px solid #666666;
          color: #666666;
        }
      }
    }
  }

  .comment-type {
    padding: 12px 30px;
    font-size: 14px;
    color: #333333;
    border-bottom: 1px solid #eeeeee;

    .type {
      cursor: pointer;

      &.active {
        color: #c34840;
      }
    }

    .type:not(:last-child) {
      margin-right: 25px;
    }
  }

  .pagination {
    text-align: right;
    padding-bottom: 38px;
  }

}

.swiper-button-prev, .swiper-button-next {
  --swiper-theme-color: #ffffff;
}
</style>
