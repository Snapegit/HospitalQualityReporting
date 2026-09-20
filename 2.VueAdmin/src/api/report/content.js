import request from '@/utils/request'

// 查询医院事件上报列表
export function listContent(query) {
  return request({
    url: '/report/content/list',
    method: 'get',
    params: query
  })
}

// 查询上报事件详情列表
export function detailList(query) {
  return request({
    url: '/report/content/detailList',
    method: 'get',
    params: query
  })
}

// 查询医院事件上报详细
export function getContent(id) {
  return request({
    url: '/report/content/' + id,
    method: 'get'
  })
}

// 新增医院事件上报
export function addContent(data) {
  return request({
    url: '/report/content',
    method: 'post',
    data: data
  })
}

// 修改医院事件上报
export function updateContent(data) {
  return request({
    url: '/report/content',
    method: 'put',
    data: data
  })
}

// 删除医院事件上报
export function delContent(id) {
  return request({
    url: '/report/content/' + id,
    method: 'delete'
  })
}
