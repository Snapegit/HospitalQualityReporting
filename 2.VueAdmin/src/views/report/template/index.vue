<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryForm"
      size="small"
      :inline="true"
      v-show="showSearch"
      label-width="120px"
    >
      <el-form-item label="所属上报类型" prop="classifyId">
        <el-select v-model="queryParams.classifyId">
          <el-option
            v-for="classify in classifys"
            :label="classify.classifyName"
            :value="classify.id"
            :key="classify.id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="模板名称" prop="templateName">
        <el-input
          v-model="queryParams.templateName"
          placeholder="请输入模板名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          icon="el-icon-search"
          size="mini"
          @click="handleQuery"
          >搜索</el-button
        >
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery"
          >重置</el-button
        >
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
          v-hasPermi="['report:template:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['report:template:remove']"
          >删除</el-button
        >
      </el-col>
      <right-toolbar
        :showSearch.sync="showSearch"
        @queryTable="getList"
      ></right-toolbar>
    </el-row>

    <el-table
      v-loading="loading"
      :data="templateList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column
        label="所属上报类型"
        align="center"
        prop="classifyName"
      />
      <el-table-column label="模板名称" align="center" prop="templateName" />
      <el-table-column label="创建人" align="center" prop="createByName" />
      <el-table-column label="创建时间" align="center" prop="createTime" />
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
      >
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleView(scope.row)"
            v-hasPermi="['report:template:edit']"
            >查看</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-document-copy"
            @click="handleCopy(scope.row)"
            v-hasPermi="['report:template:edit']"
            >复制</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['report:content:edit']"
            >修改</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['report:template:remove']"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改上报模板对话框 -->
    <el-dialog
      :title="title"
      v-if="open"
      :visible.sync="open"
      width="95%"
      :before-close="onClose"
      append-to-body
    >
      <form-making
        :classifys="classifys"
        @refreshList="refreshList"
        :templateValue="templateValue"
      ></form-making>
    </el-dialog>

    <!-- 查看模板dialog -->
    <el-dialog
      title="查看模板"
      :visible.sync="viewOpen"
      width="40%"
      append-to-body
    >
      <form-create
        v-model="fApi"
        :value.sync="value"
        :rule="FcDesignerRule"
        :option="FcDesignerOptions"
      ></form-create>
      <div slot="footer" class="dialog-footer">
        <el-button @click="viewOpen = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listTemplate,
  getTemplate,
  delTemplate,
  addTemplate,
  updateTemplate,
  copyTemplate,
} from "@/api/report/template";
import FormMaking from "@/components/FormMaking";
import FormGenerate from "@/components/FormGenerate";
import { getReportClassifySelectList } from "@/api/report/classify";
export default {
  name: "Template",
  components: { FormMaking, FormGenerate },
  data() {
    return {
      classifys: [], //分类id
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 上报模板表格数据
      templateList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查看模板弹出层
      viewOpen: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        classifyId: null,
        templateName: null,
        formProperty: null,
        unitProperty: null,
      },
      // 查看模板所需
      fApi: {},
      //表单数据
      value: {},
      FcDesignerRule: [], //表单列表
      FcDesignerOptions: {}, //表单属性
      templateValue: {}, //(修改用)模板表单数据
      // 表单参数
      form: {},
    };
  },
  mounted() {
    this.getList();
    this.getClassifyList();
  },
  methods: {
    // 查看模板
    handleView(row) {
      this.viewOpen = true;
      this.FcDesignerRule = JSON.parse(row.formProperty);
      this.FcDesignerOptions = JSON.parse(row.unitProperty);
      this.$nextTick(() => {
        let labelDivs = document.getElementsByTagName("label");
        for (var i in this.FcDesignerRule) {
          if (this.FcDesignerRule[i].info) {
            for (let labelDiv of labelDivs) {
              if (
                labelDiv.getAttributeNode("for") !== null &&
                labelDiv.getElementsByTagName("span")[1] &&
                labelDiv.getElementsByTagName("span")[0].innerText.trim() ==
                  this.FcDesignerRule[i].title
              ) {
                console.log(
                  labelDiv.getElementsByTagName("span")[0].innerText.trim(),
                  this.FcDesignerRule[i].title
                );
                let createDiv = document.createElement("div"); //创造一个div元素
                createDiv.classList.add("createDivBox"); //加入class类
                createDiv.style.color = "#7f8082";
                createDiv.innerHTML = "(" + this.FcDesignerRule[i].info + ")";
                labelDiv.appendChild(createDiv);
              }
            }
          }
        }
      });
    },
    //查询上报分类下拉数据
    getClassifyList() {
      getReportClassifySelectList().then((res) => {
        if (res.code == 200) {
          this.classifys = res.data;
        }
      });
    },
    // 子组件控制方法
    refreshList() {
      this.getList();
      this.open = false;
      console.log("关闭啦");
      this.templateValue = {};
    },
    /** 查询上报模板列表 */
    getList() {
      this.loading = true;
      listTemplate(this.queryParams).then((response) => {
        this.templateList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    onClose() {
      console.log("点击关闭");
      this.open = false;
      this.reset();
      this.templateValue = {};
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        classifyId: null,
        templateName: null,
        formProperty: null,
        unitProperty: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.id);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "新增";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      console.log(row);
      this.templateValue = row;
      this.reset();
      this.open = true;
      this.title = "修改";
    },
    /** 复制按钮操作 */
    handleCopy(row) {
      // 新增输入框，必填
      this.$prompt("请输入新的模板名称", "复制模板", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        inputErrorMessage: "请输入模板名称",
        inputValidator: (value) => {
          if (value) {
            return true;
          } else {
            return false;
          }
        },
      })
        .then(({ value }) => {
          this.copyTemplate(row.id, value);
        })
        .catch(() => {});
    },
    // 复制模板
    copyTemplate(rowId, name) {
      let params = {
        id: rowId,
        name: name,
      };
      copyTemplate(params).then((res) => {
        if (res.code == 200) {
          this.$modal.msgSuccess("复制成功");
          this.getList();
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal
        .confirm("是否确认删除该数据项？")
        .then(function () {
          return delTemplate(ids);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        })
        .catch(() => {});
    },
  },
};
</script>
