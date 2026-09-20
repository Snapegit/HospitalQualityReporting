<template>
  <div>
    <el-dialog
      :title="title"
      width="70%"
      append-to-body
      :visible.sync="visible"
      :close-on-click-modal="false"
    >
      <el-form
        style="padding-left: 23px"
        ref="form"
        :model="form"
        :rules="rules"
        :disabled="formDisabled"
        label-width="100px"
      >
        <el-form-item label="上报标题" prop="reportTitle">
          <el-input
            clearable
            style="width: 100%"
            v-model="form.reportTitle"
            placeholder="请输入内容"
            @input="inputChange"
          />
        </el-form-item>
        <el-form-item label="所属模板" prop="templateId">
          <el-select
            clearable
            v-model="form.templateId"
            placeholder="请选择所属模板"
            style="width: 100%"
            @change="getTemplate"
            :disabled="disabled"
          >
            <el-option
              v-for="(v, k) in templateList"
              :key="k"
              :value="v.id"
              :label="v.templateName"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="form.remark"
            type="textarea"
            placeholder="请输入内容"
          />
        </el-form-item>
      </el-form>
      <!-- 动态修改表单 -->
      <!-- <fm-generate-form :data="jsonData" :value="values" ref="generateForm">
      </fm-generate-form> -->
      <form-create
        id="createForm"
        ref="generateForm"
        v-model="fApi"
        :value.sync="values"
        :rule="FcDesignerRule"
        :option="FcDesignerOptions"
      >
      </form-create>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" v-if="title !== '查看'" @click="submitForm"
          >确 定</el-button
        >
        <el-button @click="visible = false">取 消</el-button>
      </div>
    </el-dialog>
    <el-dialog
      title="预览"
      width="70%"
      append-to-body
      :visible.sync="previewFileVisible"
      :close-on-click-modal="false"
    >
      <el-image ref="previewImg" :src="fileUrl"></el-image>
    </el-dialog>
  </div>
</template>

<script >
import { getTemplate } from "@/api/report/template";
import { addContent, updateContent } from "@/api/report/content";

