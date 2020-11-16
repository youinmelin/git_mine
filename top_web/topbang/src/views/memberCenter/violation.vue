<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down" />违规记录
      </div>
      <div class="label">
        <div class="col-1">时间</div>
        <div class="col-2">违规类型</div>
        <div class="col-3">违规详情</div>
        <div class="col-4">状态</div>
      </div>
      <div class="list">
        <div v-for="(item,index) in list" :key="index" class="cell">
          <div class="col-1">{{ item.time }}</div>
          <div class="col-2">{{ item.type }}</div>
          <div class="col-3">{{ item.text }}</div>
          <div class="col-4">{{ item.status }}</div>
        </div>
      </div>
    </el-card>
  </div>
</template>
<script>
export default {
  data() {
    return {
      list: [
        { time: '2020-08-06 17:15:48', type: '诈骗信息', text: '详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容', status: '违规视频已删除' },
        { time: '2020-08-06 17:15:48', type: '诈骗信息', text: '详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容', status: '违规视频已删除' },
        { time: '2020-08-06 17:15:48', type: '诈骗信息', text: '详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容', status: '违规视频已删除' },
        { time: '2020-08-06 17:15:48', type: '诈骗信息', text: '详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容', status: '违规视频已删除' },
        { time: '2020-08-06 17:15:48', type: '诈骗信息', text: '详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容详情内容', status: '违规视频已删除' }
      ]
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
  .grey {
    font-size: 15px;
    color: #888;
    margin: 0;
  }

  .green {
    color: #67c23a;
  }
  .blue {
    color: #409eff;
  }
  .red {
    color: #f56c6c;
  }
}
.label {
  line-height: 40px;
  background-color: #f0f0f0;
  margin-bottom: 20px;
  display: flex;
  align-content: center;
  margin-top: 20px;
  .col-3 {
    text-align: center;
  }
}
.list {
  .cell {
    line-height: 80px;
    display: flex;
    align-items: center;
    border-bottom: 1px solid #f0f0f0;
    padding: 5px 0;
    .col-3 {
      text-align: left;
      line-height: 1.5;
    }
  }
}

.col-1 {
  text-align: center;
  width: 20%;
}
.col-2 {
  text-align: center;
  width: 20%;
}
.col-3 {
  width: 40%;
}
.col-4 {
  width: 20%;
  text-align: center;
}
</style>
