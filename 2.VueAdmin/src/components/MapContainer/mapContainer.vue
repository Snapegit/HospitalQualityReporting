<template>
  <div id="app">
    <div id="container">
      <el-amap
        vid="amapDemo"
        :center="centerMap"
        :mapStyle="mapStyle"
        :zoom="zoom"
        :events="events"
        class="amap-demo"
      >
        <el-amap-marker
          ref="marker"
          vid="component-marker"
          :position="marker.position"
          v-for="(marker, index) in markers"
          :key="index"
          :icon="marker.icon"
        ></el-amap-marker>
      </el-amap>
    </div>
    <!--提供地图容器-->
  </div>
</template>
<script>
export default {
  name: "app",
  data() {
    return {
      zoom: 16,
      markers: [],
      centerMap: [125.379227, 43.861677],
      mapStyle: "darkblue",
      events: {
        init(o) {
          o.setMapStyle("amap://styles/darkblue"); //自定义的高德地图的样式，我选的是马卡龙
        },
      },
      mapInfo: {
        address: "吉林省长春市南关区临河街道中日联谊医院",
        lng: 125.379227,
        lat: 43.861677,
        lnglat: [125.379227, 43.861677],
      },
      map: null, //存入amap对象 关于当前地图的所有操作 都在该节点上
    };
  },
  created() {},
  methods: {
    addMarker(item) {
        console.log(item)
      this.centerMap = item.position;
      this.markers = [];
      this.markers.push({
        position: item.position,
        icon: item.icon, //不设置默认蓝色水滴
      });
    },
  },
};
</script>
<style  scope>
#container {
  width: 100%;
  height: 100%;
}
.anchorBL,
.amap-logo {
  visibility: hidden;
  display: none !important;
}
.el-vue-amap-container {
  height: 100% !important;
}
</style>