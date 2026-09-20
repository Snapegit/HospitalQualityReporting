import request from '@/utils/request'

// 根据医院查询数据
export function getExamineByHospital(query) {
  return request({
    url: '/chart/getCheckSize',
    method: 'get',
    params: query
  })
}
// 根据地区查询数据
export function getExamineByArea(query) {
    return request({
      url: '/chart/getCheckSizeByArea',
      method: 'get',
      params: query
    })
}

