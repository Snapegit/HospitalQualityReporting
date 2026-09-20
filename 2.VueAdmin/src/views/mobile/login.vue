<template>
  <div class="login">
    <el-form
      ref="loginForm"
      :model="loginForm"
      :rules="loginRules"
      class="login-forms"
    >
      <div class="title">
        <h2>登录</h2>
      </div>
      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          type="text"
          auto-complete="off"
          placeholder="账号"
        >
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter.native="handleLogin"
        >
        </el-input>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled" class="fl-code">
        <el-input
          v-model="loginForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 70%"
          @keyup.enter.native="handleLogin"
          class="fl-code-input"
        >
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="getCode" class="login-code-imgs" />
        </div>
      </el-form-item>
      <el-checkbox
        v-model="loginForm.rememberMe"
        style="margin: 10px 0px 25px 0px; color: #fff"
        >记住密码</el-checkbox
      >
      <el-form-item style="width: 100%">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          style="width: 100%"
          @click.native.prevent="handleLogin"
        >
          <span class="login-span" v-if="!loading">登 录</span>
          <span class="login-span" v-else>登 录 中...</span>
        </el-button>
        <div style="float: right" v-if="register">
          <router-link class="link-type" :to="'/register'"
            >立即注册</router-link
          >
        </div>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from "@/utils/jsencrypt"

export default {
  name: "Login",
  data () {
    return {
      systems: [
        {
          value: "1",
          label: "系统1",
        },
        {
          value: "2",
          label: "系统2",
        },
        {
          value: "3",
          label: "系统3",
        },
      ],
      value: "",
      codeUrl: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: "",
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" },
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" },
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }],
      },
      loading: false,
      // 验证码开关
      captchaEnabled: true,
      // 注册开关
      register: false,
      redirect: undefined,
    }
  },
  watch: {
    $route: {
      handler: function (route) {
        this.redirect = route.query && route.query.redirect
      },
      immediate: true,
    },
  },
  created () {
    this.getCode()
    this.getCookie()
  },
  methods: {
    getCode () {
      getCodeImg().then((res) => {
        this.captchaEnabled =
          res.captchaEnabled === undefined ? true : res.captchaEnabled
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img
          this.loginForm.uuid = res.uuid
        }
      })
    },
    getCookie () {
      const username = Cookies.get("username")
      const password = Cookies.get("password")
      const rememberMe = Cookies.get("rememberMe")
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password:
          password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe),
      }
    },
    handleLogin () {
      this.$refs.loginForm.validate((valid) => {
        if (valid) {
          this.loading = true
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 })
            Cookies.set("password", encrypt(this.loginForm.password), {
              expires: 30,
            })
            Cookies.set("rememberMe", this.loginForm.rememberMe, {
              expires: 30,
            })
          } else {
            Cookies.remove("username")
            Cookies.remove("password")
            Cookies.remove("rememberMe")
          }
          this.$store
            .dispatch("Login", this.loginForm)
            .then(() => {
              this.$router.push({ path: this.redirect || "/" }).catch(() => { })
            })
            .catch(() => {
              this.loading = false
              if (this.captchaEnabled) {
                this.getCode()
              }
            })
        }
      })
    },
  },
};
</script>

<style rel="stylesheet/scss" lang="scss">
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background: url("../../assets/images/login/login-website.png") no-repeat;
  background-size: cover;
}

.login-forms {
  border-radius: 6px;
  margin: 0 auto;
  margin-top: 80px;
  background: transparent;
  width: 540px;
  .title {
    img {
      width: 100%;
      height: 100%;
    }
    margin-bottom: 50px;
    .eng-title {
      font-size: 30px;
      font-family: D-DIN-Bold, D-DIN;
      font-weight: bold;
      color: #cddaff;
      -webkit-background-clip: text;
    }
    .cn-title {
      font-size: 36px;
      font-family: Source Han Sans CN-Regular, Source Han Sans CN;
      font-weight: 400;
      color: #ffffff;
      -webkit-background-clip: text;
    }
  }
  .el-form-item {
    margin-bottom: 50px;
  }
  .el-input {
    height: 38px;
    input {
      height: 80px;
      font-size: 30px;
      border-radius: 6px;
    }
  }
  .el-form-item__error {
    font-size: 20px;
  }
  .el-checkbox__input.is-checked .is-focus {
    // color: #fff;
    font-size: 30px;
  }
  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
  .el-button--primary,
  .el-button--primary:hover,
  .el-button--primary:focus {
    color: #ffffff;
    border: 1px solid #3962dd;
    height: 100px;
    background: #3962dd;
    box-shadow: 0px 10px 25px 0px rgba(57, 98, 221, 0.3);
    border-radius: 5px 5px 5px 5px;
  }
  .fl-code {
    .el-form-item__content {
      display: flex;
    }
  }

  .login-span {
    font-size: 36px;
  }
}
.login-code {
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}

.login-code-imgs {
  height: 80px;
  margin-left: 15px;
}
</style>
