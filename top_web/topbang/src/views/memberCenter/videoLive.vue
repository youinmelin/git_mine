<template>
  <div class="main">
    <el-card>
      <div class="title">
        <svg-icon icon-class="arrow-down"/>
        视频直播
      </div>
      <el-form ref="form" class="form" :model="form" label-width="80px" label-position="top">

        <el-form-item label="直播标题">
          <el-input type="text" maxlength="30" v-model="formList.title" placeholder="输入直播标题" show-word-limit/>
        </el-form-item>
        <el-form-item label="直播平台">
          <el-select v-model="formList.platformId" placeholder="点击选择">
            <el-option label="平台一" value="1"/>
            <el-option label="平台二" value="2"/>
          </el-select>
        </el-form-item>
        <el-form-item label="直播链接">
          <el-input type="text" v-model="formList.liveLink" placeholder="输入直播的地址链接"/>
        </el-form-item>

        <el-form-item label="视频封面设置（格式jpeg、png，文件大小<5MB）">
          <el-upload
            label="视频封面设置（格式jpeg、png，文件大小<5MB）"
            class="avatar-uploader"
            :action="uploadUrl"
            :show-file-list="false"
            list-type="picture"
            :with-credentials="true"
            :before-upload="beforeImageUpload"
            :on-success="handleImageScucess"
          >
            <img v-if="formList.videoImgUrl" :src="formList.videoImgUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"/>
          </el-upload>
        </el-form-item>

        <el-form-item label="所属行业">
          <el-cascader
            class="el-select"
            placeholder="点击选择"
            v-model="formList.industryId"
            :options="industryList"
            :show-all-levels="false"
            :props="{ value: 'id', label: 'name'}"
            @change="handleCascader"/>
        </el-form-item>
        <el-form-item label="可应用行业（可选三个）">
          <el-cascader
            class="el-select"
            placeholder="点击选择"
            v-model="input1"
            :options="industryList"
            :show-all-levels="false"
            :props="{ value: 'id', label: 'name'}"
            @change="handleCascader"/>
          <el-cascader
            class="el-select"
            placeholder="点击选择"
            v-model="input2"
            :options="industryList"
            :show-all-levels="false"
            :props="{ value: 'id', label: 'name'}"
            @change="handleCascader"/>
          <el-cascader
            class="el-select"
            placeholder="点击选择"
            v-model="input3"
            :options="industryList"
            :show-all-levels="false"
            :props="{ value: 'id', label: 'name'}"
            @change="handleCascader"/>
        </el-form-item>

        <el-form-item label="标签">
          <div class="inputTags">
            <span v-if="!inputTags.length" class="placeholder">每个标签之间用；隔开</span>

            <el-tag
              v-for="tag in inputTags"
              :key="tag"
              class="tag"
              effect="plain"
              type="info"
              size="mini"
              closable
              @close="handleClose(tag)"
            >
              {{ tag }}
            </el-tag>
          </div>
          <span>推荐标签</span>
          <el-tag
            v-for="tag in dynamicTags"
            :key="tag"
            class="tag"
            effect="plain"
            type="info"
            @click="handleAdd(tag)"
          >
            {{ tag }}
          </el-tag>
        </el-form-item>

        <el-form-item label="价格">
          <el-input
            v-model="formList.price"
            oninput="value=value.replace(/[^0-9.]/g,'')"
            placeholder="0.00"
            class="price">
            <template slot="prepend">￥</template>
          </el-input>
          元
        </el-form-item>
        <el-form-item label="是否支持定制">
          <el-radio-group v-model="formList.isCustom">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="0">否</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="购买链接">
          <el-input type="text" v-model="formList.buyUrl" placeholder="请填写购买地址"/>
        </el-form-item>

        <el-form-item label="软件试用下载（选填）">
          <el-input type="text" v-model="formList.downloadUrl" placeholder="请填写试用软件的下载地址"/>
        </el-form-item>

        <el-form-item label="商品描述" prop="content" style="margin-bottom: 30px;">
          <textarea :id="tinymceId" class="tinymce-textarea"/>
          <div class="editor-custom-btn-container">
            <editorImage color="#1890ff" class="editor-upload-btn" @successCBK="imageSuccessCBK"/>
          </div>
        </el-form-item>
        <el-form-item>
          <el-button type="danger" :loading="loading" @click="submitForm()">发布直播</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import editorImage from '@/components/Tinymce/components/EditorImage'
import plugins from '@/components/Tinymce/plugins'
import toolbar from '@/components/Tinymce/toolbar'
import load from '@/components/Tinymce/dynamicLoadScript'
import { releaseVideoLive } from '@/api/product'
import { getIndustry } from '@/api/common'

const tinymceCDN = 'https://cdn.jsdelivr.net/npm/tinymce-all-in-one@4.9.3/tinymce.min.js'

