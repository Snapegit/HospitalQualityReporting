<template>
    <div class="app-container">
        <div style="margin-left: 30px; margin-bottom: 20px">
            <el-select @change="selectTemplateChanged" v-model="templateSel" filterable placeholder="请选择上报模板">
                <el-option v-for="item in templateoptions" :key="item.value" :label="item.label" :value="item.value">
                </el-option>
            </el-select>
        </div>
        <!-- 分不同类型展示 -->
        <div class="chart-tags">
            <!-- 按时间展示 -->
            <div @click="listByTime" class="chart-tag-time" :class="isActive == 0 ? 'active' : ''">
                按月份展示
            </div>
            <!-- 按医院展示 -->
            <div @click="listByHospital" class="chart-tag-hostipal" :class="isActive == 1 ? 'active' : ''">
                按医院展示
            </div>
            <div @click="listByRegion" class="chart-tag-hostipal" :class="isActive == 3 ? 'active' : ''">
                按地区展示
            </div>
            <div @click="listByYear" class="chart-tag-hostipal" :class="isActive == 2 ? 'active' : ''">
                年底趋势
            </div>
        </div>
        <div class="bottom-line"></div>
        <el-row :gutter="20">
            <el-col :span="18">
                <!-- 切换下拉 -->
                <div class="year-select">
                    <el-select @change="selectChanged" v-model="yearSel" placeholder="请选择年份" v-show="isActive == 2">
                        <el-option v-for="item in yearOptions" :key="item.value" :label="item.label" :value="item.value">
                        </el-option>
                    </el-select>
                    <el-select @change="selectHospitalChanged" v-model="hospitalSel" filterable placeholder="请选择医院"
                        v-show="isActive == 0">
                        <el-option v-for="item in hospitalOptions" :key="item.value" :label="item.label"
                            :value="item.value">
                        </el-option>
                    </el-select>
                    <div v-show="isActive == 3">
                        <el-select class="mr" @change="selectRegionChanged" v-model="regionSel" placeholder="请选择地区">
                            <el-option label="全省" value="-1"> </el-option>
                            <el-option v-for="dict in dict.type.regin_area" :key="dict.value" :label="dict.label"
                                :value="dict.label"></el-option>
                        </el-select>
                        <el-date-picker @change="handleRegionDateChange" v-model="regionDate" type="daterange"
                            value-format="yyyy-MM-dd" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期">
                        </el-date-picker>
                    </div>
                </div>
                <div id="main"></div>
            </el-col>
            <el-col :span="6" style="height: 78vh; overflow-x: hidden; overflow-y: auto">
                <el-table id="out-table1" :stripe="true" :data="tableData" :header-cell-style="{ 'text-align': 'center' }"
                    :cell-style="{ 'text-align': 'center' }" v-show="isActive == 2 || isActive == 1 || isActive == 3"
                    class="el-footer-table-div" :summary-method="getShowSummary" show-summary>
                    <el-table-column prop="title" label="医院"> </el-table-column>
                    <el-table-column prop="num" label="数量"> </el-table-column>
                </el-table>
                <el-table id="out-table2" :stripe="true" :data="yearTableData"
                    :header-cell-style="{ 'text-align': 'center' }" :cell-style="{ 'text-align': 'center' }"
                    v-show="isActive == 0" class="el-footer-table-div" :summary-method="getShowSummary" show-summary>
                    <el-table-column prop="month" label="时间"> </el-table-column>
                    <el-table-column prop="num" label="数量"> </el-table-column>
                </el-table>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import {
    getAdrs,
    getAdrsByMonth,
    getUserSelect,
    getAdrsByAreaAndDate
} from "@/api/system/reportStatistics";
import { listTemplate, getRepTemplateList } from "@/api/report/template";
import save from '@/assets/icons/dc.png'
export default {
    name: "reportStatistics",
    dicts: ["regin_area"],
    data() {
        return {
            regionSel: "-1", //地区下拉选中
            regionDate: [], //地区日期
            yearSel: "", //年份下拉选中
            yearOptions: [], //年份下拉列表
            hospitalSel: "", //医院下拉选中
            hospitalOptions: [], //医院下拉列表
            templateoptions: [], //模板下拉
            templateSel: '',//模板下拉选中
            tableData: [], //数据列表
            yearTableData: [], //时间数据列表
            xData: [], //柱状图横坐标
            yData: [], //柱状图纵坐标
            isActive: 0, //选中状态
            params: {
                year: "",
            }, //参数
        };
    },
    mounted() {
        this.getListTemplate();
        // this.getUserSelect();
        this.getYear();
    },
    methods: {
        // 导出
        //   点击按钮  导出excel表格：
        exportToExcel() {
            let tables = null;
            if (this.isActive == 2 || this.isActive == 1 || this.isActive == 3) {
                tables = document.getElementById("out-table1");
            } else {
                tables = document.getElementById("out-table2");
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
                    "上报数量.xlsx"
                );
            } catch (e) {
                if (typeof console !== "undefined") console.log(e, table_write);
            }
            return table_write;
        },
        /* 地区展示方法 */
        //地区切换触发事件
        selectRegionChanged(e) {
            this.regionSel = e;
            this.getAdrsByRegion();
        },
        // 日期切换触发事件
        handleRegionDateChange(e) {
            this.regionDate = e;
            this.getAdrsByRegion();
        },
        listByRegion() {
            this.isActive = 3;
            let date = new Date();
            let nowDate =
                date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
            // 给日期选择初始值
            console.log(nowDate)
            this.regionDate = [nowDate, nowDate];
            this.getAdrsByRegion()
        },

        getAdrsByRegion() {
            let params = {
                templateId: this.templateSel,
                area: this.regionSel,
                beginDate: this.regionDate[0],
                endDate: this.regionDate[1],
            };
            this.tableData = [];
            this.xData = [];
            this.yData = [];
            getAdrsByAreaAndDate(params).then(res => {
                if (res.code == 200) {
                    this.tableData = res.data;
                    res.data.forEach((item) => {
                        this.xData.push(item.title);
                        this.yData.push(item.num);
                    });
                    this.drawChart();
                }
            })
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
        // 模板切换下拉
        selectTemplateChanged(value) {
            this.templateSel = value
            let active = this.isActive;
            // 保持tab选项，仅刷新数据
            if (active == 0) {
                this.getAdrsByMonth()
            } else if (active == 1) {
                this.getAdrs()
            } else if (active == 2) {
                this.params.year = this.yearSel;
                this.params.templateId = this.templateSel
                this.getAdrs();
            } else if (active == 3) {
                this.getAdrsByRegion()
            }
        },
        // 模板下拉数据
        getListTemplate() {
            getRepTemplateList().then((res) => {
                if (res.code == 200) {
                    console.log(res)
                    let list = res.data;
                    this.templateSel = list[0].id
                    list.forEach(item => {
                        let template = {
                            value: item.id,
                            label: item.templateName
                        }
                        this.templateoptions.push(template)
                    })
                    this.getUserSelect()
                }
            });
        },
        // 医院切换下拉
        selectHospitalChanged(value) {
            this.hospitalSel = value;
            this.getAdrsByMonth();
        },
        // 查询所有医院
        getUserSelect() {
            getUserSelect().then((res) => {
                if (res.code == 200) {
                    this.hospitalSel = res.data[0].userId;
                    res.data.forEach((item) => {
                        this.hospitalOptions.push({
                            label: item.nickName,
                            value: item.userId,
                        });
                    });
                }
                this.getAdrsByMonth();
            });
        },
        // 获取年份下拉
        getYear() {
            let year = new Date().getFullYear();
            for (var i = 0; i <= 3; i++) {
                if (i < 3) {
                    this.yearOptions.unshift({ value: year - i, label: year - i });
                }
            }
            this.yearSel = year;
            this.params.year = year;
            //   this.getAdrsByMonth()
        },
        getAdrsByMonth() {
            this.yearTableData = [];
            this.xData = [];
            this.yData = [];
            let params = {
                hospitalId: this.hospitalSel,
                templateId: this.templateSel
            };
            getAdrsByMonth(params).then((res) => {
                if (res.code == 200) {
                    this.yearTableData = res.data;
                    res.data.forEach((item) => {
                        this.xData.push(item.month);
                        this.yData.push(item.num);
                    });
                    this.drawChart();
                }
            });
        },
        // 下拉切换
        selectChanged(value) {
            this.params.year = value;
            this.getAdrs();
        },
        // 按时间展示事件
        listByTime() {
            this.isActive = 0;
            this.xData = [];
            this.yData = [];
            //   走月份方法
            this.getAdrsByMonth();
        },
        // 按医院展示事件
        listByHospital() {
            this.isActive = 1;
            let year = new Date().getFullYear(); //医院展示今年
            this.params.year = year;
            this.getAdrs();
        },
        // 年底趋势
        listByYear() {
            this.isActive = 2;
            this.getAdrs();
        },
        // 获取echarts图所需的数据
        getAdrs() {
            this.xData = [];
            this.yData = [];
            this.params.year = this.yearSel;
            this.params.templateId = this.templateSel
            getAdrs(this.params).then((res) => {
                if (res.code == 200) {
                    let data = res.data;
                    this.tableData = data;
                    data.forEach((item) => {
                        this.xData.push(item.title);
                        this.yData.push(item.num);
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
                    text: "事件上报数量统计",
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