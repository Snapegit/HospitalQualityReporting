import request from '@/utils/request'

// 根据医院查询数据
export function getAdrsByHospital(query) {
  return request({
    url: '/chart/getAdrsByHospital',
    method: 'get',
    params: query
  })
}
// 根据地区查询数据
export function getAdrsByArea(query) {
    return request({
      url: '/chart/getAdrsByArea',
      method: 'get',
      params: query
    })
}
// 根据严重程度查询数据
export function getAdrsBySeverity(query) {
    return request({
      url: '/chart/getAdrsBySeverity',
      method: 'get',
      params: query
    })
}
// 根据药品数量查询数据
export function getAdrsByMedical(query) {
    return request({
      url: '/chart/getAdrsByMedical',
      method: 'get',
      params: query
    })
}
