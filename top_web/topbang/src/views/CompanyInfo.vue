<template>
  <div class="about">
    <Header/>
    <NavSticky :sticky="60"/>
    <div class="main">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>公司详情</el-breadcrumb-item>
        <el-breadcrumb-item>{{ companyInfo.name }}</el-breadcrumb-item>
      </el-breadcrumb>

      <div class="company-desc">
        <div class="top">
          <div class="name">
            <svg-icon class="renzhen" icon-class="renzhen"/>
            {{ companyInfo.name }}
            <i class="el-icon-share"></i>
          </div>
          <!--          <div class="btn">-->
          <!--            <div class="customer-service">在线客服</div>-->
          <!--            <div class="concat">联系我们</div>-->
          <!--          </div>-->
        </div>
        <div class="desc">
          <div class="name">公司简介</div>
          <div class="content">
            {{ companyInfo.content }}
          </div>
          <div class="peoson">
            <div class="item">
              <img class="icon" src="../assets/icons/person1.png"/>
              <div class="right">
                <div class="rt">联系人</div>
                <div class="rb">{{ companyInfo.unitName }}</div>
              </div>
            </div>
            <div class="item">
              <img class="icon" src="../assets/icons/person2.png"/>
              <div class="right">
                <div class="rt">电话</div>
                <div class="rb">{{ companyInfo.phone }}</div>
              </div>
            </div>
            <div class="item">
              <img class="icon" src="../assets/icons/person3.png"/>
              <div class="right">
                <div class="rt">网址</div>
                <div class="rb"><a href="" target="_blank"></a></div>
              </div>
            </div>
            <div class="item">
              <img class="icon" src="../assets/icons/person4.png"/>
              <div class="right">
                <div class="rt">地址</div>
                <div class="rb">{{ companyInfo.regAddress }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="products">
        <div class="title">公司产品</div>
        <div class="list-content">
          <div v-for="(item, index) in productList" :key="index" class="wrap">
            <VideoItem :content="item" :show-bottom="true" :bottom-style="2"/>
          </div>
          <!-- 分页 -->
<!--          <div class="pagination">-->
<!--            <el-pagination-->
<!--              background-->
<!--              layout="prev, pager, next"-->
<!--              :total="1000">-->
<!--            </el-pagination>-->
<!--          </div>-->
        </div>
      </div>

    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from '@/components/Header'
import NavSticky from '@/components/NavSticky'
import Footer from '@/components/Footer'
import VideoItem from './components/VideoItem'
import { getCompanyInfo } from '@/api/product'

export default {
  components: {
    Header,
    Footer,
    NavSticky,
    VideoItem
  },
  data() {
    return {
      array: [],
      companyInfo: {},
      productList: []
    }
  },
  created() {
    this.getCompanyInfo()
  },
  methods: {
    getCompanyInfo() {
      getCompanyInfo(this.$route.query.id).then(response => {
        if (response.data.code === 0) {
          this.companyInfo = response.data.data.companyInfo
          this.productList = response.data.data.productList
        } else {
          this.$alert('当前登录信息已失效，请重新登录', '错误', {
            confirmButtonText: '确定',
            type: 'warning',
            callback: action => {
              this.$router.push('/login')
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

<style>
.el-pagination.is-background .el-pager li:not(.disabled).active {
  background: none;
  color: #C34840;
}

.el-pagination.is-background .el-pager li:not(.disabled):hover {
  color: #C34840
}
</style>
<style lang="scss" scoped>
.about {
  background: #F2F2F2;
  padding-top: 125px;

  .main {
    width: 1200px;
    margin-left: auto;
    margin-right: auto;
  }

  .company-desc {
    margin-top: 30px;
    width: 100%;
    background: #ffffff;
    padding: 16px 30px;

    .top {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-bottom: 19px;
      border-bottom: 1px solid #EEEEEE;

      .name {
        font-size: 20px;
        color: #000000;
        font-weight: bold;

        .renzhen {
          font-size: 24px;
        }

        .el-icon-share {
          color: #A3A3A3;
          margin-left: 20px;
        }
      }

      .btn {
        width: 220px;
      }

      .customer-service, .concat {
        display: inline-block;
        width: 100px;
        height: 28px;
        border: 2px solid #c34840;
        border-radius: 4px;
        text-align: center;
        font-size: 16px;
      }

      .customer-service {
        color: #C34840;
        margin-right: 20px;
      }

      .concat {
        color: #ffffff;
        background: #C34840;
      }
    }

    .desc {
      margin-top: 20px;

      .name {
        font-size: 16px;
        color: #333333;
        font-weight: bold;
        line-height: 24px;
      }

      .content {
        font-size: 14px;
        color: #333333;
        line-height: 24px;
        margin-top: 10px;
      }
    }

    .peoson {
      margin-top: 30px;
      display: flex;

      .item {
        display: flex;
        align-items: center;
        margin-right: 80px;

        &:last-child {
          margin-right: 0;
        }

        .icon {
          width: 50px;
          height: 50px;
        }

        .right {
          margin-left: 10px;

          .rt {
            font-size: 16px;
            color: #333333;
            font-weight: bold;
          }

          .rb {
            font-size: 14px;
            color: #333333;

            a {
              text-decoration: none;
              color: #388CED;
            }
          }
        }
      }
    }
  }

  .products {
    margin-top: 50px;
    margin-bottom: 50px;

    .title {
      font-size: 30px;
      color: #333333;
      font-weight: bold;
    }

    .list-content {
      display: flex;
      flex-wrap: wrap;
      padding: 20px;
      background: #ffffff;

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
}

.pagination {
  width: 100%;
  text-align: right;
}
</style>
