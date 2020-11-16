<template>
  <div class="about">
    <Header/>
    <NavSticky :sticky="60"/>
    <div class="main">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>服务声明</el-breadcrumb-item>
      </el-breadcrumb>

      <div class="company-desc">
        <div class="top">
          <div class="name">
            服务声明
          </div>
        </div>
        <div class="desc">
          <div class="content" v-html="serviceState.content">
          </div>
        </div>
      </div>

      <div class="products">
      </div>

    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from '@/components/Header'
import NavSticky from '@/components/NavSticky'
import Footer from '@/components/Footer'
import { getServiceState } from '@/api/common'

export default {
  components: {
    Header,
    Footer,
    NavSticky
  },
  data() {
    return {
      array: [],
      serviceState: {}
    }
  },
  created() {
    this.getServiceState()
  },
  methods: {
    getServiceState() {
      getServiceState().then(response => {
        if (response.data.code === 0) {
          this.serviceState = response.data.data
        } else {
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
