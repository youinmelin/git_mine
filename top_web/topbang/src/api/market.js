import request from '@/utils/request'
/*
营销
 */

// banner 购买
export function buyBanner(params) {
  return request({
    url: '/web/banner/buyBanner',
    method: 'post',
    data: params
  })
}

// 推广banner列表
export function marketBannerList(params) {
  return request({
    url: '/web/banner/marketBannerList',
    method: 'post',
    data: params
  })
}
