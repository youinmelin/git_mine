<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down" />视频购买
      </div>
      <div class="header grey">
        当前可上传视频总数：<span class="red">50</span>个，已试用：<span class="red">36</span>个
<!--        <el-button type="primary" round class="btn" size="mini">查看详情</el-button>-->
      </div>
      <el-form class="form" :model="form" label-width="80px">
        <el-form-item label="购买期限">
          <el-select v-model="form.region" placeholder="请选择期限">
            <el-option label="一个月" value="1" />
            <el-option label="其他" value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="购买数量">
          <el-input-number v-model="num" :min="1" />
        </el-form-item>
        <el-form-item label="总计金额">
          <div>￥<span class="red">1234.56</span>（当前账户余额：￥<span class="green">3.33</span>）</div>
        </el-form-item>

        <el-form-item>
          <el-button type="info">余额不足</el-button>
          <el-button type="text">前往充值</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      num: 1,
      form: {}
    }
  },
  methods: {
    format(percentage) {
      return percentage === 100 ? '高' : `${percentage}%`
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  width: 970px;
  .title {
    font-weight: 600;
  }
  .header{
    line-height: 100px;
    padding-left: 10px;
    .btn{
      margin-left: 20px;
    }
  }
  .green {
    color: #67c23a;
  }
  .blue {
    color: #409eff;
  }
  .grey {
    color: #888;
  }
  .red {
    color: crimson;
    font-size: 24px;
  }
  .form {
    margin-top: 20px;
  }
}
</style>
