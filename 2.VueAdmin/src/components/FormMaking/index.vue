<template>
  <!-- <div> -->
  <div class="dynamicForm">
    <!-- 必填表单 -->
    <div class="mustInput">
      <el-form ref="form" :model="form" :rules="rules" label-width="150px">
        <el-row>
          <el-col :span="7">
            <el-form-item label="所属上报类型" prop="classifyId">
              <el-select v-model="form.classifyId" style="width:300px">
                <el-option
                  v-for="classify in classifys"
                  :label="classify.classifyName"
                  :value="classify.id"
                  :key="classify.id"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="7">
            <el-form-item label="模板名称" prop="templateName">
              <el-input
              style="width:300px"
                v-model="form.templateName"
                placeholder="请输入模板名称"
              />
            </el-form-item>
          </el-col>
          <el-col :span="7">
            <el-form-item label="允许上报次数" prop="reportNum">
             <el-select v-model="form.reportNum">
                <el-option
                  v-for="reportNumOption in reportNumOptions"
                  :label="reportNumOption.label"
                  :value="reportNumOption.value"
                  :key="reportNumOption.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
    </div>

    <div class="makingForm">
      <!-- 表单模板 -->
      <fc-designer
        ref="designer"
        :menu="menuList"
        style="height: 600px; display: block"
      >
      </fc-designer>

      <div class="submitBtn">
        <el-button type="primary" @click="handleSubmit">提交</el-button>
      </div>
    </div>
  </div>
