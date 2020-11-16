import request from '@/utils/request'
/*
用户
 */

// 企业账户详情
export function getCompanyInfo() {
  return request({
    url: '/web/user/getCompanyInfo',
    method: 'get'
  })
}

// 账户安全信息
export function getSecurity() {
  return request({
    url: '/web/user/getSecurity',
    method: 'get'
  })
}

// 账户安全信息
export function getNoticeList(params) {
  return request({
    url: '/web/notice/getNoticeList',
    method: 'post',
    data: params
  })
}

// 账户安全信息
export function resetPassword(params) {
  return request({
    url: '/web/user/setPasswd',
    method: 'post',
    data: params
  })
}

// 修改公司简介
export function updateCompanyContent(params) {
  return request({
    url: '/web/user/updateCompanyContent',
    method: 'post',
    data: params
  })
}

// 修改用户头像
export function updateHeadImg(params) {
  return request({
    url: '/web/user/updateHeadImg',
    method: 'post',
    data: params
  })
}

// 用户实名认证
export function realName(params) {
  return request({
    url: '/web/user/realName',
    method: 'post',
    data: params
  })
}

// 修改邮箱
export function updateEmail(params) {
  return request({
    url: '/web/user/updateEmail',
    method: 'post',
    data: params
  })
}

// 修改手机号
export function updatePhone(params) {
  return request({
    url: '/web/user/updatePhone',
    method: 'post',
    data: params
  })
}
