<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="部门名称" prop="deptName">
        <el-input
          v-model="queryParams.deptName"
          placeholder="请输入部门名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="部门状态" clearable>
          <el-option
            v-for="dict in dict.type.sys_normal_disable"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:dept:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="el-icon-sort"
          size="mini"
          @click="toggleExpandAll"
        >展开/折叠</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
      v-if="refreshTable"
      v-loading="loading"
      :data="deptList"
      row-key="deptId"
      :default-expand-all="isExpandAll"
      :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
    >
      <el-table-column prop="deptName" label="部门名称" width="260"></el-table-column>
      <el-table-column prop="orderNum" label="排序" width="200"></el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="200">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:dept:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-plus"
            @click="handleAdd(scope.row)"
            v-hasPermi="['system:dept:add']"
          >新增</el-button>
          <el-button
            v-if="scope.row.parentId != 0"
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:dept:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加或修改部门对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="24" v-if="form.parentId !== 0">
            <el-form-item label="上级部门" prop="parentId" ref="creditParentId">
              <treeselect v-model="form.parentId" :options="deptOptions" :normalizer="normalizer" placeholder="选择上级部门" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="所属地区" prop="areaCode">
              <el-cascader
                v-model="form.areaCode"
                :options="areaSelectData"
                style="width: 100%;"
                size="large"
                class="full-width"
                @change="handleChange"
                placeholder="请选择所属地区"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="所处位置" prop="positionDescribe">
              <el-input v-model="form.positionDescribe" placeholder="点击右侧选择位置" style="width: 100%;" />
              <el-button type="primary" @click="openRightMap()" icon="el-icon-map-location" style="position: absolute;right: 0;top: 0;" ></el-button>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="部门名称" prop="deptName">
              <el-input v-model="form.deptName" placeholder="请输入部门名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="orderNum">
              <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="负责人" prop="leader">
              <el-input v-model="form.leader" placeholder="请输入负责人" maxlength="20" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="phone">
              <el-input v-model="form.phone" placeholder="请输入联系电话" maxlength="11" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱" maxlength="50" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="部门状态">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in dict.type.sys_normal_disable"
                  :key="dict.value"
                  :label="dict.value"
                >{{dict.label}}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 地图界面 -->
    <el-dialog title="所处位置" :visible.sync="openMap" append-to-body>
      <div class="amap-page-container">
<!--        <el-input v-model="mapInfo.address" placeholder="请输入内容" id="tipinput"></el-input>-->
        <el-amap-search-box
          class="search-box"
          :search-option="searchOption"
          :on-search-result="onSearchResult"
        ></el-amap-search-box>
        <el-amap
          vid="amapDemo"
          :center="mapInfo.lnglat"
          :amap-manager="amapManager"
          :zoom="zoom"
          :events="events"
          class="amap-demo"
          style="height: 400px;"
        >
          <el-amap-marker ref="marker" vid="component-marker" :position="mapInfo.lnglat"></el-amap-marker>
        </el-amap>
        <p>标记点：{{ mapInfo.address }}，经度：{{ mapInfo.lng }}，纬度：{{ mapInfo.lat }}</p>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitMap()">确 定</el-button>
        <el-button @click="cancelMap()">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listDept, getDept, delDept, addDept, updateDept, listDeptExcludeChild } from "@/api/system/dept";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import { regionData, CodeToText } from 'element-china-area-data'
import { AMapManager } from 'vue-amap';
const amapManager = new AMapManager();

