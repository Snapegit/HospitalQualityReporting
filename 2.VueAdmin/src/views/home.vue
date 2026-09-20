<template>
  <div class="home">
    <div class="h-header">
      <div class="titleImg">
        <img src="../assets/images/home/header.png" alt="" />
      </div>
    </div>
    <div class="indexBtn" @click="returnIndex">返回首页</div>
    <div class="h-content">
      <div class="hc-left">
        <div class="report-rank">
          <div class="rr-title">上报排名</div>
          <div class="rr-select">
            <div
              class="rrs-up"
              @click="handleUp(0)"
              :class="rankIndex == 0 ? 'rank-active' : ''"
            >
              升序
            </div>
            <div
              class="rrs-down"
              @click="handleUp(1)"
              :class="rankIndex == 1 ? 'rank-active' : ''"
            >
              降序
            </div>
          </div>
          <div class="rr-list">
            <div
              v-for="(item, index) in reportRankList"
              :key="index"
              class="rrl-item"
            >
              <div class="rrli-top">
                <div class="rrlit-left">
                  <div class="i-index" :class="index < 2 ? 'former-two' : ''">
                    No.{{ index + 1 }}
                  </div>
                  <div class="i-title">{{ item.title }}</div>
                </div>
                <div class="rrlit-right">
                  <span>{{ item.num }}</span
                  >/条
                </div>
              </div>
              <div class="rrli-bottom">
                <el-progress
                  :percentage="item.percent"
                  :stroke-width="8"
                ></el-progress>
              </div>
            </div>
          </div>
        </div>
        <div class="report-list">
          <div class="rl-title">上报列表</div>
          <div class="rl-list">
            <div class="table-header">
              <el-row style="width: 100%">
                <el-col :span="12">
                  <div class="th-title">名称</div>
                </el-col>
                <el-col :span="12">
                  <div class="th-num">数量</div>
                </el-col>
              </el-row>
            </div>
            <ul class="listUl">
              <li
                class="listLi"
                v-for="(item, index) in reportList"
                :key="index"
              >
                <el-row style="width: 100%">
                  <el-col :span="12">
                    <div class="listTitle">{{ item.title }}</div>
                  </el-col>
                  <el-col :span="12">
                    <div class="listNum">{{ item.num }}条</div>
                  </el-col>
                </el-row>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="hc-center">
        <div class="hc-container">
          <div class="hc-hospital-selects">
            <div
              @click="handleHospitalSelect(index)"
              :class="hospitalSelectIndex == index ? 'hos-select' : ''"
              class="hospital-select"
              v-for="(item, index) in hospitalSelects"
              :key="index"
            >
              <div class="hs-left"></div>
              <div class="hs-right">
                <div class="hsr-title">{{ item.num }}</div>
                <div class="hsr-num">{{ item.title }}</div>
              </div>
            </div>
          </div>

          <map-container
            ref="mapContainer"
            style="width: 100%; height: 87vh"
          ></map-container>
          <div class="shadowContainer"></div>
        </div>
      </div>
      <div class="hc-right">
        <div class="hospital-list">
          <div class="hl-title">医院网群</div>
          <div class="rl-list">
            <div class="table-header">
              <el-row style="width: 100%">
                <el-col :span="12">
                  <div class="th-title">名称</div>
                </el-col>
                <el-col :span="12">
                  <div class="th-num">{{ isShowOrigin ? "数量" : "定位" }}</div>
                </el-col>
              </el-row>
            </div>
            <ul class="listUl">
              <li
                class="listLi"
                v-for="(item, index) in hospitalNetGroup"
                :key="index"
                @click="hospitalMapClick(item)"
              >
                <el-row style="width: 100%">
                  <el-col :span="12">
                    <div class="listTitle">{{ item.title }}</div>
                  </el-col>
                  <el-col :span="12">
                    <div v-show="!isShowOrigin" class="listNum">
                      <div class="map-icon"></div>
                    </div>
                    <div v-show="isShowOrigin" class="listNum">
                      {{ item.num }}
                    </div>
                  </el-col>
                </el-row>
              </li>
            </ul>
          </div>
        </div>
        <div class="file-num">
          <div class="fn-title">文章数量</div>
          <div class="file-num-list">
            <div class="list-row">
              <div class="list-col mb">
                <div class="col-title">国家动态</div>
                <div class="space-line"></div>
                <div class="col-num">
                  <div class="num-content">
                    <span>{{ articleObj.hNewsCentersNum }}</span
                    >个
                  </div>
                </div>
              </div>
              <div class="list-col">
                <div class="col-title">标准规范</div>
                <div class="space-line"></div>
                <div class="col-num">
                  <div class="num-content">
                    <span>{{ articleObj.hStandardNormsNum }}</span
                    >个
                  </div>
                </div>
              </div>
            </div>
            <div class="list-row">
              <div class="list-col mb">
                <div class="col-title">地区动态</div>
                <div class="space-line"></div>
                <div class="col-num">
                  <div class="num-content">
                    <span>{{ articleObj.hRegionalDynamicsNum }}</span
                    >个
                  </div>
                </div>
              </div>
              <div class="list-col">
                <div class="col-title">业内动态</div>
                <div class="space-line"></div>
                <div class="col-num">
                  <div class="num-content">
                    <span>{{ articleObj.hIndustryTrendsNum }}</span
                    >个
                  </div>
                </div>
              </div>
            </div>
            <div class="list-row">
              <div class="list-col mb">
                <div class="col-title">省内质控指南</div>
                <div class="space-line"></div>
                <div class="col-num">
                  <div class="num-content">
                    <span>{{ articleObj.hQualityControlNum }}</span
                    >个
                  </div>
                </div>
              </div>
              <div class="list-col">
                <div class="col-title">资料下载</div>
                <div class="space-line"></div>
                <div class="col-num">
                  <div class="num-content">
                    <span>{{ articleObj.hDataDownloadsNum }}</span
                    >个
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import mapContainer from "../components/MapContainer/mapContainer.vue";
import {
  getArticleCount,
  getHospitalCount,
  getOriginCount,
  getHospitalPosition,
  getReportRank,
} from "../api/screen";
let icon = new AMap.Icon({
  size: new AMap.Size(35, 34),
  image: require("@/assets/images/map-icon.png"),
  imageSize: new AMap.Size(25, 40),
});
export default {
  components: { mapContainer },
  name: "home",
  data() {
    return {
      hospitalNetGroup: [{ title: "吉林大学白求恩第三医院", num: 1 }], // 网群数据
      hospitalNetGroupForOrigin: [], // 网群地区数据
      hospitalNetGroupForHospital: [], // 网群医院数据
      hospitalNetGroupForGeneral: [{ title: "吉林大学白求恩第三医院", num: 1 }], // 网群总院数据
      articleObj: {}, // 文章数量数据
      isShowOrigin: false, // 判断若点击地区，则切换表格标题
      rankIndex: 1,
      hospitalSelectIndex: 0, //地图中间选中样式
      hospitalSelects: [], //中间医院切换
      reportRankList: [], //上报排名列表
      originCount: [],
      reportList: [],
    };
  },
  mounted() {
    this.getArticleCount();
    this.getHospitalCount();
    this.getOriginCount();
    this.getHospitalPosition();
    this.getReportRank();
    this.hospitalMapClick(); //地图默认加载后定位
  },
  methods: {
    getReportRank() {
      getReportRank().then((res) => {
        if (res.code == 200) {
          this.reportRankList = JSON.parse(JSON.stringify(res.data));
          this.reportList = JSON.parse(JSON.stringify(res.data));
          this.rankDelSort(this.reportRankList);
        }
      });
    },
    // 升序
    rankSort(arr) {
      arr.sort(function (a, b) {
        return a.num - b.num;
      });
    },
    // 降序
    rankDelSort(arr) {
      arr.sort(function (a, b) {
        return b.num - a.num;
      });
    },

    hospitalMapClick(item) {
      if (this.hospitalSelectIndex == 1) {
        return;
      }
      this.markers = [];
      let mark = {};
      if (this.hospitalSelectIndex == 0) {
        mark = {
          position: [125.379227, 43.861677],
          icon: icon, //中日联医院
        };
      } else if (this.hospitalSelectIndex == 2) {
        let positions = item.position.split(",");
        mark = {
          position: positions,
          icon: icon, //中日联医院
        };
      }
      this.$refs.mapContainer.addMarker(mark);
    },
    // 医院地区数量接口
    getHospitalCount() {
      getHospitalCount().then((res) => {
        let data = res.data;
        this.hospitalSelects.push({ title: "总院", num: data.generalNum });
        this.hospitalSelects.push({ title: "地区", num: data.regionNum });
        this.hospitalSelects.push({ title: "医院", num: data.hospitalNum });
      });
    },
    getHospitalPosition() {
      getHospitalPosition().then((res) => {
        console.log(res.data);
        if (res.code == 200) {
          this.hospitalNetGroupForHospital = res.data;
        }
      });
    },
    // 文章数量接口
    getArticleCount() {
      getArticleCount().then((res) => {
        if (res.code == 200) {
          this.articleObj = res.data;
        }
      });
    },
    // 获取地区具体的医院数量统计
    getOriginCount() {
      getOriginCount().then((res) => {
        console.log(res);
        this.hospitalNetGroupForOrigin = res.data;
      });
    },
    handleUp(index) {
      this.rankIndex = index;
      if (index == 0) {
        this.rankSort(this.reportRankList);
      } else {
        this.rankDelSort(this.reportRankList);
      }
    },
    handleHospitalSelect(index) {
      console.log(index);
      // 点击地区，则切换标题
      switch (index) {
        case 0:
          this.isShowOrigin = false;
          this.hospitalNetGroup = this.hospitalNetGroupForGeneral;
          break;
        case 1:
          this.isShowOrigin = true;
          this.hospitalNetGroup = this.hospitalNetGroupForOrigin;
          break;
        case 2:
          this.isShowOrigin = false;
          this.hospitalNetGroup = this.hospitalNetGroupForHospital;
          break;
      }
      this.hospitalSelectIndex = index;
    },
    returnIndex() {
      this.$router.push("/index");
    },
  },
};
</script>

