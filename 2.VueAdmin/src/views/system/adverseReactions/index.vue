<template>
    <div class="app-container">
        <!-- 分不同类型展示 -->
        <div class="chart-tags">
            <!-- 按时间展示 -->
            <div @click="handleByRegion" class="chart-tag-time" :class="isActive == 0 ? 'active' : ''">
                按地区展示
            </div>
            <!-- 按医院展示 -->
            <div @click="handleByHospital" class="chart-tag-hostipal" :class="isActive == 1 ? 'active' : ''">
                按医院展示
            </div>
            <div @click="handleBySeverity" class="chart-tag-hostipal" :class="isActive == 2 ? 'active' : ''">
                不良反应严重程度
            </div>
            <div @click="handleByNumber" class="chart-tag-hostipal" :class="isActive == 3 ? 'active' : ''">
                不良反应药品数量
            </div>
        </div>
        <div class="bottom-line"></div>
        <el-row :gutter="20">
            <el-col :span="18">
                <!-- 切换下拉 -->
                <div class="year-select">
                    <!-- 按地区展示 -->
                    <div v-show="isActive == 0">
                        <el-select class="mr" @change="selectRegionChanged" v-model="regionSel" placeholder="请选择地区">
                            <el-option label="全省" value="-1"> </el-option>
                            <el-option v-for="dict in dict.type.regin_area" :key="dict.value" :label="dict.label"
                                :value="dict.label"></el-option>
                        </el-select>
                        <el-date-picker @change="handleRegionDateChange" v-model="regionDate" type="daterange"
                            value-format="yyyy-MM-dd" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期">
                        </el-date-picker>
                    </div>

                    <!-- 按医院展示 -->
                    <div v-show="isActive == 1">
                        <el-select class="mr" @change="selectHospitalChanged" v-model="hospitalSel" filterable
                            placeholder="请选择医院">
                            <el-option label="全省" value="-1"> </el-option>
                            <el-option v-for="item in hospitalOptions" :key="item.value" :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                        <el-date-picker @change="handleHospitalDateChange" v-model="hospitalDate" type="daterange"
                            value-format="yyyy-MM-dd" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期">
                        </el-date-picker>
                    </div>

                    <!-- 按严重程度展示 -->
                    <div v-show="isActive == 2">
                        <el-select class="mr" @change="selectSeverityChanged" v-model="severitySel" filterable
                            placeholder="请选择医院">
                            <el-option label="全省" value="-1"> </el-option>
                            <el-option v-for="item in hospitalOptions" :key="item.value" :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                        <el-date-picker v-model="severityDate" @change="handleSeverityDateChange" value-format="yyyy-MM-dd"
                            type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期">
                        </el-date-picker>
                    </div>
                    <!-- 按药品数量展示 -->
                    <div v-show="isActive == 3">
                        <el-select class="mr" @change="selectQuantityChanged" v-model="quantitySel" filterable
                            placeholder="请选择医院">
                            <el-option label="全省" value="-1"> </el-option>
                            <el-option v-for="item in hospitalOptions" :key="item.value" :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                        <el-date-picker v-model="quantityDate" @change="handleQuantityDateChange" value-format="yyyy-MM-dd"
                            type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期">
                        </el-date-picker>
                    </div>
                </div>
                <div id="main"></div>
            </el-col>
            <el-col :span="6" style="height: 78vh; overflow-x: hidden; overflow-y: auto">
                <el-table class="el-footer-table-div" v-if="isActive == 0" id="out-table1" :stripe="true"
                    :data="hospitalTableData" :header-cell-style="{ 'text-align': 'center' }"
                    :cell-style="{ 'text-align': 'center' }" :summary-method="getShowSummary" show-summary>
                    <el-table-column prop="reginArea" label="地区"> </el-table-column>
                    <el-table-column prop="num" label="数量"> </el-table-column>
                </el-table>
                <el-table class="el-footer-table-div" v-else-if="isActive == 1" id="out-table2" :stripe="true"
                    :data="hospitalTableData" :header-cell-style="{ 'text-align': 'center' }"
                    :cell-style="{ 'text-align': 'center' }" :summary-method="getShowSummary" show-summary>
                    <el-table-column prop="hospitalName" label="医院"> </el-table-column>
                    <el-table-column prop="num" label="数量"> </el-table-column>
                </el-table>
                <el-table class="el-footer-table-div" v-else-if="isActive == 2" id="out-table3" :stripe="true"
                    :data="severityTableData" :header-cell-style="{ 'text-align': 'center' }"
                    :cell-style="{ 'text-align': 'center' }" :summary-method="getShowSummary" show-summary>
                    <el-table-column prop="severityName" label="严重程度">
                    </el-table-column>
                    <el-table-column prop="num" label="数量"> </el-table-column>
                </el-table>
                <el-table v-else id="out-table4" :stripe="true" :data="quantityTableData"
                    :header-cell-style="{ 'text-align': 'center' }" :cell-style="{ 'text-align': 'center' }"
                    class="el-footer-table-div" :summary-method="getShowSummary" show-summary>
                    <el-table-column prop="medicalName" label="药品名"> </el-table-column>
                    <el-table-column prop="num" label="数量"> </el-table-column>
                </el-table>
            </el-col>
        </el-row>
    </div>
