import request from '@/utils/request'

export function index() {
  return request({
    url: '/web/index',
    method: 'get'
  })
}

// 搜索
export function strSearch(params) {
  return request({
    url: '/web/index/search',
    method: 'post',
    data: { strSearch: params }
  })
}
