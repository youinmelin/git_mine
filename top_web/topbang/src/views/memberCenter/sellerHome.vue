<template>
  <div class="main">
    <el-card class="card">
      <div class="header">
        <div class="info">
          <img class="avatar" :src="userInfo.headImg">
          <div>
            <div class="name" @click="$router.push('/memberCenter/information')">{{ companyInfo.unitName }}<i
              class="el-icon-circle-check"/></div>
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
        <div class="money">
          <div>可上传视频</div>
          <div class="num">10 个</div>
          <el-button type="text" @click="$router.push('/memberCenter/videoBuy')">购买数量</el-button>
        </div>
      </div>
    </el-card>
    <el-row>
      <el-col :span="17">
        <el-card class="card card-4">
          <img class="img" src="@/assets/pics/seller-b1.png" alt="">
        </el-card>
      </el-col>
      <el-col :span="7">
        <!-- 我的消息 -->
        <el-card class="card card-3">
          <div slot="header" @click="$router.push('/memberCenter/allMsgs')">
            <span>我的消息</span>
            <el-button style="float: right; padding: 3px 0" type="text">
              <svg-icon icon-class="arrow-right"/>
            </el-button>
          </div>
          <div v-for="item in msgData" :key="item.id" class="msg">
            <span class="curpp" @click="$router.push('/memberCenter/allMsgs')">{{ item.title }}
              <svg-icon icon-class="arrow-right"/></span>
          </div>
        </el-card>
      </el-col>

    </el-row>
    <el-row class="row">
      <!-- 我的试用 -->
      <el-card class="card card-1">
        <div slot="header" class="clearfix">
          <span>我的试用</span>
          <el-button style="float: right; padding: 3px 0" type="text" @click="$router.push('/memberCenter/tryout')">
            管理全部
            <svg-icon icon-class="arrow-right"/>
          </el-button>
        </div>
        <div class="icons">
          <div class="item">
            <img src="@/assets/icons/deal-4.png" alt="">
            <div>未处理的申请
              <el-button type="text" @click="$router.push('/memberCenter/tryout')">5</el-button>
            </div>
          </div>
          <div class="item">
            <img src="@/assets/icons/deal-4.png" alt="">
            <div>试用中的产品
              <el-button type="text" @click="$router.push('/memberCenter/tryout')">5</el-button>
            </div>
          </div>
          <div class="item">
            <img src="@/assets/icons/deal-4.png" alt="">
            <div>待评价的试用
              <el-button type="text" @click="$router.push('/memberCenter/tryout')">5</el-button>
            </div>
          </div>
          <div class="item">
            <img src="@/assets/icons/deal-4.png" alt="">
            <div>已评价的试用
              <el-button type="text" @click="$router.push('/memberCenter/tryout')">5</el-button>
            </div>
          </div>
        </div>
      </el-card>

      <!-- 我的发布 -->
      <el-card class="card card-2">
        <div slot="header" class="clearfix">
          <span>我的发布</span>
          <el-button style="float: right; padding: 3px" type="text" @click="$router.push('/memberCenter/videoPosted')">
            管理全部<i class="el-icon-setting"/>
          </el-button>
          <el-button style="float: right; padding: 3px" type="text" @click="$router.push('/memberCenter/videoRelease')">
            发布<i class="el-icon-upload2"/>
          </el-button>
        </div>
        <div class="videos">
          <el-card
            v-for="item in contentData"
            :key="item.id"
            class="video-card"
            :body-style="{ padding: '0px' }"
          >
            <VideoItem :content="item"/>
            <div class="info">
              <span>{{ item.name }}</span>
              <div class="bottom">
                <div>
                  <!--                  <el-button type="text">编辑</el-button>-->
                  <el-button type="text" @click="$router.push({path:'/productMain',query:{id:item.id}})">查看详情
                  </el-button>
                </div>
                <i class="el-icon-delete" @click="deleteVideo(item.id)"/>
              </div>
            </div>
          </el-card>
        </div>
      </el-card>
    </el-row>
  </div>
</template>
<script>
import VideoItem from './../components/VideoItem'
import { getSellerIndex } from '@/api/manage'
import { deleteProduct } from '@/api/product'

export default {
  components: {
    VideoItem
  },
  data() {
    return {
      contentData: [],
      userInfo: {},
      companyInfo: {},
      msgData: []
    }
  },
  created() {
    this.getSellerIndex()
  },
  methods: {
    getSellerIndex() {
      // 卖家中心首页
      getSellerIndex().then(response => {
        if (response.data.code === 0) {
          this.userInfo = response.data.data.userInfo
          this.companyInfo = response.data.data.companyInfo
          this.contentData = response.data.data.productList
          this.msgData = response.data.data.noticeList
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
    // 删除产品
    deleteVideo(prodId) {
      this.$confirm('此操作将永久删除该产品, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteProduct(prodId).then(response => {
          if (response.data.code === 0) {
            // 不用刷新全部
            this.getSellerIndex()
            this.$message({
              type: 'success',
              message: '删除成功!'
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
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    }
  }
}
</script>
<style lang="scss" scoped>
.main {
  width: 970px;
}

.el-icon-circle-check {
  color: rgb(26, 98, 231);
}

.header {
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;

  .info {
    width: 380px;
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
      cursor: pointer;
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
      font-weight: 600;
    }
  }
}

.card-4 {
  padding: 0;
  height: 190px;

  img {
    width: 100%;
    display: block;
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

    .item {
      display: flex;
      align-items: center;
      font-size: 15px;

      img {
        margin-right: 10px;
      }
    }
  }
}

.card-2 {
  .videos {
    display: flex;
    flex-wrap: wrap;

    .video-card {
      margin-right: 15px;
    }
  }
}

.card-3 {
  width: 95%;
  float: right;
  height: 190px;
}

.card {
  .info {
    padding: 10px;

    .bottom {
      display: flex;
      align-items: center;
      justify-content: space-between;

      .money {
        font-size: 24px;
        color: orange;
      }
    }
  }

  .video-card {
    width: 210px;
    margin-bottom: 15px;
  }
}
</style>
<style lang="scss">
.card-1 .el-card__header {
  border: none !important;
}
</style>
