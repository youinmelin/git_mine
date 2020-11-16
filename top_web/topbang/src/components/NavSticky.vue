<template>
  <div class="nav-sticky" id="expandList">
    <div class="sticky" :class="{'sticky-pos': stickyEnabled, 'hidden': hide}" :style="{top: top + 'px'}">
      <div class="main">
        <div class="industry" :class="{'expand-active': expand}" @click="expandList">
          <svg-icon class="nav-icon" icon-class="list"/>
          <span>行业</span>
          <svg-icon class="nav-down" icon-class="arrow-down"/>
        </div>
        <!-- 展开项 -->
        <div class="expand-list" v-show="expand" @mouseenter="closeExpand">
          <div class="el-left">
            <p
              v-for="(item) in menuList"
              :key="item.id"
              class="el-item"
              :class="{'el-item-active': activeMenu && activeMenu.id === item.id}"
              @mouseenter="activeMenu = item"
            >
              {{ item.name }}
              <svg-icon class="arrow-right" icon-class="arrow-right"/>
            </p>
            <p class="el-item all" @mouseenter="activeMenu = null">
              所有分类
              <svg-icon class="arrow-right" icon-class="arrow-right"/>
            </p>
          </div>
          <div class="el-right" v-if="activeMenu && activeMenu.children.length > 0">
            <div v-for="item in activeMenu.children" :key="item.id" class="d-item">
              <p class="title">{{ item.name }}</p>
              <p
                v-for="(child, index) in item.children"
                :key="index"
                @click="$router.push({path: '/industry',query:{id:item.id}})">
                {{ child.name }}</p>
            </div>
          </div>
        </div>
        <!-- nav 其他项 -->
        <div
          v-for="(m, index) in menu"
          :key="index"
          class="other curpp"
          @click="$router.push({path:'/industry',query:{id:m.categoryId}})">
          {{ m.categoryName }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getIndexCategory, getIndustry } from '@/api/common'

export default {
  props: {
    // 滚动到多少距离吸顶
    sticky: {
      type: Number,
      default: 0
    },
    top: {
      type: Number,
      default: 0
    },
    // 初次渲染是否展示
    hide: {
      type: Boolean,
      default: false
    }
  },
  created() {
    this.getIndustry()
    this.getIndexCategory()
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll)
    window.addEventListener('click', this.clickClose)
    document.getElementById('expandList').addEventListener('click', (e) => {
      e.stopPropagation()
    })
  },
  data() {
    return {
      menu: [],
      stickyEnabled: false,
      expand: false,
      activeMenu: null,
      menuList: []
    }
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.handleScroll)
    window.removeEventListener('click', this.clickClose)
  },
  methods: {
    // 获取行业
    getIndustry() {
      getIndustry().then(response => {
        if (response.data.code === 0) {
          this.menuList = response.data.data
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
    handleScroll() {
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop
      if (scrollTop > this.sticky) {
        console.log('sticky')
        this.stickyEnabled = true
      } else {
        this.stickyEnabled = false
      }
    },
    closeExpand() {
      // this.expand = false
      this.activeMenu = null
    },
    expandList() {
      this.expand = !this.expand
    },
    clickClose(e) {
      this.expand = false
    }
  }
}
</script>

<style lang="scss" scoped>
p {
  cursor: pointer;
}

.sticky {
  position: absolute;
  top: 50px;
  width: 100%;
  height: 60px;
  background: #ffffff;
  box-shadow: 2px 2px 5px #d9d9d9;
  z-index: 3;

  .main {
    position: relative;
    width: 1200px;
    margin: 0 auto;

    .industry {
      display: inline-block;
      position: relative;
      width: 138px;
      height: 100%;
      line-height: 60px;
      padding-left: 20px;

      &:hover, &.expand-active {
        color: #c34840;
        cursor: pointer;
      }

      &:after {
        position: absolute;
        content: '';
        width: 1px;
        height: 20px;
        background: #cccccc;
        top: 20px;
        right: 0;
        opacity: 1;
      }
    }

    .expand-active {
      position: relative;

      &:after {
        opacity: 0;
      }

      &:before {
        top: 10px;
        left: 0;
        position: absolute;
        display: block;
        content: '';
        width: 134px;
        height: 50px;
        border: 1px solid #eeeeee;
        border-bottom: none;
      }
    }

    .other {
      display: inline-block;
      height: 100%;
      line-height: 60px;
      margin-left: 50px;
    }

    .nav-link {
      text-decoration: none;
      color: #333333;

      &:hover {
        color: #C34840;
      }
    }

    .nav-icon {
      width: 24px;
      height: 15px;
      margin-right: 9px;
    }

    .nav-down {
      width: 10px;
      margin-left: 10px;
    }
  }
}

.hidden {
  opacity: 0;
}

.sticky-pos {
  position: fixed;
  top: 0;
  z-index: 3;
  opacity: 1;
}

.expand-list {
  position: absolute;
  display: flex;
  justify-content: flex-start;
  align-items: top;
  height: 590px;
  top: 60px;
  left: 0;
  background: #ffffff;

  &:before {
    position: absolute;
    content: '';
    left: 135px;
    width: 225px;
    height: 1px;
    background: #eeeeee;
  }

  .el-left {
    width: 360px;
    font-size: 16px;
    color: #333333;
    overflow: hidden;
    background: #ffffff;

    .el-item {
      position: relative;
      box-sizing: content-box;
      width: 335px;
      height: 42px;
      line-height: 42px;
      margin: 0;
      padding-left: 25px;

      &.all {
        color: #388ced;
      }

      .arrow-right {
        float: right;
        font-size: 25px;
        margin-top: 8px;
        margin-right: 15px;
      }

      &:hover, &.el-item-active {
        box-shadow: 0px 0px 7px #d9d9d9;
      }
    }

    .el-item-active::after {
      position: absolute;
      content: '';
      right: 0;
      top: 0;
      width: 5px;
      height: 42px;
      background: #fff;
    }
  }

  .el-right {
    width: 550px;
    height: 590px;
    background: #ffffff;
    box-shadow: 0px 0px 4px #d9d9d9;

    .d-item {
      display: inline-block;
      width: 50%;
      padding-left: 50px;
      font-size: 14px;
      color: #555555;

      .title {
        color: #388ced;
        font-size: 16px;
      }

      &:nth-child(1), &:nth-child(2) {
        margin-bottom: 40px;
      }
    }
  }
}
</style>
