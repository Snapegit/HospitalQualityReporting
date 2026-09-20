<template>
  <div class="index-container">
   
    
  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      // 版本号
      version: "3.8.3",
    };
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank");
    },
  },
};
</script>

<style scoped lang="scss">
.index-container {
  padding: 60px;
}
.bc {
  width: 18%;
  height: 370px;
  border-radius: 20px 20px 20px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  .it-image {
    margin-top: 60px;
    width: 70px;
    height: 70px;
    background: #ffffff;
    border-radius: 10px 10px 10px 10px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .it-title {
    margin-top: 15px;
    font-size: 26px;
    font-family: Source Han Sans CN-Medium, Source Han Sans CN;
    font-weight: 500;
    color: #ffffff;
  }
  .it-eng-title {
    margin-top: 10px;
    font-size: 16px;
    font-family: DIN-Regular, DIN;
    font-weight: 400;
    color: #ffffff;
  }
  .it-length {
    margin-top: 20px;
    font-size: 16px;
    font-family: Source Han Sans CN-Regular, Source Han Sans CN;
    color: #ffffff;
    span {
      font-size: 44px;
      margin-right: 5px;
    }
  }
  .it-btn {
    margin-top: 20px;
    .el-button {
      width: 80px;
      height: 40px;
      background: rgba(255, 255, 255, 0.5);
      border-radius: 20px 20px 20px 20px;
      color: #fff;
    }
  }
}
.ic-top {
  display: flex;
  justify-content: space-between;
  .newsCenter {
    background: linear-gradient(135deg, #5783e6 0%, #07affa 100%);
    box-shadow: 0px 10px 20px 0px rgba(57, 98, 221, 0.1);
  }
  .specification {
    background: linear-gradient(135deg, #e073f0 0%, #1e83ed 100%);
    box-shadow: 0px 10px 20px 0px rgba(57, 98, 221, 0.1);
  }
  .industryTrends {
    background: linear-gradient(135deg, #ff43d4 0%, #fbbf3b 100%);
    box-shadow: 0px 10px 20px 0px rgba(57, 98, 221, 0.1);
  }
  .dataDownload {
    background: linear-gradient(135deg, #00b09b 0%, #78ffd6 100%);
    box-shadow: 0px 10px 20px 0px rgba(57, 98, 221, 0.1);
  }
  .notice {
    background: linear-gradient(135deg, #45caff 1%, #fa1fd5 100%);
    box-shadow: 0px 10px 20px 0px rgba(57, 98, 221, 0.1);
  }
}
.ic-bottom {
  margin-top: 60px;
  display: flex;
  justify-content: space-between;
  .left {
    display: flex;
  }
  .right {
    margin-right: 43px;
  }
  .aboutCenter {
    width: 830px;
    height: 220px;
    background-color: #bccbf7;
    background-image: url("../assets/images/index/zxjs-banner.png");
    background-repeat: no-repeat;
    background-size: 100% 100%;
  }
  .userManagement {
    width: 545px;
    height: 220px;
    background-color: #bac6d5;
    background-image: url("../assets/images/index/yhgl-banner.png");
    background-repeat: no-repeat;
    background-size: 100% 100%;
  }
}
.ib-bc {
  display: flex;
  justify-content: space-between;
  border-radius: 20px;
  align-items: center;
  padding: 0 45px;
  .ib-image {
    background: #fff;
    width: 70px;
    height: 70px;
    background: #ffffff;
    border-radius: 10px 10px 10px 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 15px;
  }
  .ib-cn-title {
    font-size: 26px;
    font-family: Source Han Sans CN-Medium, Source Han Sans CN;
    font-weight: 500;
    color: #ffffff;
  }
  .ib-eng-title {
    font-size: 16px;
    font-family: DIN-Regular, DIN;
    font-weight: 400;
    color: #ffffff;
    margin-top: 5px;
  }
  .el-button {
    width: 104px;
    height: 40px;
    background: #ffffff;
    border-radius: 20px 20px 20px 20px;
    color: #566880;
  }
}
</style>

