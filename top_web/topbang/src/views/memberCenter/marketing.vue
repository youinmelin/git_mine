<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        营销推广
      </div>
      <div class="labels">

        <el-tabs>
          <el-tab-pane label="首页banner"/>
          <el-tab-pane>
            <span slot="label">
              超级推荐<sup class="badge">敬请期待</sup>
            </span>
          </el-tab-pane>
          <el-tab-pane>
            <span slot="label">
              直通车<sup class="badge">敬请期待</sup>
            </span>
          </el-tab-pane>
        </el-tabs>
        <div class="grey">
          <router-link to="/memberCenter/marketVideos">
            已购推广<i class="el-icon-arrow-right"/>
          </router-link>
        </div>

      </div>
      <el-form class="form" :model="form" label-width="80px">
        <el-form-item label="上传图片">
          <el-upload
            class="avatar-uploader"
            :action="uploadUrl"
            :show-file-list="false"
            list-type="picture"
            :with-credentials="true"
            :before-upload="beforeImageUpload"
            :on-success="handleImageScucess"
          >
            <img v-if="formList.imgUrl" :src="formList.imgUrl" class="avatar">
            <i v-else class="el-icon-picture-outline avatar-uploader-icon"/>
          </el-upload>
          <span class="grey">格式jpeg、png、文件大小小于5MB,建议尺寸</span>
        </el-form-item>
        <el-form-item label="选择周期">
          <el-select v-model="formList.cycle" placeholder="请选择周期">
            <el-option label="天" value="0"/>
            <el-option label="月" value="1"/>
          </el-select>
        </el-form-item>
        <el-form-item label="选择时长">
          <el-input-number v-model="formList.cycleNum" :min="1"/>
        </el-form-item>
        <el-form-item label="总计金额">
          <div>￥<span class="red">1234.56</span>（当前账户余额：￥<span class="green">3.33</span>）</div>
          <div class="grey"><i class="el-icon-bell yellow"/>推广三个月立享<span class="yellow">3折</span>优惠
            省<span class="yellow">￥33.33</span></div>
        </el-form-item>

        <el-form-item>
          <el-button type="danger" :loading="loading" @click="submitForm">确认购买</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { buyBanner } from '@/api/market'

export default {
  data() {
    return {
      uploadUrl: process.env.VUE_APP_BASE_API + '/web/upload/oss/banner',
      imageLoading: false,
      loading: false,
      num: 1,
      imageUrl: '',
      form: {},
      formList: {
        imgUrl: '',
        cycle: '',
        cycleNum: ''
      }
    }
  },
  methods: {
    submitForm() {
      this.loading = true
      // 购买banner
      buyBanner(this.formList).then(response => {
        if (response.data.code === 0) {
          this.$alert('购买成功', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.loading = false
              return false
            }
          })
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
    // 文件上传
    beforeImageUpload(file) {
      this.imageLoading = true
      const isLt2M = file.size / 1024 / 1024 < 2

      if (!isLt2M) {
        this.$message.error('上传图片大小不能超过 2MB!')
      }
      return isLt2M
    },
    handleImageScucess(res) {
      if (res.code === 0) {
        this.formList.imgUrl = res.data.src
        this.imageLoading = false
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

  .yellow {
    color: rgb(250, 154, 65);
  }

  .form {
    margin-top: 20px;
  }

  .labels {
    background: #f0f0f0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 20px;
    margin: 20px 0;

    .badge {
      background: #b3b2b2;
      color: #555;
      padding: 1px 4px;
      border-radius: 3px;
    }
  }
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
</style>
