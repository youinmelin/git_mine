<template>
  <div class="about">
    <Header/>
    <NavSticky :sticky="60"/>
    <div class="main">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>{{ categoryMap[listQuery.categoryId] }}</el-breadcrumb-item>
      </el-breadcrumb>

      <div class="products">
        <div class="title">{{ categoryMap[listQuery.categoryId] }}</div>
        <div class="list-content">
          <div v-for="(item, index) in list" :key="index" class="wrap">
            <PostsItem :content="item" :show-bottom="true" :bottom-style="2"/>
          </div>
          <!-- 分页 -->
          <div class="pagination">
            <el-pagination
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
              background
              layout="prev, pager, next"
              :total="page.total">
            </el-pagination>
          </div>
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
import PostsItem from '@/views/components/PostsItem'
import { getPostsList } from '@/api/common'

export default {
  components: {
    PostsItem,
    Header,
    Footer,
    NavSticky
  },
  data() {
    return {
      list: [],
      companyInfo: {},
      title: '',
      page: {
        currentPage: 1,
        total: 0
      },
      listQuery: {
        page: 1,
        limit: 10,
        status: '',
        strSearch: '',
        categoryId: 0
      },
      categoryMap: {
        1: '帮助中心',
        2: '媒体报道',
        3: '常见问题'
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.listQuery.categoryId = this.$route.query.id
      // 获取文章列表
      getPostsList(this.listQuery).then(response => {
        if (response.data.code === 0) {
          this.list = response.data.data.list
          this.page.total = response.data.data.total
          this.loading = false
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
    // 每页显示条目数点击事件
    handleSizeChange(val) {
      this.listQuery.limit = val
      this.listQuery.page = 1
      this.fetchData()
    },
    // 分页点击事件
    handleCurrentChange(val) {
      this.listQuery.page = val
      this.fetchData()
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