export default {
  components: { editorImage },
  props: {
    id: {
      type: String,
      default: function() {
        return 'vue-tinymce-' + +new Date() + ((Math.random() * 1000).toFixed(0) + '')
      }
    },
    value: {
      type: String,
      default: ''
    },
    toolbar: {
      type: Array,
      required: false,
      default() {
        return []
      }
    },
    menubar: {
      type: String,
      default: 'file edit insert view format table'
    },
    height: {
      type: [Number, String],
      required: false,
      default: 360
    },
    width: {
      type: [Number, String],
      required: false,
      default: 'auto'
    }
  },
  data() {
    return {
      loading: false,
      imageLoading: false,
      uploadUrl: process.env.VUE_APP_BASE_API + '/web/upload/oss/video',
      dynamicTags: ['人工智能', '扫地机器人', '家电'],
      inputTags: [],
      inputVisible: true,
      inputValue: '',
      tinymceId: 'hhhhhh',
      hasChange: false,
      hasInit: false,
      fullscreen: false,
      languageTypeList: {
        'en': 'en',
        'zh': 'zh_CN',
        'es': 'es_MX',
        'ja': 'ja'
      },
      form: {
        diy: ''
      },
      industryList: [],
      input1: '',
      input2: '',
      input3: '',
      input4: '',
      imageUrl: '',
      formList: {
        title: '',
        platformId: '',
        liveLink: '',
        videoImgUrl: '',
        industryId: '',
        price: '',
        isCustom: 1,
        buyUrl: '',
        downloadUrl: '',
        content: ''
      }
    }
  },
  computed: {
    containerWidth() {
      const width = this.width
      if (/^[\d]+(\.[\d]+)?$/.test(width)) { // matches `100`, `'100'`
        return `${width}px`
      }
      return width
    }
  },
  watch: {
    value(val) {
      if (!this.hasChange && this.hasInit) {
        this.$nextTick(() =>
          window.tinymce.get(this.tinymceId).setContent(val || ''))
      }
    }
  },
  mounted() {
    this.init()
    // 获取行业
    this.getIndustry()
  },
  activated() {
    if (window.tinymce) {
      this.initTinymce()
    }
  },
  deactivated() {
    this.destroyTinymce()
  },
  destroyed() {
    this.destroyTinymce()
  },
  methods: {
    // 提交表单
    submitForm() {
      // 校验数据
      if (this.formList.title === null || this.formList.title === '') {
        this.$message.info('直播标题不能为空')
        return false
      }
      if (this.formList.platformId === null || this.formList.platformId === '') {
        this.$message.info('请选择直播平台')
        return false
      }
      if (this.formList.liveLink === null || this.formList.liveLink === '') {
        this.$message.info('直播链接不能为空')
        return false
      }
      if (this.formList.videoImgUrl === null || this.formList.videoImgUrl === '') {
        this.$message.info('请上传视频封面')
        return false
      }
      if (this.formList.industryId === null || this.formList.industryId === '') {
        this.$message.info('所属行业不能为空')
        return false
      }
      if (this.formList.price === null || this.formList.price === '') {
        this.$message.info('价格不能为空')
        return false
      }
      if (this.formList.buyUrl === null || this.formList.buyUrl === '') {
        this.$message.info('购买链接不能为空')
        return false
      }
      if (this.getContent() === null || this.getContent() === '') {
        this.$message.info('商品描述不能为空')
        return false
      }
      // 行业
      this.formList.industryId = this.formList.industryId[this.formList.industryId.length - 1]
      // 应用行业
      this.formList.industryList = []
      if (this.input1) {
        this.formList.industryList.push(this.input1[this.input1.length - 1])
      }
      if (this.input2) {
        this.formList.industryList.push(this.input2[this.input2.length - 1])
      }
      if (this.input3) {
        this.formList.industryList.push(this.input3[this.input3.length - 1])
      }
      this.formList.content = this.getContent()
      // 发布直播信息
      releaseVideoLive(this.formList).then(response => {
        if (response.data.code === 0) {
          this.$alert('发布成功', '提示', {
            confirmButtonText: '确定',
            callback: action => {
              this.loading = false
              this.$router.push('/memberCenter/videoLiveList')
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
    // 获取行业
    getIndustry() {
      getIndustry().then(response => {
        if (response.data.code === 0) {
          this.industryList = response.data.data
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
    init() {
      // dynamic load tinymce from cdn
      load(tinymceCDN, (err) => {
        if (err) {
          this.$message.error(err.message)
          return
        }
        this.initTinymce()
      })
    },
    initTinymce() {
      const _this = this
      window.tinymce.init({
        selector: `#${this.tinymceId}`,
        language: this.languageTypeList['zh'],
        height: this.height,
        body_class: 'panel-body ',
        object_resizing: false,
        toolbar: this.toolbar.length > 0 ? this.toolbar : toolbar,
        menubar: this.menubar,
        plugins: plugins,
        end_container_on_empty_block: true,
        powerpaste_word_import: 'clean',
        code_dialog_height: 450,
        code_dialog_width: 1000,
        advlist_bullet_styles: 'square',
        advlist_number_styles: 'default',
        imagetools_cors_hosts: ['www.tinymce.com', 'codepen.io'],
        default_link_target: '_blank',
        link_title: false,
        branding: false,
        nonbreaking_force_tab: true, // inserting nonbreaking space &nbsp; need Nonbreaking Space Plugin
        init_instance_callback: editor => {
          if (_this.value) {
            editor.setContent(_this.value)
          }
          _this.hasInit = true
          editor.on('NodeChange Change KeyUp SetContent', () => {
            this.hasChange = true
            this.$emit('input', editor.getContent())
          })
        },
        setup(editor) {
          editor.on('FullscreenStateChanged', (e) => {
            _this.fullscreen = e.state
          })
        },
        // it will try to keep these URLs intact
        // https://www.tiny.cloud/docs-3x/reference/configuration/Configuration3x@convert_urls/
        // https://stackoverflow.com/questions/5196205/disable-tinymce-absolute-to-relative-url-conversions
        convert_urls: false,
        images_upload_handler: function(blobInfo, success, failure) {
          var xhr, formData

          xhr = new XMLHttpRequest()
          xhr.withCredentials = false
          xhr.open('POST', process.env.VUE_APP_BASE_API + '/web/upload/oss/video')
          // 配置Header
          // xhr.setRequestHeader('accessToken', layui.data([layui.setter.tableName])[layui.setter.request.tokenName])

          xhr.onload = function() {
            var json
            if (xhr.status !== 200) {
              failure('HTTP Error: ' + xhr.status)
              return
            }
            json = JSON.parse(xhr.responseText)
            // 如果解析不了就抛出异常
            if (!json) {
              failure('Invalid JSON: ' + xhr.responseText)
              return
            }
            // 成功就回传URL路径
            success(json.data.src)
          }
          formData = new FormData()
          formData.append('file', blobInfo.blob(), blobInfo.filename())
          xhr.send(formData)
        }
      })
    },
    destroyTinymce() {
      const tinymce = window.tinymce.get(this.tinymceId)
      if (this.fullscreen) {
        tinymce.execCommand('mceFullScreen')
      }
      if (tinymce) {
        tinymce.destroy()
      }
    },
    setContent(value) {
      window.tinymce.get(this.tinymceId).setContent(value)
    },
    getContent() {
      return window.tinymce.get(this.tinymceId).getContent()
    },
    imageSuccessCBK(arr) {
      arr.forEach(v => window.tinymce.get(this.tinymceId).insertContent(`<img class="wscnph" src="${v.url}" >`))
    },
    // handleClose(tag) {
    //   this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1)
    // },
    handleClose(tag) {
      this.inputTags.splice(this.inputTags.indexOf(tag), 1)
      this.dynamicTags.splice(0, 0, tag)
    },
    handleAdd(tag) {
      this.inputTags.splice(0, 0, tag)
      this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1)
    },

    showInput() {
      this.inputVisible = true
      this.$nextTick(_ => {
        this.$refs.saveTagInput.$refs.input.focus()
      })
    },

    handleInputConfirm() {
      const inputValue = this.inputValue
      if (inputValue) {
        this.dynamicTags.push(inputValue)
      }
      this.inputVisible = false
      this.inputValue = ''
    },
    handleRemove(file, fileList) {
      console.log(file, fileList)
    },
    handlePreview(file) {
      console.log(file)
    },
    handleChange(file, fileList) {
      this.fileList = fileList
      // 每次更新都要初始化，防止报错
      this.formList.videoList = []
      // 这里传到后端没法直接用，所以要用另一个参数来代替
      for (let i = 0; i < this.fileList.length; i++) {
        this.formList.videoList.push(this.fileList[i].response.data.src)
      }
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
        this.formList.videoImgUrl = res.data.src
        this.imageLoading = false
      }
    },
    // 三级联动下拉
    handleCascader(value) {
      // console.log(value)
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

  .tag {
    margin: 0 10px;
  }
}

.form {
  margin-top: 20px;

  .label {
    line-height: 40px;
    font-size: 14px;
    font-weight: 700;
    color: #606266;

    .grey {
      font-size: 12px;
      font-weight: 500;
      color: #999;
    }
  }

  .el-select {
    margin-right: 20px;
  }

  .price {
    width: 300px;
    margin-right: 10px;
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

.inputTags {
  background-color: #fff;
  background-image: none;
  border-radius: 4px;
  border: 1px solid #dcdfe6;
  box-sizing: border-box;
  color: #606266;
  display: inline-block;
  font-size: inherit;
  height: 40px;
  line-height: 40px;
  outline: 0;
  padding: 0 15px;
  transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
  width: 100%;
  margin: 0 0 10px 0;

  .placeholder {
    color: #999;
  }
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
