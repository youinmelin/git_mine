<template>
  <div class="main">
    <el-card class="el-card">
      <div class="title">
        <svg-icon icon-class="arrow-down" />经营数据
      </div>
      <div class="header">
        <div class="grey">统计时间 2020-08-26 15:26:13</div>
        <el-tabs v-model="value1" type="card">
          <el-tab-pane label="实时" name="first" />
          <el-tab-pane label="1日" name="second" />
          <el-tab-pane label="1周" name="third" />
          <el-tab-pane label="1月" name="fourth" />
        </el-tabs>
      </div>
      <div class="content">
        <div class="title">数据总览</div>
        <div class="cards">
          <div v-for="item in list1" :key="item.id" class="card-1">
            <div class="top">{{ item.title }}</div>
            <div class="row">
              <span class="grey">{{ item.sub1 }}</span>
              <span>{{ item.num1 }}</span>
            </div>
            <div class="row">
              <span class="grey">{{ item.sub2 }}</span>
              <span><i class="el-icon-top red" />{{ item.num2 }}</span>
            </div>
          </div>
          <div v-for="item in list2" :key="item.id" class="card-2">
            <div class="top">{{ item.title }}</div>
            <div class="bold">{{ item.num1 }}</div>
            <div class="row">
              <span class="grey">{{ item.sub1 }}</span>
              <span><i class="el-icon-top red" />{{ item.num2 }}</span>
            </div>
          </div>
        </div>
        <!-- 线性图 -->
        <div id="chart1" style="width: 100%; height: 500px;" />
      </div>
    </el-card>

    <el-card class="el-card">
      <div class="content">
        <div class="title">流量来源TOP</div>
        <el-table :data="data1" style="width: 100%">
          <el-table-column type="index" label="排名" width="300px" />
          <el-table-column prop="name" label="来源分享" width="450px" />
          <el-table-column prop="num" label="访客数" />
        </el-table>
      </div>
    </el-card>

    <el-card class="el-card">
      <div class="content">
        <div class="title">产品流量TOP</div>
        <el-table :data="data2" style="width: 100%">
          <el-table-column type="index" label="排名" width="80" />
          <el-table-column prop="name" label="产品" width="300">
            <template slot-scope="scope">
              <div class="row">
                <img class="img" :src="scope.row.src" alt="">
                <p>{{ scope.row.name }}</p>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="num1" label="访客数" />
          <el-table-column prop="num2" label="占比" />
          <el-table-column prop="num3" label="试用数" />
          <el-table-column prop="num4" label="转化率" />
        </el-table>
      </div>
    </el-card>

    <el-card class="el-card">
      <div class="content">
        <div class="title">访客时段分布</div>
        <el-date-picker v-model="value2" class="picker" type="date" placeholder="选择日期" />
        <div id="chart2" style="width: 100%; height: 500px;" />

        <div class="tip">
          <i class="el-icon-bell yellow" />
          时段分布解读 近七天日均访客数最多的时段为：<span class="yellow">21:00~21:59</span>。找准访客高峰时段，果断上新呀！
        </div>
        <div class="title">访客地域分布</div>
        <el-date-picker v-model="value2" class="picker" type="date" placeholder="选择日期" />
        <el-row>
          <el-col :span="12">
            <span class="red">●</span>
            访客数占比排行
            <el-table :data="data3" class="table" style="width: 100%">
              <el-table-column prop="name" label="地域" />
              <el-table-column prop="num1" label="访客数" width="150">
                <template>
                  <el-progress :text-inside="true" :percentage="60" :color="'#F56C6C'" />
                </template>
              </el-table-column>
              <el-table-column prop="num2" label="转化率" />
            </el-table>
          </el-col>
          <el-col :span="12">
            <span class="red">●</span>
            试用人数占比排行
            <el-table :data="data3" style="width: 100%">
              <el-table-column prop="name" label="地域" />
              <el-table-column prop="num1" label="访客数" width="150">
                <template>
                  <el-progress :text-inside="true" :percentage="60" :color="'#F56C6C'" />
                </template>
              </el-table-column>
              <el-table-column prop="num2" label="转化率" />
            </el-table>
          </el-col>
        </el-row>

        <div class="title">访客特征分布</div>
        <el-date-picker v-model="value2" class="picker" type="date" placeholder="选择日期" />
        <el-row>
          <el-col :span="12">
            <span class="red">●</span>
            访客类型
            <el-table :data="data4" class="table" style="width: 100%">
              <el-table-column prop="name" label="地域" />
              <el-table-column prop="num1" label="访客数" width="150">
                <template>
                  <el-progress :text-inside="true" :percentage="60" :color="'#E6A23C'" />
                </template>
              </el-table-column>
              <el-table-column prop="num2" label="占比" />
              <el-table-column prop="num2" label="转化率" />
            </el-table>
          </el-col>
          <el-col :span="12">
            <span class="red">●</span>
            新老访客
            <el-table :data="data4" style="width: 100%">
              <el-table-column prop="name" label="地域" />
              <el-table-column prop="num1" label="访客数" width="150">
                <template>
                  <el-progress :text-inside="true" :percentage="60" :color="'#E6A23C'" />
                </template>
              </el-table-column>
              <el-table-column prop="num2" label="占比" />
              <el-table-column prop="num2" label="转化率" />
            </el-table>
          </el-col>
        </el-row>
      </div>
    </el-card>
  </div>
</template>