<style lang="scss" scoped>
.mb {
  margin-bottom: 2vh;
}
.rank-active {
  background: linear-gradient(90deg, #1890ff 0%, #20fa95 100%);
}
.former-two {
  margin-left: 0 !important;
  text-align: center;
  width: 40px;
  height: 22px;
  line-height: 22px;
  border-radius: 0px 0px 0px 0px;
  opacity: 1;
  border: 1px solid;
  border-image: linear-gradient(
      90deg,
      rgba(24.000000469386578, 144.00000661611557, 254.00000005960464, 1),
      rgba(31.000000052154064, 249.00000035762787, 150.0000062584877, 1)
    )
    1 1;
}
.home {
  height: 100vh;
  width: 100vw;
  overflow: hidden;
  //   background-image: url("../assets/images/home/home-bg.png");
  background: #020814;
  background-size: cover;
  .h-header {
    width: 100vw;
    .titleImg {
      width: 100vw;
      overflow: hidden;
      img {
        width: 100%;
      }
    }
  }
  .h-content {
    margin-top: 40px;
    position: relative;
    .hc-left {
      z-index: 10;
      padding-left: 42px;
      position: absolute;
      width: 24vw;
      left: 0;

      .rr-title,
      .rl-title {
        font-size: 22px;
        font-family: Source Han Sans CN-Bold, Source Han Sans CN;
        font-weight: bold;
        color: #ffffff;
      }

      .report-list {
        margin-top: 3vh;
      }
      .rr-select {
        display: flex;
        justify-content: end;
        margin-top: -4px;
        .rrs-up,
        .rrs-down {
          cursor: pointer;
          line-height: 22px;
          text-align: center;
          width: 36px;
          height: 22px;
          border: 1px solid;
          border-image: linear-gradient(
              90deg,
              rgba(
                24.000000469386578,
                144.00000661611557,
                254.00000005960464,
                1
              ),
              rgba(31.000000052154064, 249.00000035762787, 150.0000062584877, 1)
            )
            1 1;
          font-size: 14px;
          color: #ffffff;
        }
        .rrs-up {
          margin-right: 10px;
        }
      }
      .rr-list {
        margin-top: 10px;
        height: 33vh;
        overflow-x: hidden;
        overflow-y: auto;
        .rrl-item {
          margin-bottom: 20px;
          .rrli-top {
            display: flex;
            justify-content: space-between;
            .rrlit-left {
              display: flex;
              align-items: center;
              font-size: 14px;
              color: #ffffff;
              .i-index {
                margin-right: 8px;
                margin-left: 14px;
              }
            }
            .rrlit-right {
              font-size: 14px;
              margin-right: 10px;
              color: rgba(230, 247, 255, 0.5);
              span {
                color: #ffffff;
              }
            }
          }
          .rrli-bottom {
            margin-top: 10px;
            ::v-deep .el-progress-bar {
              border-radius: 0;
              padding-right: 0;
              margin-right: 0;
            }
            ::v-deep .el-progress__text {
              display: none;
            }
            ::v-deep .el-progress-bar__outer {
              border-radius: 0;
              height: 12px !important;
              background-color: rgba(255, 255, 255, 0.1);
            }
            ::v-deep .el-progress-bar__inner {
              background-color: unset;
              border-radius: 0;
              background-image: linear-gradient(to right, #20fa95, #1890ff);
            }
          }
        }
      }

      //   上报列表
      .rl-list {
        width: 100%;
        margin-top: 15px;
        .table-header {
          display: flex;
          height: 36px;
          align-items: center;
          justify-content: space-around;
          background: linear-gradient(
            360deg,
            #1c3b68 0%,
            rgba(47, 61, 82, 0.0885) 100%
          );
          .th-title,
          .th-num {
            text-align: center;
            font-size: 14px;
            font-weight: 500;
            color: #ffffff;
          }
        }

        .listUl {
          padding-left: 0;
          height: 32vh;
          overflow-y: auto;
          overflow-x: hidden;
          .listLi {
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 44px;
            .listTitle,
            .listNum {
              font-size: 14px;
              font-weight: 500;
              text-align: center;
              color: #ffffff;
            }
            .listTitle {
              //   margin-left: 30px;
            }
            .listNum {
              //   margin-right: 60px;
            }

            &:hover {
              .listTitle,
              .listNum {
                font-weight: 500;
                background-image: linear-gradient(
                  180deg,
                  #e6f7ff 0%,
                  #26a6dd 100%
                );
                -webkit-background-clip: text;
                color: transparent;
              }
              .listTitle {
                position: relative;
                &::before {
                  content: "";
                  display: block;
                  position: absolute;
                  //   left: -10px;
                  // 定义元素宽高
                  width: 16px;
                  height: 15px;
                  top: 3px;
                  // background-image无法引用本地资源，故需要用网络地址
                  background: url("../assets/images/home/li-active.png")
                    no-repeat;

                  background-size: 100% 100%;
                }
              }

              background: linear-gradient(
                270deg,
                rgba(16, 40, 73, 0) 0%,
                #102849 51%,
                rgba(16, 40, 73, 0) 100%
              );
              border: 2px solid;
              border-image: linear-gradient(
                  270deg,
                  rgba(
                    93.00000205636024,
                    144.00000661611557,
                    194.00000363588333,
                    0
                  ),
                  rgba(
                    93.00000205636024,
                    144.00000661611557,
                    194.00000363588333,
                    1
                  ),
                  rgba(
                    93.00000205636024,
                    144.00000661611557,
                    194.00000363588333,
                    0
                  )
                )
                2 2;
            }
          }
        }
      }
    }
    .hc-center {
      position: absolute;
      left: 424px;
      right: 424px;
      .hc-container {
        position: relative;
        .shadowContainer {
          width: 100%;
          height: 100%;
          background: radial-gradient(
            ellipse 60% 60%,
            transparent 60%,
            #020814 100%
          );
          box-shadow: 0 20px 50px 60px #020814 inset;
          pointer-events: none;
          position: absolute;
          top: 0;
          left: 0;
        }
        .hc-hospital-selects {
          position: absolute;
          top: -10px;
          z-index: 2;
          display: flex;
          width: 100%;
          justify-content: center;
          .hospital-select {
            cursor: pointer;
            margin-right: 25px;
            width: 230px;
            height: 94px;
            background: linear-gradient(
              360deg,
              #1c3b68 0%,
              rgba(47, 61, 82, 0.0885) 100%
            );
            display: flex;
            align-items: center;
            .hs-left {
              background: url("../assets/images/home/notactive.png") no-repeat;
              background-size: cover;
              width: 89px;
              height: 71px;
              margin-left: 10px;
            }
            .hs-right {
              margin-left: 10px;
              .hsr-title {
                font-size: 40px;
                font-weight: bold;
                color: #20b4fa;
                text-shadow: 0px 0px 8px rgba(32, 180, 250, 0.58);
              }
              .hsr-num {
                font-size: 18px;
                color: #ffffff;
              }
            }
          }
          & .hos-select {
            background: linear-gradient(
              360deg,
              #00b578 0%,
              rgba(47, 61, 82, 0.0885) 100%
            );
            .hs-left {
              background: url("../assets/images/home/active.png") no-repeat;
            }
            .hsr-title {
              color: #20fa95 !important;
              text-shadow: 0px 0px 8px rgba(32, 250, 149, 0.5804);
            }
          }
        }
      }
    }
    .hc-right {
      position: absolute;
      width: 24vw;
      right: 42px;
      .hl-title,
      .fn-title {
        font-size: 22px;
        font-family: Source Han Sans CN-Bold, Source Han Sans CN;
        font-weight: bold;
        color: #ffffff;
      }
      .hospital-list {
        //   上报列表
        .rl-list {
          width: 100%;
          margin-top: 15px;
          .table-header {
            display: flex;
            height: 36px;
            align-items: center;
            justify-content: space-around;
            background: linear-gradient(
              360deg,
              #1c3b68 0%,
              rgba(47, 61, 82, 0.0885) 100%
            );
            .th-title,
            .th-num {
              text-align: center;
              font-size: 14px;
              font-weight: 500;
              color: #ffffff;
            }
          }

          .listUl {
            padding-left: 0;
            height: 32vh;
            overflow-y: auto;
            overflow-x: hidden;
            .listLi {
              cursor: pointer;
              margin-left: 20px;
              display: flex;
              align-items: center;
              justify-content: space-between;
              height: 44px;
              .listTitle,
              .listNum {
                text-align: center;
                font-size: 14px;
                font-weight: 500;
                color: #ffffff;
              }
              .listTitle {
                // margin-left: 80px;
              }
              .listNum {
                // margin-right: 97px;
              }

              .map-icon {
                background: url("../assets/images/home/map.png") no-repeat;
                width: 18px;
                height: 18px;
                margin: 0 auto;
                background-size: cover;
              }
              &:hover {
                .listTitle {
                  font-weight: 500;
                  background-image: linear-gradient(
                    180deg,
                    #e6f7ff 0%,
                    #26a6dd 100%
                  );
                  -webkit-background-clip: text;
                  color: transparent;
                }
                .map-icon {
                  background: url("../assets/images/home/map-active.png")
                    no-repeat;
                }
                .listTitle {
                  position: relative;
                  &::before {
                    content: "";
                    display: block;
                    position: absolute;
                    left: -20px;
                    // 定义元素宽高
                    width: 16px;
                    height: 15px;
                    top: 3px;
                    // background-image无法引用本地资源，故需要用网络地址
                    background: url("../assets/images/home/li-active.png")
                      no-repeat;

                    background-size: 100% 100%;
                  }
                }

                background: linear-gradient(
                  270deg,
                  rgba(16, 40, 73, 0) 0%,
                  #102849 51%,
                  rgba(16, 40, 73, 0) 100%
                );
                border: 2px solid;
                border-image: linear-gradient(
                    270deg,
                    rgba(
                      93.00000205636024,
                      144.00000661611557,
                      194.00000363588333,
                      0
                    ),
                    rgba(
                      93.00000205636024,
                      144.00000661611557,
                      194.00000363588333,
                      1
                    ),
                    rgba(
                      93.00000205636024,
                      144.00000661611557,
                      194.00000363588333,
                      0
                    )
                  )
                  2 2;
              }
            }
          }
        }
      }
      .file-num-list {
        display: flex;
        justify-content: space-around;
        .list-row {
          .list-col {
            .col-title {
              height: 45px;
              font-size: 18px;
              color: #5cdaec;
              line-height: 45px;
              text-align: center;
            }
            .space-line {
              width: 136px;
              height: 2px;
              background: linear-gradient(
                270deg,
                rgba(65, 146, 217, 0.1) 0%,
                #1892fc 51%,
                rgba(65, 146, 217, 0.1) 99%
              );
            }
            .col-num {
              display: flex;
              align-items: baseline;
              justify-content: center;
              margin: 25px auto 0;
              background: url("../assets/images/home/file-bg.png") no-repeat;
              width: 97px;
              height: 40px;
              background-size: 100% 100%;
              font-size: 18px;
              font-family: Source Han Sans CN-Regular, Source Han Sans CN;
              color: #def0ff;
              position: relative;
              .num-content {
                position: absolute;
                bottom: 12px;
              }
              span {
                font-size: 36px;
                font-weight: bold;
                color: #def0ff;
                margin-right: 3px;
              }
            }
          }
        }
      }
    }
  }
}
.indexBtn {
  width: 90px;
  height: 36px;
  line-height: 36px;
  border: 2px solid #083754;
  font-size: 16px;
  text-align: center;
  position: absolute;
  top: 1vh;
  right: 38px;
  border-radius: 5px;
  color: #ecf3f8;
  cursor: pointer;
}
/* 改变滚动条样式 */
.listUl::-webkit-scrollbar,
.rr-list::-webkit-scrollbar {
  width: 2px;
  height: 2px;
}
.listUl,
.rr-list {
  scrollbar-width: thin;
  scrollbar-color: #1890fe #1a3152;
}
.listUl::-webkit-scrollbar-thumb,
.rr-list::-webkit-scrollbar-thumb {
  background: #1890fe;
  border-radius: 20px;
}
</style>>