</template>

<script>
let medicalEnum = new Map([
    ["medical1", "碘普罗胺（优维显）"],
    ["medical2", "碘克沙醇（威视派克）"],
    ["medical3", "碘海醇（欧乃派克、欧苏）"],
    ["medical4", "碘帕醇（碘比乐）"],
    ["medical5", "碘佛醇"],
    ["medical6", "碘化油"],
    ["medical7", "复方泛影葡胺"],
    ["medical8", "其他"],
]);
let severityEnum = new Map([
    ["mildSeverity", "轻度"],
    ["mediumSeverity", "中度"],
    ["seriousSeverity", "重度"],
]);

import { getUserSelect } from "@/api/system/reportStatistics";
import {
    getAdrsByHospital,
    getAdrsByArea,
    getAdrsByMedical,
    getAdrsBySeverity,
} from "@/api/system/adverseReactions";
import save from '@/assets/icons/dc.png'
export default {
    name: "reportStatistics",
    dicts: ["regin_area"],
    data() {
        return {
            regionSel: "-1", //地区下拉选中
            severityDate: [], //严重程度日期
            regionDate: [], //地区日期
            hospitalDate: [], //医院日期
            quantityDate: [], //药品数量日期
            severitySel: "-1", //不良反应严重程度下拉选中
            yearOptions: [], //年份下拉列表
            hospitalSel: "-1", //医院下拉选中
            quantitySel: "-1", //药品数量下拉选中
            hospitalOptions: [], //医院下拉列表
            hospitalTableData: [], //医院数据列表
            quantityTableData: [], //药品数量数据列表
            severityTableData: [], //严重程度数据列表
            xData: [], //柱状图横坐标
            yData: [], //柱状图纵坐标
            isActive: 0, //选中状态
            params: {
                year: "",
            }, //参数
        };
    },
    mounted() {
        this.getNowDate();
        this.getUserSelect();
    },
    methods: {
        // 导出
        //   点击按钮  导出excel表格：
        exportToExcel() {
            let tables = null;
            if (this.isActive == 0) {
                tables = document.getElementById("out-table1");
            } else if (this.isActive == 1) {
                tables = document.getElementById("out-table2");
            } else if (this.isActive == 2) {
                tables = document.getElementById("out-table3");
            } else {
                tables = document.getElementById("out-table4");
            }
            let table_book = this.$XLSX.utils.table_to_book(tables);
            var table_write = this.$XLSX.write(table_book, {
                bookType: "xlsx",
                bookSST: true,
                type: "array"
            });
            try {
                this.$FileSaver.saveAs(
                    new Blob([table_write], { type: "application/octet-stream" }),
                    "不良反应.xlsx"
                );
            } catch (e) {
                if (typeof console !== "undefined") console.log(e, table_write);
            }
            return table_write;
        },
        // 表格加上合计功能
        getShowSummary(param) {
            const { columns, data } = param;
            const sums = [];
            columns.forEach((column, index) => {
                if (index == 0) {
                    sums[index] = "合计";
                    return;
                }
                //把每一列中的所有单元格中的值转化成Number型，
                //然后对转化后的结果进行判断，如果是number型，则进行累加，
                //如果NaN型，说明单元格里是一些无法转化成number型的值，则返回自定义的内容
                const values = data.map((item) => Number(item[column.property]));
                if (!values.every((value) => isNaN(value))) {
                    sums[index] = values.reduce((prev, curr) => {
                        const value = Number(curr);
                        if (!isNaN(value)) {
                            return prev + curr;
                        } else {
                            return prev;
                        }
                    }, 0);
                    sums[index] += "";
                } else {
                    sums[index] = "N/A";
                }
            });
            return sums;
        },
        // 获取当前日期做初始化日期
        getNowDate() {
            let date = new Date();
            // 日期格式化
            let nowDate =
                date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
            // 给日期选择初始值
            this.regionDate = [nowDate, nowDate];
            this.hospitalDate = [nowDate, nowDate];
            this.severityDate = [nowDate, nowDate];
            this.quantityDate = [nowDate, nowDate];
            // 日期获取结束，执行获取地区数据方法
            this.handleByRegion();
        },

        /**
         * 地区展示相关方法
         *
         * */
        // 切换到地区展示数据
        handleByRegion() {
            this.isActive = 0;
            this.getAdrsByArea();
        },
        //地区切换触发事件
        selectRegionChanged(e) {
            this.regionSel = e;
            this.getAdrsByArea();
        },
        // 日期切换触发事件
        handleRegionDateChange(e) {
            this.regionDate = e;
            this.getAdrsByArea();
        },
        // 地区echart数据
        getAdrsByArea() {
            this.xData = [];
            this.yData = [];
            this.hospitalTableData = [];
            let params = {
                area: this.regionSel,
                beginDate: this.regionDate[0],
                endDate: this.regionDate[1],
            };
            getAdrsByArea(params).then((res) => {
                if (res.code == 200) {
                    this.hospitalTableData = res.data;
                    res.data.forEach((item) => {
                        this.xData.push(item.reginArea);
                        this.yData.push(item.num);
                    });
                    this.drawChart();
                }
            });
        },

        /**
         * 按医院展示相关方法
         *
         * */
        // 查询所有医院
        getUserSelect() {
            getUserSelect().then((res) => {
                if (res.code == 200) {
                    //   this.hospitalSel = res.data[0].userId;
                    //   this.severitySel = res.data[0].userId;
                    //   this.quantitySel = res.data[0].userId;
                    res.data.forEach((item) => {
                        this.hospitalOptions.push({
                            label: item.nickName,
                            value: item.userId,
                        });
                    });
                }
            });
        },
        // 切换到医院展示数据
        handleByHospital() {
            this.isActive = 1;
            this.getAdrsByHospital();
        },

        // 按医院展示切换日期触发事件
        handleHospitalDateChange(e) {
            this.hospitalDate = e;
            this.getAdrsByHospital();
        },
        // 医院切换下拉
        selectHospitalChanged(value) {
            this.hospitalSel = value;
            this.getAdrsByHospital();
        },
        // 根据医院展示数据-echart数据
        getAdrsByHospital() {
            this.xData = [];
            this.yData = [];
            this.hospitalTableData = [];
            let params = {
                hospitalId: this.hospitalSel,
                beginDate: this.hospitalDate[0],
                endDate: this.hospitalDate[1],
            };
            getAdrsByHospital(params).then((res) => {
                if (res.code == 200) {
                    this.hospitalTableData = res.data;
                    res.data.forEach((item) => {
                        this.xData.push(item.hospitalName);
                        this.yData.push(item.num);
                    });
                    this.drawChart();
                }
            });
        },

        /**
         * 按不良反应严重程度相关方法
         *
         * */

        // 切换到不良反应严重程度
        handleBySeverity() {
            this.isActive = 2;
            this.getAdrsBySeverity();
        },
        // 切换严重程度触发事件
        selectSeverityChanged(e) {
            this.severitySel = e;
            this.getAdrsBySeverity();
        },
        // 切换日期触发事件
        handleSeverityDateChange(e) {
            this.severityDate = e;
            this.getAdrsBySeverity();
        },
        getAdrsBySeverity() {
            this.xData = [];
            this.yData = [];
            this.severityTableData = [];
            let params = {
                hospitalId: this.severitySel,
                beginDate: this.severityDate[0],
                endDate: this.severityDate[1],
            };
            getAdrsBySeverity(params).then((res) => {
                console.log(res);
                if (res.code == 200) {
                    // 将对象转成嵌套数组格式
                    let severityDatas = Object.entries(res.data);

                    severityDatas.forEach((item) => {
                        // 数据拼接成对象模式再传入table数组中
                        let severityData = {
                            severityName: severityEnum.get(item[0]),
                            num: item[1],
                        };
                        this.severityTableData.push(severityData);
                        this.xData.push(severityEnum.get(item[0]));
                        this.yData.push(item[1]);
                    });
                    this.drawChart();
                }
            });
        },

        /**
         * 按不良反应药品数量相关方法
         *
         * */
        // 切换到不良反应药品数量
        handleByNumber() {
            this.isActive = 3;
            this.getAdrsByMedical();
        },
        selectQuantityChanged(e) {
            this.quantitySel = e;
            this.getAdrsByMedical();
        },
        // 日期切换触发事件
        handleQuantityDateChange(e) {
            this.quantityDate = e;
            this.getAdrsByMedical();
        },
        // 获取到不良反应药品数量echart数据
        getAdrsByMedical() {
            this.xData = [];
            this.yData = [];
            this.quantityTableData = [];
            let params = {
                hospitalId: this.quantitySel,
                beginDate: this.quantityDate[0],
                endDate: this.quantityDate[1],
            };
            getAdrsByMedical(params).then((res) => {
                if (res.code == 200) {
                    // 将对象转成嵌套数组格式
                    let medicalDatas = Object.entries(res.data);

                    medicalDatas.forEach((item) => {
                        // 数据拼接成对象模式再传入table数组中
                        let quantityData = {
                            medicalName: medicalEnum.get(item[0]),
                            num: item[1],
                        };
                        this.quantityTableData.push(quantityData);
                        this.xData.push(medicalEnum.get(item[0]));
                        this.yData.push(item[1]);
                    });
                    this.drawChart();
                }
            });
        },

        // 画echart图
        drawChart() {
            let _this = this
            let myEchart = _this.$echarts.init(document.getElementById("main"));
            let option = {
                title: {
                    show: true,
                    text: "不良反应事件上报统计",
                    x: "center",
                    textStyle: {
                        color: "#000",
                    },
                },
                toolbox: {
                    show: true, //是否显示工具栏组件
                    orient: "horizontal", //工具栏 icon 的布局朝向'horizontal' 'vertical'
                    itemSize: 15, //工具栏 icon 的大小
                    itemGap: 10, //工具栏 icon 每项之间的间隔
                    showTitle: true, //是否在鼠标 hover 的时候显示每个工具 icon 的标题
                    feature: {
                        mark: {
                            // '辅助线开关'
                            show: true,
                        },
                        magicType: {
                            //动态类型切换
                            show: true,
                            title: "切换", //各个类型的标题文本，可以分别配置。
                            type: ["line", "bar"], //启用的动态类型，包括'line'（切换为折线图）, 'bar'（切换为柱状图）, 'stack'（切换为堆叠模式）, 'tiled'（切换为平铺模式）
                        },
                        restore: {
                            //配置项还原。
                            show: true, //是否显示该工具。
                            title: "还原",
                        },
                        saveAsImage: {
                            //保存为图片。
                            show: true, //是否显示该工具。
                            type: "png", //保存的图片格式。支持 'png' 和 'jpeg'。
                            name: "pic1", //保存的文件名称，默认使用 title.text 作为名称
                            backgroundColor: "#ffffff", //保存的图片背景色，默认使用 backgroundColor，如果backgroundColor不存在的话会取白色
                            title: "保存为图片",
                            pixelRatio: 1, //保存图片的分辨率比例，默认跟容器相同大小，如果需要保存更高分辨率的，可以设置为大于 1 的值，例如 2
                        },
                        // 自定义导出excel
                        myTool1: {
                            show: true,
                            title: '导出',
                            icon: `image://${save}`,
                            onclick: function () {
                                _this.exportToExcel()
                            }
                        },
                    },
                    zlevel: 0, //所属图形的Canvas分层，zlevel 大的 Canvas 会放在 zlevel 小的 Canvas 的上面
                    z: 2, //所属组件的z分层，z值小的图形会被z值大的图形覆盖
                    left: "right", //组件离容器左侧的距离,'left', 'center', 'right','20%'
                    top: "top", //组件离容器上侧的距离,'top', 'middle', 'bottom','20%'
                    right: "auto", //组件离容器右侧的距离,'20%'
                    bottom: "auto", //组件离容器下侧的距离,'20%'
                    width: "auto", //图例宽度
                    height: "auto", //图例高度
                },
                grid: {
                    left: "2%",
                    right: "2%",
                    bottom: "6%",
                    containLabel: true,
                },
                tooltip: {
                    trigger: "axis", //坐标轴触发，主要在柱状图，折线图等会使用类目轴的图表中使用
                    axisPointer: {
                        // 坐标轴指示器，坐标轴触发有效
                        type: "shadow", // 默认为直线，可选为：'line' | 'shadow'
                    },
                },
                xAxis: {
                    type: "category",
                    data: this.xData,
                    //设置字体倾斜
                },
                dataZoom: [
                    {
                        type: "slider",
                        show: true, // flase直接隐藏图形
                        xAxisIndex: [0],
                        left: "4%", // 滚动条靠左侧的百分比
                        bottom: -5,
                        start: 0, // 滚动条的起始位置（10%）
                        end: 100, // 滚动条的终止位置（90%）
                    },
                ],
                yAxis: {
                    type: "value",
                    minInterval: 1,
                },
                series: [
                    {
                        data: this.yData,
                        type: "bar",
                        barWidth: "auto", //设置柱状图宽度
                        itemStyle: {
                            normal: {
                                //这里是颜色
                                color: function (params) {
                                    return "#409eff";
                                },
                            },
                        },
                    },
                ],
            };
            myEchart.setOption(option);
        },
    },
};
</script>
<style lang="scss" scoped>
.el-footer-table-div ::v-deep .el-table__footer-wrapper tbody td.el-table__cell {
    text-align: center;
}

#main {
    width: 100%;
    height: 70vh;
}

.chart-tags {
    margin-left: 27px;
    display: flex;
}

.active {
    color: #409eff;
    border-bottom: 2px solid #409eff;
    padding-bottom: 13px;
}

.chart-tag-time,
.chart-tag-hostipal {
    cursor: pointer;
    margin-right: 20px;
}

.bottom-line {
    height: 1px;
    background: #eee;
    margin-bottom: 10px;
}

/* 下拉样式 */
.year-select {
    height: 40px;
    margin-left: 27px;
    margin-bottom: 20px;
}

::-webkit-scrollbar {
    width: 0px;
    height: 0px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0;
}

::-webkit-scrollbar-thumb {
    background-color: transparent;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0;
}

.mr {
    margin-right: 20px;
}
</style>