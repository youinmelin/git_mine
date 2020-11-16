<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down" />资金详情
      </div>
      <!-- 金额区域 -->
      <div class="money">
        <div class="col">
          <p>当前可用余额</p>
          <p><span class="red">3000.00</span>元</p>
        </div>
        <div class="col">
          <p>全部余额</p>
          <p><span class="black">13000.00</span>元</p>
        </div>
        <div class="col">
          <p>冻结金额</p>
          <p><span class="black">10000.00</span>元</p>
        </div>

        <div class="col">
          <el-button size="mini" type="danger">充值</el-button>
          <p>账户状态：<span class="green">有效</span></p>
        </div>
      </div>
      <!-- 筛选区域 -->
      <el-row class="header">
        <el-col :span="14">

          <el-tabs>
            <el-tab-pane label="资金明细" />
          </el-tabs>
        </el-col>
        <el-col :span="8">
          <el-input v-model="value1" class="input">
            <el-button slot="append" icon="el-icon-search" />
          </el-input>
        </el-col>
        <el-col :span="2">
          <el-select v-model="value2" placeholder="筛选" class="select">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-col>
      </el-row>

      <div class="label">
        <div class="col-1">时间</div>
        <div class="col-2">金额</div>
        <div class="col-3">操作</div>
        <div class="col-4">备注</div>
      </div>
      <div class="list">
        <div v-for="(item,index) in list" :key="index" class="cell">
          <div class="col-1">{{ item.time }}</div>
          <div class="col-2" :class="[item.num>0?'green':'red']">{{ item.num }}</div>
          <div class="col-3">{{ item.staus }}</div>
          <div class="col-4">充值单号：<span class="blue">{{ item.text }}</span></div>
        </div>
      </div>
    </el-card>
  </div>
</template>
<script>
export default {
  data() {
    return {
      value1: '',
      value2: '',
      options: [],
      list: [
        { time: '2020-08-06 17:15:48', num: -12990756523, staus: '购买视频数量', text: '12990756523' },
        { time: '2020-08-06 17:15:48', num: 12990756523, staus: '充值', text: '12990756523' },
        { time: '2020-08-06 17:15:48', num: 12990756523, staus: '充值', text: '12990756523' },
        { time: '2020-08-06 17:15:48', num: 12990756523, staus: '充值', text: '12990756523' }
      ],
      statusMap: {
        1: '审核中',
        2: '已发布',
        3: '审核失败',
        4: '已下架'
      }
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
  .badge {
    background: crimson;
    color: #fff;
    padding: 0 4px;
    border-radius: 20px;
  }
}
.money {
  height: 150px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 15px;
  color: #555;
  .red {
    font-size: 26px;
    font-weight: 600;
    color: crimson;
  }
  .black {
    font-size: 26px;
    font-weight: 600;
    color: #000;
  }
}
.header {
  .right {
    .input {
      float: right;
      width: 200px;
    }
    .select {
      float: right;
      width: 80px;
    }
  }
}
.label {
  line-height: 40px;
  background-color: #f0f0f0;
  margin-bottom: 20px;
  display: flex;
  align-content: center;
}
.list {
  .cell {
    line-height: 80px;
    display: flex;
    border: 1px solid #f0f0f0;
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
  text-align: center;
  width: 20%;
}
.col-4 {
  width: 40%;
  text-align: center;
}

::v-deep {
  .el-input__inner {
    background: none;
    &::placeholder {
      color: #000;
      text-align: right;
    }
  }
}
</style>
