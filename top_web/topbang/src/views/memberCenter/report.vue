<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down" />举报中心
      </div>
      <el-form class="form" :model="form" label-width="80px">
        <el-form-item label="举报用户">
          <el-input v-model="form.name" placeholder="请输入举报对方的名称" />
        </el-form-item>
        <el-form-item label="举报类型">
          <el-select v-model="form.region" placeholder="请选择举报类型">
            <el-option label="诈骗信息" value="1" />
            <el-option label="其他" value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="违规链接">
          <el-input v-model="form.name" placeholder="请输入相关违规链接" />
        </el-form-item>
        <el-form-item label="详细说明">
          <el-input type="textarea" placeholder="请输入相关详情" :rows="10" />
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
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
  .form{
    margin-top: 20px;
  }
}
</style>