</template>
<script >
import { addTemplate, updateTemplate } from "@/api/report/template";
import radio from "@form-create/designer/src/config/rule/radio";
import checkbox from "@form-create/designer/src/config/rule/checkbox";
import input from "@form-create/designer/src/config/rule/input";
import number from "@form-create/designer/src/config/rule/number";
import select from "@form-create/designer/src/config/rule/select";
import time from "@form-create/designer/src/config/rule/time";
import date from "@form-create/designer/src/config/rule/date";
import rate from "@form-create/designer/src/config/rule/rate";
import row from "@form-create/designer/src/config/rule/row";
// import cascader from "@form-create/designer/src/config/rule/cascader";
import upload from "@form-create/designer/src/config/rule/upload";
import editor from "@form-create/designer/src/config/rule/editor";
import uniqueId from "@form-create/utils/lib/unique";
export default {
  name: "ChildrenOne",
  props: {
    classifys: Array, //上报类型数据
    templateValue: Object, //(修改用)模板表单数据
  },
  data() {
    return {
      /* 模板标题和id表单 */
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        classifyId: [
          {
            required: true,
            message: "关联上报分类表id不能为空",
            trigger: "blur",
          },
        ],
        templateName: [
          { required: true, message: "模板名称不能为空", trigger: "blur" },
        ],
        reportNum: [
            { required: true, message: "允许上报次数不能为空", trigger: "blur" },
        ]
      },
      reportNumOptions: [//上报次数下拉
        {
          value: 1,
          label: '一次'
        }, {
          value: 0,
          label: '多次'
        },
      ],
      //   左侧菜单功能列表
      menuList: [
        {
          name: "main",
          title: "表单组件",
          list: [
            input,
            number,
            radio,
            checkbox,
            select,
            time,
            date,
            // cascader,
            upload,
            editor,
            rate,
          ],
        },
        {
          name: "layout",
          title: "布局组件",
          list: [row],
        },
      ],
      test: false,
      /* 模板标题和id结束 */
      jsonData: {
        reportNum: "",//上报次数
        classifyId: "", //分类id
        templateName: "", //模板名称
        formProperty: "", //表单属性
        unitProperty: "", //组件属性
      },
    };
  },
  watch: {
    test: {
      handler(newVal, oldVal) {
        console.log(newVal, oldVal);
      },
    },
  },
  methods: {
    handleSubmit() {
      if (!this.form.classifyId) {
        this.$message({
          message: "请输入关联上报分类",
          type: "warning",
        });
        return;
      }
      if (!this.form.templateName) {
        this.$message({
          message: "请输入模板名称",
          type: "warning",
        });
        return;
      }

      //FcDesigner 生成的`JSON`
      const FcDesignerRule = this.$refs.designer.getRule();
      let FcDesignerRuleFirst = this.$refs.designer.getRule();
      let successFunc = (res, file) => {
        file.url = res.data.url || "";
      };
      let handleFunc = (files) => {
        console.log(files);
      };
      for (var item in FcDesignerRule) {
        // 上传文件
        if (FcDesignerRule[item].type == "upload") {
          FcDesignerRule[item] = {
            type: "upload",
            field: uniqueId(),
            title: FcDesignerRuleFirst[item].title,
            handleIcon: true,
            withCredentials: true,
            props: {
              handleIcon: true,
              action: process.env.VUE_APP_UPLOAD_URL + "/wechat/upload",
              uploadType: FcDesignerRuleFirst[item].props.uploadType,
              onHandle: handleFunc.toString(),
              onSuccess: successFunc.toString(),
            },
            value: [],
          };
        //   $required:如果有校验必填等
          if (FcDesignerRuleFirst[item].$required) {
            FcDesignerRule[item].$required =
              FcDesignerRuleFirst[item].$required;
          }
        //   富文本
        } else if (FcDesignerRule[item].type == "fc-editor") {
          FcDesignerRule[item].props = {};
          FcDesignerRule[item].props.disabled = false;
        //   评分：评分验证框架有bug，手动加入验证
        } else if (FcDesignerRule[item].type == "rate") {
          let errorMsg = "";
          if ("$required" in FcDesignerRule[item]) {
            if (FcDesignerRule[item].$required == "") {
              errorMsg = "请至少大于1颗星";
              delete FcDesignerRule[item].$required;
            } else {
              errorMsg = FcDesignerRule[item].$required;
              delete FcDesignerRule[item].$required;
            }
          } else {
            errorMsg = "请至少大于1颗星";
          }
          FcDesignerRule[item].validate = {
            required: true,
            type: "number",
            min: 1,
            message: errorMsg,
            trigger: "change",
          };
        }
      }
      //FcDesigner 生成的`options`
      const FcDesignerOptions = this.$refs.designer.getOption();
      FcDesignerOptions.form.showMessage = true;
      this.jsonData.classifyId = this.form.classifyId;
      this.jsonData.templateName = this.form.templateName;
      this.jsonData.reportNum = this.form.reportNum;
      this.jsonData.formProperty = JSON.stringify(FcDesignerRule);
      this.jsonData.unitProperty = JSON.stringify(FcDesignerOptions);
      this.addTemplate();
    },
    // 上报模板方法
    addTemplate() {
      // 判断是修改还是新增
      if (Object.keys(this.templateValue).length > 0) {
        this.updateTemplateVal();
      } else {
        this.addTemplateVal();
      }
    },
    // 新增模板
    addTemplateVal() {
      addTemplate(this.jsonData).then((res) => {
        if (res.code == 200) {
          this.$message({
            message: "新增上报模板成功",
            type: "success",
          });
          this.$emit("refreshList");
        }
      });
    },
    // 修改模板
    updateTemplateVal() {
      this.jsonData.id = this.templateValue.id;
      updateTemplate(this.jsonData).then((res) => {
        if (res.code == 200) {
          this.$message({
            message: "修改上报模板成功",
            type: "success",
          });
          this.$emit("refreshList");
        }
      });
    },
    addTooltip() {
      let that = this;
      // 获取模板预览按钮组件，并增加监听事件
      let elementsByClassName = document.getElementsByClassName("el-header")[0];
      let elementsByTagName =
        elementsByClassName.getElementsByTagName("button")[0];
      elementsByTagName.addEventListener("click", function (event) {
        // 模板组件如有提示语，修改显示的方式
        that.$nextTick(() => {
          let labelDivs = document.getElementsByTagName("label");
          let FcDesignerRule = that.$refs.designer.getRule();
          for (let i in FcDesignerRule) {
            if (FcDesignerRule[i].info) {
              for (let labelDiv of labelDivs) {
                // 寻找带有info提示语的标题span，找到后后面追加div
                if (
                  labelDiv.getAttributeNode("for") !== null &&
                  labelDiv.getElementsByTagName("span")[1] &&
                  labelDiv.getElementsByTagName("span")[0].innerText.trim() ==
                    FcDesignerRule[i].title
                ) {
                  let createDiv = document.createElement("div"); //创造一个div元素
                  createDiv.classList.add("createDivBox"); //加入class类
                  createDiv.style.color = "#7f8082";
                  createDiv.innerHTML = "(" + FcDesignerRule[i].info + ")";
                  labelDiv.appendChild(createDiv);
                }
              }
            }
          }
        });
      });
    },
  },

  mounted() {
    this.addTooltip();
    const option = {
      form: {
        labelPosition: "right",
        size: "medium",
        labelWidth: "125px",
        hideRequiredAsterisk: false,
        showMessage: false,
        inlineMessage: false,
      },
    };
    // templateValue不为空对象即是修改，要赋值；空对象就是新增
    if (Object.keys(this.templateValue).length > 0) {
      let unitProperty = this.templateValue.unitProperty; //form表单配置
      let formProperty = this.templateValue.formProperty; //form表单内容
      let classifyId = this.templateValue.classifyId; //上报类型
      let templateName = this.templateValue.templateName; //模板名称
      let reportNum= this.templateValue.reportNum;//上报次数
      this.$refs.designer.setOption(JSON.parse(unitProperty));
      this.$refs.designer.setRule(JSON.parse(formProperty));
      this.form = {
        classifyId: classifyId,
        templateName: templateName,
        reportNum: reportNum
      };
    } else {
      this.$refs.designer.setOption(option);
    }
  },
};
</script>

<style scoped>
.makingForm ::v-deep.el-aside {
  width: 380px !important;
}
.makingForm {
  position: relative;
  margin-bottom: 20px;
}
.submitBtn {
  position: absolute;
  right: 45px;
  bottom: -33px;
}
</style>
