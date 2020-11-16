<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down" />在线客服
      </div>
      <div class="row">
        <div class="col">
          <svg-icon class="service" icon-class="service" />
          <span class="name">在线客服1</span>
          <el-button type="primary" size="mini">前往咨询</el-button>
        </div>
        <div class="col">
          <svg-icon class="service" icon-class="service" />
          <span class="name">在线客服2</span>
          <el-button type="primary" size="mini">前往咨询</el-button>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  methods: {
  }
}
</script>

<style lang="scss" scoped>
.main {
  width: 970px;
  .title {
    font-weight: 600;
  }
  .avatar {
    width: 80px;
    height: 80px;
    border-radius: 100px;
  }
  .grey {
    color: #888;
  }
  .service {
    font-size: 50px;
  }
  .row{
    display: flex;
    align-items: center;
    margin-top: 50px;
    .col{
      display: flex;
      align-items: center;
      margin-right: 50px;
    }
    .name{
      margin: 0 20px;
    }
  }
}
</style>
