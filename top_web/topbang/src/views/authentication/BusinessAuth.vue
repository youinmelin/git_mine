<template>
  <div class="main">
    <div class="header">
      <div class="title">
        <img src="@/assets/icons/auth.png" alt="">
        <span>企业认证</span>
      </div>
    </div>
    <div class="form">
      <el-form ref="form" :model="form" label-width="320px">
        <el-form-item label="注册地址" :rules="[{ required: true}]">
          <el-input placeholder="请填写营业执照上的注册地址" v-model="formList.regAddress" class="input"/>
        </el-form-item>
        <el-form-item label="员工规模" :rules="[{ required: true}]">
          <el-input
            type="text"
            placeholder="请填写员工规模"
            v-model="formList.staffSize"
            maxlength="20"
            show-word-limit
            class="input"/>
        </el-form-item>
        <el-form-item label="业务范畴" :rules="[{ required: true}]">
          <el-input placeholder="请按照营业执照上的经营范围填写" v-model="formList.businessScope" class="input"/>
        </el-form-item>
        <el-form-item label="客户群体" :rules="[{ required: true}]">
          <el-input placeholder="请填写企业客户群体" v-model="formList.customerBase" class="input"/>
        </el-form-item>
        <el-form-item label="统一社会信用代码" :rules="[{ required: true}]">
          <el-input placeholder="请填写营业执照上的统一社会信用代码" v-model="formList.socialCreditCode" class="input"/>
        </el-form-item>

        <el-form-item label="经营期限" :rules="[{ required: true}]">
          <el-date-picker
            v-model="formList.expirationDate"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            class="input"
          />
        </el-form-item>
        <el-form-item label="上传营业执照附件" :rules="[{ required: true}]">
          <el-row>
            <el-upload
              class="avatar-uploader"
              :action="uploadUrl"
              :show-file-list="false"
              list-type="picture"
              :with-credentials="true"
              :before-upload="beforeImageUpload"
              :on-success="handleImageScucess0"
            >
              <img v-if="formList.imgUrl" :src="formList.imgUrl" class="avatar">
              <i v-else class="el-icon-picture-outline avatar-uploader-icon"/>
            </el-upload>
          </el-row>
        </el-form-item>
        <el-form-item label="法人姓名" :rules="[{ required: true}]">
          <el-input placeholder="请填写法人姓名" v-model="formList.name" class="input"/>
        </el-form-item>
        <el-form-item label="法人身份证号码" :rules="[{ required: true}]">
          <el-input placeholder="请填写法人身份证号码" v-model="formList.cardNo" class="input"/>
        </el-form-item>
        <el-form-item label="法人身份证期限" :rules="[{ required: true}]">
          <el-date-picker
            v-model="value1"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            class="input"
          />
        </el-form-item>
        <el-form-item label="上传法人身份证" :rules="[{ required: true}]">
          <el-row>
            <el-upload
              class="avatar-uploader"
              :action="uploadUrl"
              :show-file-list="false"
              list-type="picture"
              :with-credentials="true"
              :before-upload="beforeImageUpload"
              :on-success="handleImageScucess1"
            >
              <img v-if="formList.justImgUrl" :src="formList.justImgUrl" class="avatar">
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
              <img v-if="formList.backImgUrl" :src="formList.backImgUrl" class="avatar">
              <i v-else class="el-icon-picture-outline avatar-uploader-icon"/>
            </el-upload>
          </el-row>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>
<script>
import { realCompany } from '@/api/login'

export default {
  props: {
    callback: {
      isCallback: ''
    }
  },
  data() {
    return {
      uploadUrl: process.env.VUE_APP_BASE_API + '/web/upload/oss/card',
      imageUrl: '',
      value: '',
      value1: '',
      value2: '',
      form: {},
      formList: {
        regAddress: '',
        staffSize: '',
        businessScope: '',
        customerBase: '',
        socialCreditCode: '',
        expirationDate: '',
        imgUrl: '',
        name: '',
        cardNo: '',
        validStart: '',
        validEnd: '',
        justImgUrl: '',
        backImgUrl: ''
      }
    }
  },
  methods: {
    submitForm() {
      if (this.formList.expirationDate === null || this.formList.expirationDate === '') {
        this.$message.info('经营期限不能为空')
        return false
      }
      if (this.value1 === null || this.value1 === '') {
        this.$message.info('法人身份期限不能为空')
        return false
      }
      // 经营期限
      this.formList.establishDate = this.formList.expirationDate[0]
      this.formList.expirationDate = this.formList.expirationDate[1]
      // 法人证件有效期
      this.formList.validStart = this.value1[0]
      this.formList.validEnd = this.value1[1]
      realCompany(this.formList).then(response => {
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
    handleImageScucess0(res) {
      if (res.code === 0) {
        this.formList.imgUrl = res.data.src
        this.imageLoading = false
      }
    },
    handleImageScucess1(res) {
      if (res.code === 0) {
        this.formList.justImgUrl = res.data.src
        this.imageLoading = false
      }
    },
    handleImageScucess2(res) {
      if (res.code === 0) {
        this.formList.backImgUrl = res.data.src
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
