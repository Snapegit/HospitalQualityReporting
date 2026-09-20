import AMapLoader from '@amap/amap-jsapi-loader';
export default function MapLoader() { // <-- 原作者这里使用的是module.exports
    return new Promise((resolve, reject) => {
        if (window.AMap) {
            // console.log("已经加载过了");
            resolve(window.AMap)
        } else {
            console.log("加载高德地图");
            AMapLoader.load({
                "key": "e34180734eb8524e4a5bf89b3d62291a", // 申请好的Web端开发者Key，首次调用 load 时必填
                "version": "1.4.15", // 指定要加载的 JSAPI 的版本，缺省时默认为 1.4.15
                "plugins": ['AMap.moveAnimation', 'AMap.ToolBar', 'AMap.Marker', 'AMap.Driving', 'AMap.DistrictSearch', 'AMap.Autocomplete', 'AMap.PlaceSearch', 'AMap.MouseTool', 'AMap.Geocoder', 'AMap.Weather'], // 需要使用的的插件列表，如比例尺'AMap.Scale'等 需要什么就加载什么 不然会消耗性能
                "AMapUI": { // 是否加载 AMapUI，缺省不加载
                    "version": '1.1', // AMapUI 缺省 1.1
                    "plugins": ['overlay/SimpleMarker'], // 需要加载的 AMapUI ui插件
                },
                // "Loca":{ // 是否加载 Loca， 缺省不加载
                // "version": '2.0' // Loca 版本，缺省 1.3.2 注：api版2.0不兼容Loca 2.0版本
                // },
            }).then((AMap) => {
                resolve(AMap)
            }
            ).catch((e) => {
                reject(e)
            }
            )
        }
    })
}