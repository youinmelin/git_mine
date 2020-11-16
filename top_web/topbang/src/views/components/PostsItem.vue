<template>
  <div class="main">
    <div class="list">
      <div class="cell">
        <div class="bot">
          <div class="col-1">
            <div>
              <p>{{ content.title }}</p>
            </div>
          </div>
          <div class="col-2"></div>
          <div class="col-3">
            <div></div>
            <div class="grey curpp"></div>
          </div>
          <div class="col-4">
            <el-button type="text" @click="$router.push({path:'/postInfo',query:{id:content.id}})">查看详情</el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    // 是否展示底部
    showBottom: {
      type: Boolean,
      default: false
    },
    // 底部样式，默认1
    bottomStyle: {
      type: Number,
      default: 1
    },
    content: {
      type: Object,
      default: {}
    },
    width: {
      type: Number,
      default: 210
    },
    height: {
      type: Number,
      default: 118
    }
  },
  data() {
    return {
      page: {
        currentPage: 1,
        total: 0
      },
      listQuery: {
        page: 1,
        limit: 10,
        status: '',
        strSearch: ''
      }
    }
  },
  methods: {}
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

  .badge {
    background: crimson;
    color: #fff;
    padding: 0 4px;
    border-radius: 20px;
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

  .col-1 {
    text-align: center;
  }
}

.list {
  .col-1 {
    display: flex;
    align-items: center;
  }

  .cell {
    //border: 1px solid #f0f0f0;
    margin-bottom: 20px;
  }

  .top {
    line-height: 40px;
    padding: 0 2%;
    background-color: #f0f0f0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #666;
    font-size: 15px;

    span {
      color: #000;
      font-weight: 600;
    }
  }

  .bot {
    height: 120px;
    padding-left: 2%;
    display: flex;
    align-items: center;

    img {
      width: 80px;
      height: 80px;
      object-fit: cover;
      margin-right: 10px;
    }

    .num {
      font-size: 12px;
      color: #999;
      margin-right: 20px;
    }
  }
}

.col-1 {
  width: 35%;

  .select {
    width: 150px;
  }
}

.col-2 {
  text-align: center;
  width: 30%;
}

.col-3 {
  text-align: center;
  width: 20%;
}

.col-4 {
  width: 10%;
  text-align: right;
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
