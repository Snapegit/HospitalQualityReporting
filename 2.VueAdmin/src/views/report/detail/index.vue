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
      <el-form-item  label="所属上报类型" prop="classifyId">
        <el-select
          clearable
          v-model="queryParams.classifyId"
          placeholder="请选择所属上报类型"
        >
          <el-option
            v-for="(v, k) in classifyList"
            :key="k"
            :value="v.id"
            :label="v.classifyName"
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
      <right-toolbar
        :showSearch.sync="showSearch"
        @queryTable="getList"
      ></right-toolbar>
    </el-row>

    <el-table
      v-loading="loading"
      :data="templateList"
    >
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
            @click="view(scope.row)"
            >查看</el-button
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

    <el-dialog title="上报事件详情" :visible.sync="open" width="80%" append-to-body :close-on-click-modal="false" >
      <el-table v-loading="reportLoading" :data="contentList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="id" align="center" prop="id" />
        <el-table-column label="所属模板" align="center" prop="templateName" />
        <el-table-column label="上报标题" align="center" prop="reportTitle" />
        <el-table-column label="上报人" align="center" prop="createByName" />
        <el-table-column label="上报时间" align="center" prop="createTime" />
        <el-table-column label="备注" align="center" prop="remark" :show-overflow-tooltip="true" />
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
              @click="handlePreview(scope.row)"
              v-hasPermi="['report:content:edit']"
            >查看</el-button
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
              v-hasPermi="['report:content:remove']"
            >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="reportTotal > 0"
        :total="reportTotal"
        :page.sync="reportQueryParams.pageNum"
        :limit.sync="reportQueryParams.pageSize"
        @pagination="getReportList"
      />
    </el-dialog>

    <!-- 添加或修改医院事件上报对话框 -->
    <form-generate
        :templateList="templateList"
        ref="formGenerate"
        :title="title"
        v-if="reportOpen"
        @getList="getReportList"
      ></form-generate>

  </div>
</template>

<script>
import {
  detailList,
  listContent,
  getContent,
  delContent,
  addContent,
  updateContent,
} from "@/api/report/content";
import { listTemplate } from "@/api/report/template";
import { getReportClassifySelectList } from "@/api/report/classify";
import FormGenerate from "@/components/FormGenerate";
import { getRepTemplateList } from "@/api/report/template";

export default {
  name: "Content",
  components: {
    FormGenerate,
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 事件上报弹窗遮罩
      reportLoading: true,
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
      // 事件上报总条数
      reportTotal: 0,
      // 医院事件上报表格数据
      contentList: [],
      // 上报模板表格数据
      templateList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层表格
      open: false,
      // 是否显示弹出层form
      reportOpen: false,
      // 上报类型下拉list
      classifyList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        classifyId: null,
        templateName: null,
        templateId: null,
        contentJson: null
      },
      // 事件上报查询参数
      reportQueryParams: {
        pageNum: 1,
        pageSize: 10,
        templateId: null,
        contentJson: null,
      },
    };
  },
  created() {
    this.queryParams.templateId = null;
    this.getReportClassifySelectList();
    // this.getRepTemplateList();
    this.getList();
  },
  methods: {
    /** 查询医院事件上报模板列表 */
    getList() {
      this.loading = true;
      listTemplate(this.queryParams).then((response) => {
        this.templateList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 根据模板id查询其下的事件 */
    getReportList() {
      this.reportLoading = true;
      listContent(this.reportQueryParams).then((response) => {
        this.contentList = response.rows;
        this.reportTotal = response.total;
        this.reportLoading = false;
      });
    },
    // 获取上报类型下拉list
    getReportClassifySelectList() {
      getReportClassifySelectList().then((response) => {
        this.classifyList = response.data;
      });
    },
    // 获取上报模板下拉list
    getRepTemplateList() {
      getRepTemplateList().then((res) => {
        console.log(res);
        if (res.code == 200) {
          this.templateList = res.data;
        }
      });
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.id);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        templateId: null,
        contentJson: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null,
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
    /** 查看按钮操作 */
    view(row) {
      this.reset()
      this.open = true
      this.reportQueryParams.templateId = row.id
      this.getReportList()
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids;
      getContent(id).then((response) => {
        this.form = response.data;
        this.reportOpen = true;
        this.title = "修改";
        this.$nextTick(() => {
          this.$refs.formGenerate.init(response.data)
        })
      });

    },
     /** 查看按钮操作 */
      handlePreview(row) {
      this.reset();
      const id = row.id || this.ids;
      getContent(id).then((response) => {
        this.form = response.data;
        this.reportOpen = true;
        this.title = "查看";
        this.$nextTick(() => {
          this.$refs.formGenerate.init(response.data)
        })
      });

    },

    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal
        .confirm("是否确认删除该数据项？")
        .then(function () {
          return delContent(ids);
        })
        .then(() => {
          this.getReportList();
          this.$modal.msgSuccess("删除成功");
        })
        .catch(() => {});
    }
  },
};
</script>
