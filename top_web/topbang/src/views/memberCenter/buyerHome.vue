<template>
  <div class="main">
    <el-card class="card">
      <div class="header">
        <div class="info">
          <img class="avatar" src="@/assets/pics/scroll-banner.png">
          <div>
            <div class="name">{{ personalInfo.name }}</div>
            <div class="icons">
              <img class="item" src="@/assets/icons/email.png">
              <img class="item" src="@/assets/icons/phone.png">
              <img class="item" src="@/assets/icons/member.png">
              <el-tag type="info" size="mini">已认证</el-tag>
            </div>
          </div>
        </div>
        <div class="money">
          <div>余额</div>
          <div class="num">30000.00 元</div>
          <el-button type="text">充值</el-button>
        </div>
      </div>
    </el-card>

    <el-row class="row">
      <el-col :span="17" class="col-1">

        <!-- 我的试用 -->
        <el-card class="card card-1">
          <div slot="header" class="clearfix" @click="$router.push('/memberCenter/tryout')">
            <span>我的试用</span>
            <el-button style="float: right; padding: 3px 0" type="text">
              全部试用
              <svg-icon icon-class="arrow-right"/>
            </el-button>
          </div>
          <div class="icons" @click="$router.push('/memberCenter/tryout')">
            <div class="item">
              <img src="@/assets/icons/deal-4.png" alt="">
              <div>申请中
                <el-button type="text">{{ productTrialCount.status0 }}</el-button>
              </div>
            </div>
            <div class="item">
              <img src="@/assets/icons/deal-4.png" alt="">
              <div>试用中
                <el-button type="text">{{ productTrialCount.status1 }}</el-button>
              </div>
            </div>
            <div class="item">
              <img src="@/assets/icons/deal-4.png" alt="">
              <div>待评价
                <el-button type="text">{{ productTrialCount.status1 }}</el-button>
              </div>
            </div>
            <div class="item">
              <img src="@/assets/icons/deal-4.png" alt="">
              <div>已评价
                <el-button type="text">{{ productTrialCount.status3 }}</el-button>
              </div>
            </div>
          </div>
          <div class="list">
            <div v-for="(item,index) in list" :key="index" class="cell">
              <div class="left">
                <el-image class="img" :src="item.src" fit="cover"/>
                <div class="info">
                  <div>{{ item.title }}</div>
                  <div class="time">{{ item.time }}</div>
                </div>
              </div>
              <div class="btn">
                <el-button type="text">查看详情</el-button>
                <el-button type="text">|</el-button>
                <el-button type="text">查看评价</el-button>
              </div>
            </div>
          </div>
        </el-card>

        <!-- 猜你喜欢 -->
        <el-card class="card card-2">
          <div slot="header" class="clearfix">
            <span>猜你喜欢</span>
            <el-button style="float: right; padding: 3px 0" type="text">
              换一组
              <i class="el-icon-refresh"/>
            </el-button>
          </div>
          <div class="videos">
            <el-card
              v-for="item in contentData"
              :key="item.id"
              class="video-card"
              :body-style="{ padding: '0px' }"
            >
              <VideoItem :content="item" :show-bottom="true" :bottom-style="2"/>
            </el-card>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6" class="col-2">

        <!-- 我的消息 -->
        <el-card class="card card-3">
          <div slot="header" class="clearfix" @click="$router.push('/memberCenter/allMsgs')">
            <span>我的消息</span>
            <el-button style="float: right; padding: 3px 0" type="text">
              <svg-icon icon-class="arrow-right"/>
            </el-button>
          </div>
          <div v-for="item in msgData" :key="item.id" class="msg">
            <i class="el-icon-message"/>
            <span>{{ item.title }}
              <svg-icon icon-class="arrow-right"/></span>
          </div>
        </el-card>
        <!-- 我看过的 -->
        <el-card class="card card-4">
          <div slot="header" class="clearfix" @click="$router.push('/memberCenter/videoHistory')">
            <span>我看过的</span>
            <el-button style="float: right; padding: 3px 0" type="text">
              <svg-icon icon-class="arrow-right"/>
            </el-button>
          </div>
          <div class="videos">
            <el-card
              v-for="item in browseHistoryList"
              :key="item.id"
              class="video-card"
              :body-style="{ padding: '0px' }"
            >
              <VideoItem :content="item" :show-bottom="true" :bottom-style="2"/>
            </el-card>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import VideoItem from './../components/VideoItem'
import { getBuyerIndex } from '@/api/manage'

export default {
  components: {
    VideoItem
  },
  data() {
    return {
      list: [],
      contentData: [],
      msgData: [],
      personalInfo: {},
      browseHistoryList: [],
      productTrialCount: []
    }
  },
  created() {
    this.getBuyerIndex()
  },
  methods: {
    getBuyerIndex() {
      // 买家中心首页
      getBuyerIndex().then(response => {
        if (response.data.code === 0) {
          this.personalInfo = response.data.data.personalInfo
          this.contentData = response.data.data.productList
          this.msgData = response.data.data.noticeList
          this.list = response.data.data.productTrialList
          this.browseHistoryList = response.data.data.browseHistoryList
          this.productTrialCount = response.data.data.productTrialCount
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
.main {
  width: 970px;
}

.header {
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;

  .info {
    width: 280px;
    padding: 35px 0 42px 0;
    display: flex;
    align-items: center;

    .avatar {
      width: 100px;
      height: 100px;
      border-radius: 100px;
      object-fit: cover;
      margin-right: 20px;
    }

    .name {
      font-weight: 600;
      line-height: 2;
    }

    .icons {
      display: flex;
      align-items: center;

      .item {
        margin-right: 8px;
      }
    }
  }

  .money {
    .num {
      font-size: 24px;
      font-weight: 600;
    }
  }
}

.card {
  margin-bottom: 20px;
}

.card-1 {
  .icons {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #f1f1f1;

    .item {
      display: flex;
      flex-direction: column;
      align-items: center;
      font-size: 15px;
    }
  }

  .list {
    .cell {
      margin: 10px 0;
      display: flex;
      align-items: center;
      justify-content: space-between;

      .left {
        display: flex;
        align-items: center;
        color: #888;

        .time {
          font-size: 13px;
          margin-top: 5px;
        }
      }
    }

    .img {
      width: 80px;
      height: 80px;
      margin-right: 20px;
    }
  }
}

.card-2 {
  .videos {
    display: flex;
    flex-wrap: wrap;

    .video-card {
      margin-right: 10px;
    }
  }
}

.card-3 {
  width: 250px;
  float: right;

  .msg {
    margin: 10px 0;
  }
}

.card-4 {
  width: 250px;
  float: right;
}

.card {
  .video-card {
    width: 210px;
    margin-bottom: 10px;
  }
}

.row {
  .col-2 {
    float: right;
  }
}

.el-icon-message {
  margin-right: 5px;
}
</style>
<style lang="scss">
.card-1 .el-card__header {
  border: none !important;
}

.card-2 .el-card__body {
  padding: 20px 0 20px 20px;
}
</style>
