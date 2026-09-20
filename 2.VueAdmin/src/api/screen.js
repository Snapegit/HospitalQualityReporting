import request from '@/utils/request'

// 获取文章数量
export function getArticleCount() {
    return request({
        url: '/report/screen/getArticleCount',
        method: 'get'
    })
}

// 获取医院地区数量
export function getHospitalCount() {
    return request({
        url: '/report/screen/getHospitalCount',
        method: 'get'
    })
}

// 获取地区具体的医院数量统计
export function getOriginCount() {
    return request({
        url: '/report/screen/getOriginCount',
        method: 'get'
    })
}

// 获取所有的医院数量统计
export function getHospitalPosition() {
    return request({
        url: '/report/screen/getHospitalPosition',
        method: 'get'
    })
}

// 获取上报排名列表数据
export function getReportRank() {
    return request({
        url: '/report/screen/getReportRank',
        method: 'get'
    })
}

