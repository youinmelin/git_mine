import request from '@/utils/request'

export function login(name, passwd) {
  return request({
    url: '/web/login',
    method: 'post',
    data: {
      name,
      passwd
    }
  })
}

export function getInfo() {
  return request({
    url: '/web/user/info',
    method: 'post'
  })
}

export function logout() {
  return request({
    url: '/web/login/logout',
    method: 'post'
  })
}

// 发送手机验证码
export function sendPhoneCode(phone) {
  return request({
    url: '/web/login/sendPhoneCode',
    method: 'post',
    data: { phone }
  })
}

// 找回密码手机验证码
export function sendForgetPhoneCode(phone) {
  return request({
    url: '/web/login/sendForgetPhoneCode',
    method: 'post',
    data: { phone }
  })
}

// 注册
export function register(params) {
  return request({
    url: '/web/login/register',
    method: 'post',
    data: params
  })
}

// 忘记密码
export function forgetPasswd(params) {
  return request({
    url: '/web/login/forgetPasswd',
    method: 'post',
    data: params
  })
}

// 实名认证
export function realName(params) {
  return request({
    url: '/web/user/realName',
    method: 'post',
    data: params
  })
}

// 企业实名
export function realCompany(params) {
  return request({
    url: '/web/user/realCompany',
    method: 'post',
    data: params
  })
}
