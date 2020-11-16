import request from '@/utils/request'
/*
通用
 */

// 获取行业
export function getIndustry() {
  return request({
    url: '/web/common/getIndustry',
    method: 'get'
  })
}

// 获取标签
export function getTag() {
  return request({
    url: '/web/common/getTag',
    method: 'get'
  })
}

// 企业账户详情
export function getCompanyInfo() {
  return request({
    url: '/web/common/getCompanyInfo',
    method: 'get'
  })
}

// 获取服务声明
export function getServiceState() {
  return request({
    url: '/web/common/getServiceState',
    method: 'get'
  })
}

// 获取联系我们
export function getContactus() {
  return request({
    url: '/web/common/getContactus',
    method: 'get'
  })
}

// 获取SEO信息
export function getSeo() {
  return request({
    url: '/web/common/getSeo',
    method: 'get'
  })
}

// 获取注册协议
export function getRegAgree() {
  return request({
    url: '/web/common/getRegAgree',
    method: 'get'
  })
}

// 文章列表
export function getPostsList(params) {
  return request({
    url: '/web/common/getPostsList',
    method: 'post',
    data: params
  })
}

// 文章详情
export function getPostInfo(id) {
  return request({
    url: '/web/common/getPostInfo/' + id,
    method: 'get'
  })
}

// 获取注册协议
export function getIndexCategory() {
  return request({
    url: '/web/index/category',
    method: 'get'
  })
}