<script>
import echarts from 'echarts'
export default {
  data() {
    return {
      value1: 'first',
      value2: '',
      list1: [
        { id: 1, title: '访问主页', sub1: '访客数', sub2: '较前日同时段', num1: 123, num2: 11 },
        { id: 2, title: '访问产品', sub1: '商品访客数', sub2: '较前日同时段', num1: 123, num2: 22 },
        { id: 3, title: '访问主页', sub1: '试用人数', sub2: '较前日同时段', num1: 23, num2: 1 }
      ],
      list2: [
        { id: 4, title: '访客数', sub1: '较前日同时段', num1: 123, num2: 11 },
        { id: 5, title: '浏览量', sub1: '较前日同时段', num1: 123, num2: 11 },
        { id: 6, title: '人均浏览量', sub1: '较前日同时段', num1: 123, num2: 11 }
      ],
      data1: [
        { name: '页面搜索', num: 40 },
        { name: '转发分享', num: 40 },
        { name: '首页banner分享', num: 40 },
        { name: '直通车', num: 40 },
        { name: '用户推荐推广', num: 40 }
      ],
      data2: [
        { name: '扫地机器人1C智能家用全自动扫拖一体机拖地吸尘器三合一', num1: 40, num2: '23.45%', num3: 20, num4: '50.00%', src: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg' },
        { name: '扫地机器人1C智能家用全自动扫拖一体机拖地吸尘器三合一', num1: 40, num2: '23.45%', num3: 20, num4: '50.00%', src: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg' },
        { name: '扫地机器人1C智能家用全自动扫拖一体机拖地吸尘器三合一', num1: 40, num2: '23.45%', num3: 20, num4: '50.00%', src: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg' },
        { name: '扫地机器人1C智能家用全自动扫拖一体机拖地吸尘器三合一', num1: 40, num2: '23.45%', num3: 20, num4: '50.00%', src: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg' },
        { name: '扫地机器人1C智能家用全自动扫拖一体机拖地吸尘器三合一', num1: 40, num2: '23.45%', num3: 20, num4: '50.00%', src: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg' }
      ],
      data3: [
        { name: '浙江省', num1: 3000, num2: '10.01%' },
        { name: '浙江省', num1: 3000, num2: '10.01%' },
        { name: '浙江省', num1: 3000, num2: '10.01%' },
        { name: '浙江省', num1: 3000, num2: '10.01%' },
        { name: '浙江省', num1: 3000, num2: '10.01%' }
      ],
      data4: [
        { name: '企业', num1: 3000, num2: '10.01%' },
        { name: '个人', num1: 3000, num2: '10.01%' }
      ],
      option1: {
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['昨日访客数', '今日访客数']
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: ['00:00', '02:00', '04:00', '06:00', '08:00', '10:00', '12:00']
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            name: '昨日访客数',
            type: 'line',
            stack: '总量',
            smooth: true,
            data: [120, 132, 101, 934, 90, 230, 210]
          },
          {
            name: '今日访客数',
            type: 'line',
            smooth: true,
            stack: '总量',
            data: [820, 932, 901, 934, 1290, 1330, 1320]
          }
        ]
      },
      option2: {
        tooltip: {
          trigger: 'axis'
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: ['0', '1', '2', '3', '4', '5', '6']
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            name: '该时段访客数',
            type: 'line',
            smooth: true,
            data: [120, 132, 101, 534, 90, 230, 210]
          }
        ]
      }
    }
  },
  mounted() {
    const Chart1 = echarts.init(document.getElementById('chart1'))
    Chart1.setOption(this.option1)
    const Chart2 = echarts.init(document.getElementById('chart2'))
    Chart2.setOption(this.option2)
  },
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
  .grey {
    color: #888;
  }
  .red {
    color: crimson;
  }
  .yellow{
    color: rgb(250, 154, 65);
  }
  .tip {
    line-height: 2;
    margin-bottom: 50px;
  }
  .right {
    float: right;
  }
  .picker {
    margin: 10px 0 20px 0;
  }
  .table{
    margin-bottom: 50px;
  }
}
.el-card {
  margin-bottom: 30px;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #f0f0f0;
  height: 60px;
  padding: 0 20px;
  margin: 20px 0;
}
.content {
  padding: 0 20px;
  .img {
    width: 80px;
    height: 80px;
    margin-right: 10px;
    object-fit: cover;
  }
  .title {
    line-height: 2;
    border-bottom: 1px solid #f5f5f5;
    margin: 10px 0 20px 0;
  }
  .row {
    display: flex;
  }
}
.cards {
  display: flex;
  flex-wrap: wrap;
  margin: 20px 0;
  .top {
    line-height: 2;
  }
  .row {
    display: flex;
    justify-content: space-between;
    line-height: 2;
    font-size: 15px;
  }
  .card-1 {
    border: 2px solid #f0f0f0;
    width: 250px;
    padding: 15px 20px;
    margin: 0 20px 20px 0;
  }
  .card-2 {
    border: 2px solid #f0f0f0;
    width: 200px;
    padding: 15px 20px;
    margin: 0 20px 20px 0;
  }
}
</style>
<style>
.el-tabs--card > .el-tabs__header .el-tabs__item {
  margin-right: 10px;
  border: 1px solid rgb(175, 175, 175) !important;
  padding: 0 10px !important;
}
.el-tabs--card > .el-tabs__header .el-tabs__nav {
  border: none;
}
.el-tabs--card > .el-tabs__header .el-tabs__item.is-active {
  border: 1px solid crimson !important;
}
.el-tabs--card > .el-tabs__header {
  border: none;
  margin: 0;
}
.el-tabs__item {
  height: 30px;
  line-height: 30px;
}
</style>