export default {
  name: "Dept",
  dicts: ['sys_normal_disable'],
  components: { Treeselect },
  watch: {
    'form.parentId'() {
        this.$nextTick(() => {
            this.$refs.creditParentId.$emit('el.form.change')
        })
    }
  },
  data() {
    return {
      searchOption: {
        city: '全国',
        citylimit: false
      },
      mapInfo: {
        address: '吉林省长春市南关区临河街道中日联谊医院',
        lng: 125.379227,
        lat: 43.861677,
        lnglat: [125.379227,43.861677]
      },
      zoom: 14,
      amapManager,
      events: {
        click: (e) => {
          this.mapInfo.lng = e.lnglat.lng;
          this.mapInfo.lat = e.lnglat.lat;
          this.mapInfo.lnglat = [e.lnglat.lng, e.lnglat.lat];
          this.getFormattedAddress();
        }
      },
      // 遮罩层
      loading: true,
      // 显示搜索条件
      showSearch: true,
      // 表格树数据
      deptList: [],
      // 部门树选项
      deptOptions: [],
      // 弹出层标题
      title: "",
      // 省市区三级联动数据（不带‘全部’选项）
      areaSelectData: regionData,
      // 是否显示弹出层
      open: false,
      // 是否显示map弹出层
      openMap: false,
      // 是否展开，默认全部展开
      isExpandAll: true,
      // 重新渲染表格状态
      refreshTable: true,
      // 查询参数
      queryParams: {
        deptName: undefined,
        status: undefined
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        parentId: [
          { required: true, message: "上级部门不能为空", trigger: 'change' }
        ],
        deptName: [
          { required: true, message: "部门名称不能为空", trigger: "blur" }
        ],
        orderNum: [
          { required: true, message: "显示排序不能为空", trigger: "blur" }
        ],
        areaCode: [
          { required: true, message: "所属地区不能为空", trigger: "change" }
        ],
        positionDescribe: [
          { required: true, message: "所属位置不能为空", trigger: "change" }
        ],
        email: [
          {
            type: "email",
            message: "请输入正确的邮箱地址",
            trigger: ["blur", "change"]
          }
        ],
        phone: [
          {
            pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
            message: "请输入正确的手机号码",
            trigger: "blur"
          }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.initMapByInput();
  },
  methods: {
    // 搜索地址
    onSearchResult (pois) {
      console.log(pois)
      let latSum = 0
      let lngSum = 0
      if (pois.length > 0) {
        pois.forEach(poi => {
          let { lng, lat } = poi
          lngSum += lng
          latSum += lat
          this.mapInfo.lnglat.push([poi.lng, poi.lat])
        })
        let mapcenter = {
          lng: lngSum / pois.length,
          lat: latSum / pois.length
        }
        this.mapInfo.lnglat = [mapcenter.lng, mapcenter.lat]
        this.mapInfo.lng = mapcenter.lng
        this.mapInfo.lat = mapcenter.lat
        this.getFormattedAddress()
      }
    },
    // 经纬度转地址描述
    getFormattedAddress() {
      AMap.plugin('AMap.Geocoder', () => {
        let GeocoderOptions = {
          city: '全国'
        };
        let geocoder = new AMap.Geocoder(GeocoderOptions);
        geocoder.getAddress(this.mapInfo.lnglat, (status, result) => {
          console.log('通过经纬度拿到的地址', result);
          if (status === 'complete' && result.info === 'OK') {
            this.mapInfo.address = result.regeocode.formattedAddress;
          } else {
            this.mapInfo.address = '无法获取地址';
          }
        });
      });
    },
    initMapByInput() {
      AMap.plugin('AMap.Autocomplete', () => {
        let autoOptions = {
          city: '全国',
          input: 'searchInput'
        };
        let autoComplete = new AMap.Autocomplete(autoOptions);
        AMap.event.addListener(autoComplete, 'select', (e) => {
          console.log('通过输入拿到的地址', e);
          this.mapInfo.lat = e.poi.location.lat;
          this.mapInfo.lng = e.poi.location.lng;
          this.mapInfo.lnglat = [e.poi.location.lng, e.poi.location.lat];
          this.getFormattedAddress();
        });
      });
    },
    openRightMap () {
      this.openMap = true
    },
    submitMap () {
      this.form.position = this.mapInfo.lng + ',' + this.mapInfo.lat
    //   为了让当前值通过验证
      this.$set( this.form,'positionDescribe', this.mapInfo.address)
    //   this.form.positionDescribe = this.mapInfo.address
      this.openMap = false
    },
    cancelMap () {
      this.openMap = false
    },
    // 地区选择器change方法
    handleChange(value) {
      if (value == undefined) {
        this.form.areaCode = ""
        this.form.areaDescribe = ""
        return
      }
      let provinceCode = CodeToText[value[0]]
      let cityCode = CodeToText[value[1]]
      let orgion = CodeToText[value[2]]
      this.form.areaCode = [value[0], value[1], value[2]]
      this.form.areaDescribe = provinceCode + cityCode + orgion
    },
    /** 查询部门列表 */
    getList() {
      this.loading = true;
      listDept(this.queryParams).then(response => {
        this.deptList = this.handleTree(response.data, "deptId");
        this.loading = false;
      });
    },
    /** 转换部门数据结构 */
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children;
      }
      return {
        id: node.deptId,
        label: node.deptName,
        children: node.children
      };
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        deptId: undefined,
        parentId: undefined,
        deptName: undefined,
        orderNum: undefined,
        leader: undefined,
        phone: undefined,
        email: undefined,
        areaCode: undefined,
        areaDescribe: undefined,
        status: "0"
      };
      this.mapInfo = {
        address: '吉林省长春市南关区临河街道中日联谊医院',
          lng: 125.379227,
          lat: 43.861677,
          lnglat: [125.379227,43.861677]
      }
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 新增按钮操作 */
    handleAdd(row) {
      this.reset();
      if (row != undefined) {
        this.$set(this.form, 'parentId', row.deptId)
        // this.form.parentId = row.deptId;
      }
      this.open = true;
      this.title = "添加部门";
      listDept().then(response => {
        this.deptOptions = this.handleTree(response.data, "deptId");
      });
    },
    /** 展开/折叠操作 */
    toggleExpandAll() {
      this.refreshTable = false;
      this.isExpandAll = !this.isExpandAll;
      this.$nextTick(() => {
        this.refreshTable = true;
      });
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      getDept(row.deptId).then(response => {
        this.form = response.data;
        // 回显所处地区
        this.form.areaCode = this.form.areaCode.split(",")
        // 回显所处位置
        let arr = this.form.position.split(",")
        this.mapInfo.lnglat = arr
        this.mapInfo.lng = arr[0]
        this.mapInfo.lat = arr[1]
        this.mapInfo.address = this.form.positionDescribe
        this.open = true;
        this.title = "修改部门";
      });
      listDeptExcludeChild(row.deptId).then(response => {
        this.deptOptions = this.handleTree(response.data, "deptId");
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 地区编码数组转为字符串
          this.form.areaCode = this.form.areaCode.toString()
          if (this.form.position == undefined || this.form.position == '') {
            this.$modal.msgError("请选择所处位置");
            return
          }
          if (this.form.deptId != undefined) {
            updateDept(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addDept(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      this.$modal.confirm('是否确认删除名称为"' + row.deptName + '"的数据项？').then(function() {
        return delDept(row.deptId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
  }
};
</script>
<style scoped>
  .amap-page-container{
    position: relative;
    border: 1px solid #ccc;
  }
  .search-box {
    position: absolute;
    top: 0;
    left: 0;
  }

  ::v-deep .search-tips{
    width: 100%!important;
  }

  ::v-deep .amap-logo{
    visibility: hidden;
  }

  ::v-deep .amap-copyright{
    visibility: hidden!important;
  }

</style>
