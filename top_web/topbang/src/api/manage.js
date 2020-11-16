import request from '@/utils/request'

// 卖家中心首页
export function getSellerIndex(params) {
  return request({
    url: '/web/manage/getSellerIndex',
    method: 'get'
  })
}

// 买家中心首页
export function getBuyerIndex() {
  return request({
    url: '/web/manage/getBuyerIndex',
    method: 'get'
  })
}