export default {
  name: "FormGenerate",
  props: {
    templateList: Array,
    title: String,
  },
  data() {
    return {
      formDisabled: false, //查看时所有组件都禁用
      disabled: false, //模板下拉是否禁用
      updateData: undefined, //修改中待回显的数据
      visible: false,
      jsonData: {
        list: [],
        config: {},
      },
      FcDesignerRule: [], //表单列表
      FcDesignerOptions: {}, //表单属性
      fApi: {},
      values: {}, // 表单需要显示的表单数据
      // 表单参数
      form: {
        remark: "",
        templateId: "",
        reportTitle: "",
      },
      // 表单校验
      rules: {
        reportTitle: [
          { required: true, message: "上报标题不能为空", trigger: "blur" },
        ],
        templateId: [
          { required: true, message: "所属模板不能为空", trigger: "blur" },
        ],
      },
      previewFileVisible: false, //预览文件
      uploadFiles: {}, //上传文件列表
      fileUrl: "", //预览文件地址
      uploadDiv: "",
    };
  },
  methods: {
    // input框输入内容发生变化
    inputChange(e) {
      this.$forceUpdate();
    },
    // 图片预览
    previewFile(item) {
      console.log(item);
      let fileUrls = item.split(".");
      console.log(fileUrls[fileUrls.length - 1]);
      if (
        fileUrls[fileUrls.length - 1] == "png" ||
        fileUrls[fileUrls.length - 1] == "jpg" ||
        fileUrls[fileUrls.length - 1] == "jpeg"
      ) {
        this.fileUrl = item;
        this.previewFileVisible = true;
        // this.$refs.previewImg.showViewer = true;
      } else {
        this.$message({
          message: "暂不支持预览",
          type: "warning",
        });
        return;
      }
    },
    init(data) {
      this.FcDesignerRule = [];
      this.FcDesignerOptions = {};
      this.form = {
        remark: "",
        templateId: "",
        reportTitle: "",
      };
    // 有数据是修改或者查看方法
      if (data) {
        if (this.title == "查看") {
          this.formDisabled = true;
        } else {
          this.formDisabled = false;
        }
        // 有值说明是修改
        this.updateData = JSON.parse(JSON.stringify(data));

        this.formViewData(); //修改要回显表单数据
        this.$nextTick(() => {
          this.$refs["form"].clearValidate();//清除校验
        });
        this.disabled = true;
      } else {
        this.updateData = undefined;
        this.formDisabled = false;
        this.disabled = false;
      }
      this.visible = true;
    },
    // 根据当前id去获取到模板数据
    formViewData() {
      this.getTemplate(this.updateData.templateId);
    },
    // 点击提交方法
    submitForm() {
      //   获取到表单填入的数据
      let formValue = this.$refs.generateForm.value; //获取到表单数据
      this.$refs["form"].validate((valid) => {
        if (valid) {
          this.fApi.validate((validForm, fail) => {
            if (validForm) {
                for (var i in this.FcDesignerRule) {
                    // 下拉框并且是多选下拉，修改回显值的类型
                if (this.FcDesignerRule[i].type == "select" && this.FcDesignerRule[i].props && this.FcDesignerRule[i].props.multiple == true) {
                    let field = this.FcDesignerRule[i].field
                    if (formValue[field]) {
                        formValue[field] = formValue[field].join(',')
                    }
                }
                if (this.FcDesignerRule[i].type == "checkbox") {
                    let field = this.FcDesignerRule[i].field
                    console.log(formValue[field], typeof(formValue[field]))
                    if (formValue[field]) {
                        formValue[field] = formValue[field].join(',')
                    }
                }

            }
            let formVal = JSON.stringify(formValue);
            let formData = {
                reportTitle: this.form.reportTitle,
                remark: this.form.remark,
                templateId: this.form.templateId,
                contentJson: formVal,
            };
              console.log("验证通过");
              if (this.title == "新增") {
                //新增方法
                this.submitAddTemplateData(formData);
              } else {
                formData.id = this.updateData.id;
                this.submitUpdateTemplateData(formData); //修改方法
              }
            } else {
                console.log(fail)
            }
          });
        }
      });
    },
    // 新增数据
    submitAddTemplateData(formData) {
      addContent(formData).then((res) => {
        if (res.code == 200) {
          this.$modal.msgSuccess("新增数据成功");
          this.visible = false;
          this.$emit("getList");
        }
      });
    },
    // 修改数据
    submitUpdateTemplateData(formData) {
      updateContent(formData).then((res) => {
        if (res.code == 200) {
          this.$modal.msgSuccess("修改数据成功");
          this.visible = false;
          this.$emit("getList");
        }
      });
    },
    // 获取模板
    getTemplate(item) {
      let temId = item.toString();
      getTemplate(temId).then((res) => {
        if (res.code == 200) {
          let list = res.data.unitProperty;
          let prop = res.data.formProperty;
          this.FcDesignerRule = JSON.parse(prop);
          this.FcDesignerOptions = JSON.parse(list);
          this.FcDesignerOptions.form.disabled = this.formDisabled;
        //   有数据就赋值回显
          if (this.updateData) {
            this.form.reportTitle = this.updateData.reportTitle;
            this.form.templateId = this.updateData.templateId;
            this.form.remark = this.updateData.remark;
            this.values = JSON.parse(this.updateData.contentJson);
          }
          for (var i in this.FcDesignerRule) {
            // 富文本
            if (this.FcDesignerRule[i].type == "fc-editor") {
              this.FcDesignerRule[i].props.disabled = this.formDisabled;
            }
            // 文件上传
            if (
              this.FcDesignerRule &&
              this.FcDesignerRule[i].type == "upload"
            ) {
              this.uploadFiles = this.FcDesignerRule[i];
              //   break;
            }
            // 多选下拉
            if (this.FcDesignerRule[i].type == "select" && this.FcDesignerRule[i].props && this.FcDesignerRule[i].props.multiple == true) {
                console.log(this.FcDesignerRule[i])
                let field = this.FcDesignerRule[i].field
                if (this.values[field]) {
                    this.values[field] = this.values[field].split(',')
                }
            }
            if (this.FcDesignerRule[i].type == "checkbox") {
                console.log(this.FcDesignerRule[i])
                let field = this.FcDesignerRule[i].field
                if (this.values[field]) {
                    this.values[field] = this.values[field].split(',')
                }
            }
          }
        //   加入info提示语
          this.$nextTick(() => {
            let labelDivs = document.getElementsByTagName('label')
            for(var i in this.FcDesignerRule) {
                if (this.FcDesignerRule[i].info) {
                    for(let labelDiv of labelDivs) {
                        // 寻找带有info提示语的标题span，找到后后面追加div
                        if (labelDiv.getAttributeNode('for') !== null && labelDiv.getElementsByTagName('span')[1] && labelDiv.getElementsByTagName('span')[0].innerText.trim() == this.FcDesignerRule[i].title) {
                            let createDiv = document.createElement("div"); //创造一个div元素
                            createDiv.classList.add("createDivBox"); //加入class类
                            createDiv.style.color = '#7f8082'
                            createDiv.innerHTML = '('+this.FcDesignerRule[i].info + ')'
                            labelDiv.appendChild(createDiv);
                        }
                    }
                }
            }
          })
        //   上传组件后加上文件名称列表
          if (this.uploadFiles.value) {
            this.$nextTick(() => {
              let uploadDiv = document.getElementsByClassName("_fc-upload")[0]; //获取到上传组件
              var li = document.createElement("div"); //创造一个div元素
              li.classList.add("fileListBox"); //加入class类
              let files = this.uploadFiles.value; //根据文件数量去循环
              for (var i = 0; i < files.length; i++) {
                let uploadfile = this.updateUploadFile(files[i]);
                var liChild = document.createElement("div"); //创造子div
                liChild.classList.add("fileLi");
                liChild.id = "fileLi-" + i; //加动态id
                liChild.innerHTML = uploadfile;
                liChild.addEventListener("mouseenter", (e) => {
                  let ids = e.currentTarget.id; //获取到当前元素的id
                  let id = document.getElementById(ids);
                  id.style.color = "#46a6ff";
                  id.style.cursor = "pointer";
                });
                liChild.addEventListener("mouseleave", (e) => {
                  let ids = e.currentTarget.id; //获取到当前元素的id
                  let id = document.getElementById(ids);
                  id.style.color = "#000";
                  id.style.cursor = "none";
                });
                liChild.addEventListener("click", (e) => {
                  let ids = e.currentTarget.id.split("-"); //获取到当前元素的id
                  let id = ids[1]; //提取出i
                  this.previewFile(files[id]);
                });
                // 向li中添加文本内容
                uploadDiv.appendChild(liChild);
              }
            });
          }
        }
      });
    },
    // 整理上传文件的名称格式
    updateUploadFile(item) {
      let fileUrls = item.split("/");
      return fileUrls[fileUrls.length - 1];
    },
  },
};
</script>

<style lang="scss" scoped>
.green {
  color: green;
}
.fileListBox {
  width: 800px;
}
.fileLi {
  margin-bottom: 10px;
  cursor: pointer;
}
.fileLi:hover {
  color: #46a6ff;
}
</style>
