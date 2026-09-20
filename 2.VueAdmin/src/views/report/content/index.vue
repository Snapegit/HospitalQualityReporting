<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryForm"
      size="small"
      :inline="true"
      v-show="showSearch"
      label-width="68px"
    >
      <el-form-item label="所属模板" prop="templateId">
        <el-select
          clearable
          v-model="queryParams.templateId"
          placeholder="请选择所属模板"
        >
          <el-option
            v-for="(v, k) in templateList"
            :key="k"
            :value="v.id"
            :label="v.templateName"
          ></el-option>
        </el-select>
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
          v-hasPermi="['report:content:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['report:content:edit']"
          >修改</el-button
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
          v-hasPermi="['report:content:remove']"
          >删除</el-button
        >
      </el-col>
      <!--      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['report:content:export']"
          >导出</el-button
        >
      </el-col>-->
      <right-toolbar
        :showSearch.sync="showSearch"
        @queryTable="getList"
      ></right-toolbar>
    </el-row>

    <el-table
      v-loading="loading"
      :data="contentList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="id" align="center" prop="id" />
      <el-table-column label="所属模板" align="center" prop="templateName" />
      <el-table-column label="上报标题" align="center" prop="reportTitle" />
      <el-table-column label="上报人" align="center" prop="createByName" />
      <el-table-column label="上报时间" align="center" prop="createTime" />
      <el-table-column
        label="备注"
        align="center"
        prop="remark"
        :show-overflow-tooltip="true"
      />
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
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改医院事件上报对话框 -->
    <form-generate
      :templateList="templateList"
      ref="formGenerate"
      :title="title"
      v-if="open"
      @getList="getList"
    ></form-generate>
  </div>
</template>

<script>
import {
  listContent,
  getContent,
  delContent,
  addContent,
  updateContent,
} from "@/api/report/content";
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
      // 医院事件上报表格数据
      contentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 上报类型下拉list
      classifyList: [],
      //   上报模板下拉list
      templateList: [],
      // 查询参数
      queryParams: {
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
    this.getRepTemplateList();
    this.getList();
  },
  methods: {
    /** 查询医院事件上报列表 */
    getList() {
      this.loading = true;
      listContent(this.queryParams).then((response) => {
        this.contentList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 获取上报类型下拉list
    getReportClassifySelectList() {
      getReportClassifySelectList().then((response) => {
        this.classifyList = response.data;
        console.log(this.classifyList);
      });
    },
    getRepTemplateList() {
      getRepTemplateList().then((res) => {
        console.log(res);
        if (res.code == 200) {
          this.templateList = res.data;
        }
      });
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
      this.$nextTick(() => {
        console.log('新增窗口进入')
        this.$refs.formGenerate.uploadFiles = {};
        this.$refs.formGenerate.init();
      });
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids;
      getContent(id).then((response) => {
        this.form = response.data;
        this.open = true;
        this.title = "修改";
        this.$nextTick(() => {
          this.$refs.formGenerate.init(response.data);
        });
      });
    },
    /** 查看按钮操作 */
    handlePreview(row) {
      this.reset();
      const id = row.id || this.ids;
      getContent(id).then((response) => {
        this.form = response.data;
        this.open = true;
        this.title = "查看";
        this.$nextTick(() => {
          this.$refs.formGenerate.init(response.data);
        });
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          if (this.form.id != null) {
            updateContent(this.form).then((response) => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addContent(this.form).then((response) => {
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
      const ids = row.id || this.ids;
      this.$modal
        .confirm("是否确认删除该数据项？")
        .then(function () {
          return delContent(ids);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        })
        .catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download(
        "report/content/export",
        {
          ...this.queryParams,
        },
        `content_${new Date().getTime()}.xlsx`
      );
    },
  },
};
</script>
