import request from '@/utils/request'

// 查询上报模板列表
export function listTemplate(query) {
  return request({
    url: '/report/template/list',
    method: 'get',
    params: query
  })
}

// 查询上报模板详细
export function getTemplate(id) {
  return request({
    url: '/report/template/' + id,
    method: 'get'
  })
}

// 新增上报模板
export function addTemplate(data) {
  return request({
    url: '/report/template',
    method: 'post',
    data: data
  })
}

// 修改上报模板
export function updateTemplate(data) {
  return request({
    url: '/report/template',
    method: 'put',
    data: data
  })
}

// 删除上报模板
export function delTemplate(id) {
  return request({
    url: '/report/template/' + id,
    method: 'delete'
  })
}

// 复制上报模板
export function copyTemplate(data) {
  return request({
    url: '/report/template/copyTemplateById',
    method: 'get',
    params: data
  })
}

// 获取上报模板列表下拉数据
export function getRepTemplateList() {
  return request({
    url: '/report/template/getRepTemplateList',
    method: 'get'
  })
}
