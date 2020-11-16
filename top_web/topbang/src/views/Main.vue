<template>
  <div class="main-page">
    <!-- <div class="top">
      <div class="header">
        <span class="title">欢 迎 来 到 TOP 帮</span>
        <div class="right">
          <span>首页</span>
          <span>请登录</span>
          <span>免费注册</span>
        </div>
      </div>
    </div> -->
    <div class="search-group" :style="bacImage">
      <div class="search">
        <input class="input" v-model="strSearch" @keydown.enter="btnSearch" :placeholder="txtSearch"/>
        <div class="btn" @click="btnSearch">搜索</div>
      </div>
      <div class="hot-words">
        热门搜索 ：<span
        v-for="(word, index) in words"
        :key="index.id"
        @click="qqq(word.content)"
        class="word curpp">{{ word.content }}</span>
      </div>
      <div class="bottom">
        <div class="top1">Topb100.com</div>
        <div>TOP帮Copyright ©2020 北京TOP帮有限公司版权所有</div>
      </div>
    </div>
  </div>
</template>

<script>
import { index } from '@/api/index'
import { getSeo } from '@/api/common'

export default {
  data() {
    return {
      words: [],
      strSearch: '',
      txtSearch: '',
      bacImage: ''
    }
  },
  created() {
    this.index()
  },
  mounted() {
    getSeo().then(response => {
      if (response.data.code === 0) {
        this.bacImage = { backgroundImage: 'url(' + response.data.data.indexBannerImg + ')' }
      } else {
        return false
      }
    })
  },
  methods: {
    btnSearch() {
      this.$router.push({ path: '/Search', query: { strSearch: this.strSearch } })
      // this.$router.push('/Search')
    },
    qqq(content) {
      // this.txtSearch = content
      this.$router.push({ path: '/Search', query: { strSearch: content } })
    },
    index() {
      index().then(response => {
        if (response.data.code === 0) {
          // 热门搜索
          this.words = response.data.data.hotSearchList
          this.txtSearch = response.data.data.hotSearchList[0].content
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
.main-page {
  position: relative;
  min-width: 1200px;
  overflow-x: auto;
  // height: 54px;
  height: 780px;
  background: #ffffff;

  .top {
    position: absolute;
    width: 100%;
    top: 0;
    left: 0;
    z-index: 2;
    background: #ffffff;
    box-shadow: 2px 2px 3px #e8e8e8;
  }

  .header {
    z-index: 2;
    width: 1132px;
    height: 54px;
    margin: 0 auto;

    .title {
      height: 54px;
      line-height: 54px;
      font-size: 17px;
      color: #666666;
      letter-spacing: 3px;
    }

    .right {
      float: right;
      display: flex;
      align-items: center;

      span {
        line-height: 54px;
        height: 54px;
        color: #666666;
        margin-left: 30px;

        &:hover {
          color: #C8000B;
          text-decoration: underline;
          cursor: pointer;
        }
      }
    }
  }

  .search-group {
    position: relative;
    min-width: 1200px;
    min-height: 100vh;
    overflow-x: hidden;
    background: url(../assets/pics/home1.jpg) no-repeat;
    background-position-x: center;
    background-position-y: top;
    background-size: 1920px;
  }

  .search {
    position: absolute;
    width: 710px;
    top: 540px;
    left: 50%;
    transform: translateX(-50%);

    .input {
      width: 600px;
      height: 51px;
      border: 1px solid #d9d9d9;
      padding-left: 20px;
      border-radius: 5px;
      font-size: 18px;

      &::-webkit-input-placeholder {
        /* placeholder颜色 */
        color: #e8e8e8;
        /* placeholder字体大小 */
        font-size: 18px;
      }
    }

    .btn {
      display: inline-block;
      width: 100px;
      height: 51px;
      line-height: 51px;
      color: #ffffff;
      text-align: center;
      background: #C8000B;
      cursor: pointer;
      border-radius: 10px;
      margin-left: 10px;
    }
  }

  .hot-words {
    position: absolute;
    top: 601px;
    left: 50%;
    transform: translateX(-50%);
    color: #666666;
    font-size: 20px;
    z-index: 2;
    width: 800px;
    text-align: center;

    .word {
      // color: rgba(255,255,255,.8);
      margin-right: 20px;
      // font-size: 18px;
    }
  }

  .bottom {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    bottom: 10px;
    text-align: center;
    font-size: 12px;
    color: #999999;

    .top1 {
      letter-spacing: 2px;
    }
  }
}
</style>
