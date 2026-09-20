import request from '@/utils/request'

// 查询上报分类列表
export function listClassify(query) {
  return request({
    url: '/report/classify/list',
    method: 'get',
    params: query
  })
}

// 查询上报分类详细
export function getClassify(id) {
  return request({
    url: '/report/classify/' + id,
    method: 'get'
  })
}

// 新增上报分类
export function addClassify(data) {
  return request({
    url: '/report/classify',
    method: 'post',
    data: data
  })
}

// 修改上报分类
export function updateClassify(data) {
  return request({
    url: '/report/classify',
    method: 'put',
    data: data
  })
}

// 删除上报分类
export function delClassify(id) {
  return request({
    url: '/report/classify/' + id,
    method: 'delete'
  })
}

// 获取上报类型select下拉数据
export function getReportClassifySelectList() {
  return request({
    url: '/report/classify/getReportClassifySelectList',
    method: 'get'
  })
}
