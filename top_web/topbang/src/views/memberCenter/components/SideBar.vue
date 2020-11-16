<template>
  <div class="sideBar">
    <el-menu :default-openeds="defaultOpeneds">
      <el-submenu v-for="(item,i) in menu" :key="i" :index="item.index">
        <template slot="title"><i :class="item.icon"/>{{ item.title }}</template>
        <el-menu-item-group>
          <el-menu-item v-for="(citem,j) in item.sub" :key="j" :index="citem.index">
            <router-link class="item" :to="citem.path" v-text="citem.text"/>
          </el-menu-item>
        </el-menu-item-group>
      </el-submenu>
    </el-menu>
  </div>
</template>
<script>

export default {

  data() {
    return {
      defaultOpeneds: ['1', '2', '3', '4', '5', '6', '7'],
      memu: [],
      // 买家目录
      menu1: [
        {
          title: '用户中心', index: '1', icon: 'el-icon-message', sub: [
            { index: '1-1', path: '/memberCenter/information', text: '个人信息' },
            { index: '1-2', path: '/memberCenter/security', text: '账户安全' }
          ]
        },
        {
          title: '试用管理', index: '2', icon: 'el-icon-menu', sub: [
            { index: '2-1', path: '/memberCenter/tryout', text: '我的试用' },
            { index: '2-2', path: '/memberCenter/comment', text: '我的评价' }
          ]
        },
        {
          title: '我的消息', index: '3', icon: 'el-icon-setting', sub: [
            { index: '3-1', path: '/memberCenter/allMsgs', text: '所有消息' },
            { index: '3-2', path: '/memberCenter/setMsgs', text: '消息设置' }
          ]
        },
        {
          title: '我的关注', index: '4', icon: 'el-icon-setting', sub: [
            { index: '4-1', path: '/memberCenter/videoStar', text: '我的收藏' },
            { index: '4-2', path: '/memberCenter/videoHistory', text: '我的浏览记录' }
          ]
        },
        {
          title: '客户服务', index: '5', icon: 'el-icon-setting', sub: [
            { index: '5-1', path: '/memberCenter/service', text: '在线客服' },
            { index: '5-2', path: '/memberCenter/report', text: '举报中心' }
          ]
        }
      ],
      // 卖家目录
      menu2: [
        {
          title: '用户中心', index: '1', icon: 'el-icon-setting', sub: [
            { index: '1-1', path: '/memberCenter/information', text: '企业信息' },
            { index: '1-2', path: '/memberCenter/security', text: '账户安全' }
          ]
        },
        {
          title: '产品视频管理', index: '2', icon: 'el-icon-setting', sub: [
            { index: '2-1', path: '/memberCenter/videoRelease', text: '发布视频' },
            { index: '2-2', path: '/memberCenter/videoPosted', text: '已发布的视频' },
            { index: '2-3', path: '/memberCenter/tryout', text: '产品试用申请' },
            { index: '2-4', path: '/memberCenter/videoLive', text: '视频直播' },
            { index: '2-5', path: '/memberCenter/videoLiveList', text: '已发布的视频直播' }
          ]
        },
        {
          title: '我的钱包', index: '3', icon: 'el-icon-setting', sub: [
            { index: '3-1', path: '/memberCenter/funding', text: '资金详情' }
          ]
        },
        {
          title: '增值服务', index: '4', icon: 'el-icon-setting', sub: [
            { index: '4-1', path: '/memberCenter/videoBuy', text: '视频购买' },
            { index: '4-2', path: '/memberCenter/marketing', text: '营销推广' }
          ]
        },
        {
          title: '数据中心', index: '5', icon: 'el-icon-setting', sub: [
            { index: '5-1', path: '/memberCenter/statistics', text: '经营数据' }
          ]
        },
        {
          title: '我的消息', index: '6', icon: 'el-icon-setting', sub: [
            { index: '6-1', path: '/memberCenter/allMsgs', text: '所有消息' },
            { index: '6-2', path: '/memberCenter/setMsgs', text: '消息设置' }
          ]
        },
        {
          title: '客户服务', index: '7', icon: 'el-icon-setting', sub: [
            { index: '7-1', path: '/memberCenter/violation', text: '违规记录' },
            { index: '7-2', path: '/memberCenter/service', text: '在线客服' }
          ]
        }
      ]
    }
  },
  created() {
    // 这里取缓存中的数据
    let role = 'buyer'
    if (localStorage.userType) {
      role = localStorage.userType
    }
    // = this.$route.query.seller ? 'seller' : 'buyer'
    this.menu = role === 'seller' ? this.menu2 : this.menu1
    localStorage.role = role
  }
}
</script>
<style lang="scss" scoped>
.sideBar {
  width: 200px;
  margin: 0 30px 30px 0;

  .item {
    display: block;
    padding: 0 40px;
  }
}
</style>
