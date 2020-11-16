<template>
  <div class="main">
    <div class="header">
      <div class="title">
        <img src="@/assets/icons/auth.png" alt="">
        <span>实名认证</span>
      </div>
    </div>
    <div class="form">
      <el-form ref="form" :model="form" label-width="320px">
        <el-form-item label="真实姓名" :rules="[{ required: true}]">
          <el-input placeholder="请填写真实姓名" v-model="formList.name" class="input"/>
        </el-form-item>
        <el-form-item label="证件类型" :rules="[{ required: true}]">
          <el-select v-model="value" placeholder="请选择证件类型" class="input">
            <el-option label="身份证" value="1"/>
            <el-option label="其他" value="2"/>
          </el-select>
        </el-form-item>

        <el-form-item label="证件号码" :rules="[{ required: true}]">
          <el-input placeholder="请填写证件上的号码" v-model="formList.cardno" class="input"/>
        </el-form-item>
        <el-form-item label="证件期限" :rules="[{ required: true}]">
          <el-date-picker
            v-model="formList.startTime"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            class="input"
          />
        </el-form-item>
        <el-form-item label="上传证件照" :rules="[{ required: true}]">
          <el-row>
            <el-upload
              class="avatar-uploader"
              :action="uploadUrl"
              :show-file-list="false"
              list-type="picture"
              :with-credentials="true"
              :before-upload="beforeImageUpload"
              :on-success="handleImageScucess"
            >
              <img v-if="formList.imageUrl" :src="formList.imageUrl" class="avatar">
              <i v-else class="el-icon-picture-outline avatar-uploader-icon"/>
            </el-upload>
            <el-upload
              class="avatar-uploader"
              :action="uploadUrl"
              :show-file-list="false"
              list-type="picture"
              :with-credentials="true"
              :before-upload="beforeImageUpload"
              :on-success="handleImageScucess2"
            >
              <img v-if="formList.imageUrl2" :src="formList.imageUrl2" class="avatar">
              <i v-else class="el-icon-picture-outline avatar-uploader-icon"/>
            </el-upload>
          </el-row>
        </el-form-item>
        <!--        <el-form-item label="手机号码" :rules="[{ required: true}]">-->
        <!--          <span>159******526</span>-->
        <!--        </el-form-item>-->
        <!--        <el-form-item label="手机验证码" :rules="[{ required: true}]">-->
        <!--          <el-input placeholder="请输入手机验证码" style="width:150px" />-->
        <!--          <el-button plain type="danger" class="btn">发送验证码</el-button>-->

        <!--        </el-form-item>-->
      </el-form>
    </div>
  </div>
</template>
<script>
import { realName } from '@/api/login'

export default {
  props: {
    callback: {
      isCallback: ''
    }
  },
  data() {
    return {
      uploadUrl: process.env.VUE_APP_BASE_API + '/web/upload/oss/card',
      imageLoading: false,
      value: '',
      value1: '',
      value2: '',
      form: {},
      formList: {
        imageUrl: '',
        imageUrl2: '',
        name: '',
        cardno: '',
        startTime: '',
        endTime: '',
        validStart: '',
        validEnd: ''
      }
    }
  },
  methods: {
    submitForm() {
      if (this.formList.startTime === null || this.formList.startTime === '') {
        this.$message.info('证件期限不能为空')
        return false
      }
      // 时间参数要处理一下
      this.formList.validStart = this.formList.startTime[0]
      this.formList.validEnd = this.formList.startTime[1]
      realName(this.formList).then(response => {
        if (response.data.code === 0) {
          // 触发父页面回调
          this.$emit('callback', true)
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
        this.formList.imageUrl = res.data.src
        this.imageLoading = false
      }
    },
    handleImageScucess2(res) {
      if (res.code === 0) {
        this.formList.imageUrl2 = res.data.src
        this.imageLoading = false
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.header {
  line-height: 70px;
  display: flex;
  justify-content: center;
  margin-bottom: 50px;

  .title {
    font-size: 26px;
    font-weight: bold;
    display: flex;
    align-items: center;
    border-bottom: 4px solid #c34840;

    img {
      margin-right: 10px;
    }
  }
}

.input {
  width: 300px;
}

.btn {
  margin: 0 10px;
}

.tip {
  .blue {
    color: #409eff;
  }
}

.avatar-uploader {
  width: 120px;
  display: inline-block;
  margin-right: 20px;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}

.avatar {
  width: 120px;
  height: 120px;
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

.el-checkbox__input {
  vertical-align: super;
}
</style>
