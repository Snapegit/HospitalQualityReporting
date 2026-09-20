
import request from '@/utils/request'

// 查询医院文章数量（可选年份）
export function getAdrs(query) {
  return request({
    url: '/chart/getAdrs',
    method: 'get',
    params: query
  })
}

// 查询上报数量根据月份
export function getAdrsByMonth(query) {
    return request({
      url: '/chart/getAdrsByMonth',
      method: 'get',
      params: query
    })
  }

  // 查询上报数量根据地区
export function getAdrsByAreaAndDate(query) {
    return request({
      url: '/chart/getAdrsByAreaAndDate',
      method: 'get',
      params: query
    })
  }
  // 查询用户列表
export function getUserSelect() {
    return request({
      url: '/chart/getUserSelect',
      method: 'get',
    })
  }

