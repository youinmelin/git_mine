<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        账户安全
      </div>
      <el-row class="row">
        <el-col :span="8">
          <div>安全等级</div>
        </el-col>
        <el-col :span="12">
          <el-progress :stroke-width="12" :percentage="100" :format="format" color="#67C23A"/>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>登录密码</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">登录账户时需要输入的密码</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text">重置</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>支付密码</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">支付所购买商品或服务时使用</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text">重置</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>实名认证</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">钟*|3*****************|已认证</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text">查看</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>邮箱</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">zho****@136.com 已绑定</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text">修改</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>手机</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">159******26 已绑定</div>
        </el-col>
        <el-col :span="4">
          <el-button type="text">修改 | 解绑</el-button>
        </el-col>
      </el-row>

      <el-row class="row">
        <el-col :span="8">
          <div>登录记录</div>
        </el-col>
        <el-col :span="12">
          <div class="grey">上次登录网站时间：{{ securityInfo.lastLogin }}</div>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>

export default {
  data() {
    return {
      securityInfo: {
        lastLogin: ''
      }
    }
  },
  created() {
  },
  methods: {
    // 获取安全信息
  }
}
</script>

<style lang="scss" scoped>
.main {
  width: 970px;

  .title {
    font-weight: 600;
  }

  .row {
    line-height: 100px;
    display: flex;
    align-items: center;
  }

  .avatar {
    width: 80px;
    height: 80px;
    border-radius: 100px;
  }

  .grey {
    color: #888;
  }
}
</style>
