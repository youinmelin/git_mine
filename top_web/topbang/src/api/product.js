import request from '@/utils/request'

// 发布直播
export function releaseVideoLive(params) {
  return request({
    url: '/web/product/releaseVideoLive',
    method: 'post',
    data: params
  })
}

// 用户直播列表
export function getVideoLiveList(params) {
  return request({
    url: '/web/product/getVideoLiveList',
    method: 'post',
    data: params
  })
}

// 获取直播详情
export function getVideoLiveInfo(prodId) {
  return request({
    url: '/web/product/getVideoLiveInfo/' + prodId,
    method: 'get'
  })
}

// 发布产品
export function releaseProduct(params) {
  return request({
    url: '/web/product/releaseProduct',
    method: 'post',
    data: params
  })
}

// 用户产品列表
export function getProductList(params) {
  return request({
    url: '/web/product/getProductList',
    method: 'post',
    data: params
  })
}

// 获取产品详情
export function getProductInfo(prodId) {
  return request({
    url: '/web/product/getProductInfo/' + prodId,
    method: 'get'
  })
}

// 编辑时获取产品详情
export function getEditProductInfo(prodId) {
  return request({
    url: '/web/product/getEditProductInfo/' + prodId,
    method: 'get'
  })
}

// 删除产品
export function deleteProduct(prodId) {
  return request({
    url: '/web/product/deleteProduct/' + prodId,
    method: 'get'
  })
}

// 删除直播
export function deleteVideoLive(videoLiveId) {
  return request({
    url: '/web/product/deleteVideoLive/' + videoLiveId,
    method: 'get'
  })
}

// 产品试用申请
export function productGiveTrial(prodId) {
  return request({
    url: '/web/product/productGiveTrial/' + prodId,
    method: 'get'
  })
}

// 用户产品试用列表
export function getProductTrialList(params) {
  return request({
    url: '/web/product/getProductTrialList',
    method: 'post',
    data: params
  })
}

// 产品试用审核
export function auditProductTrial(id, status) {
  return request({
    url: '/web/product/auditProductTrial',
    method: 'post',
    data: { id, status }
  })
}

// 产品试用评价
export function productEvaluate(params) {
  return request({
    url: '/web/product/productEvaluate',
    method: 'post',
    data: params
  })
}

// 产品评价
export function getWebPageProductEvaluate(params) {
  return request({
    url: '/web/product/getWebPageProductEvaluate',
    method: 'post',
    data: params
  })
}

// 产品评价分页
export function getProductEvaluateList(params) {
  return request({
    url: '/web/product/getProductEvaluateList',
    method: 'post',
    data: params
  })
}

// 企业账户详情
export function getCompanyInfo(id) {
  return request({
    url: '/web/common/getCompanyInfo/' + id,
    method: 'get'
  })
}

// 产品浏览记录
export function getProductHistoryList(params) {
  return request({
    url: '/web/product/getProductHistoryList',
    method: 'post',
    data: params
  })
}

// 产品收藏记录
export function getProductCollectionList(params) {
  return request({
    url: '/web/product/getProductCollectionList',
    method: 'post',
    data: params
  })
}

// 产品收藏
export function productCollection(id) {
  return request({
    url: '/web/product/productCollection/' + id,
    method: 'get'
  })
}

// 行业产品
export function getIndustryProdList(id) {
  return request({
    url: '/web/product/getIndustryProdList/' + id,
    method: 'get'
  })
}
