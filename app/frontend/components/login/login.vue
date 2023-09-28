<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <div class="row justify-content-center mt-5">
    <div class="col-md-6">
      <b-alert :show="alert.visible" variant="success" dismissible>{{
        alert.text
      }}</b-alert>
      <b-alert :show="error.visible" variant="danger">{{ error.text }}</b-alert>
      <b-form @submit="onSubmit">
        <email-field v-model="user.email" @validated="form.email.valid = $event"
          :validateNow="form.email.validate"></email-field>
        <login-password-field v-model="user.password" @validated="form.password.valid = $event"
          :validateNow="form.password.validate"></login-password-field>
        <div class="d-flex flex-row-reverse mb-3">
          <router-link to="/login/forgot">Forgot Password?</router-link>
        </div>
        <div class="d-flex flex-row-reverse">
          <b-button type="submit" variant="primary" class="px-5">Log In</b-button>
        </div>
      </b-form>
      <div class="d-flex mb-3">
        <router-link to="/login/forgot">Never set up your password? Set it up now</router-link>
      </div>
    </div>
  </div>
</template>

<script>
import EmailField from "@/components/shared/email_field.vue";
import LoginPasswordField from "@/components/login/login_password_field.vue";
import axios from 'axios';
import { userSessionMixin } from '@/mixins/user_session.mixin';
import { authMixin } from '@/mixins/auth.mixin';
import Tr from "@/i18n/translation"

import { validateFields } from "@/utils/utils.js";

import {
  LOGIN_401,
  LOGIN_MISSING_PASSWORD,
  LOGIN_INVALID_FIELDS,
  LOGIN_PASSWORD_RESET_EMAIL_SEND,
  LOGIN_PASSWORD_CHANGED,
} from "@/constants/strings";

export default {
  name: "Login",
  data() {
    return {
      user: {
        email: "",
        password: "",
      },
      error: {
        visible: false,
        text: "",
      },
      alert: {
        visible: false,
        text: "",
      },
      form: {
        email: {
          valid: null,
          validate: null,
        },
        password: {
          valid: null,
          validate: null,
        },
      },
    };
  },
  components: {
    EmailField,
    LoginPasswordField
  },
  mixins: [authMixin, userSessionMixin],
  computed: {
    conventionName() {
      return this.configByName('convention_name') || ''
    }
  },
  beforeRouteEnter(to, from, next) {
    next(vm => {
      vm.prevRoute = from
    })
  },
  mounted: function () {
    if (this.$route.query.alert) {
      switch (this.$route.query.alert) {
        case "reset_sent":
          this.alert.text = LOGIN_PASSWORD_RESET_EMAIL_SEND;
          this.alert.visible = true;
          break;
        case "password_changed":
          this.alert.text = LOGIN_PASSWORD_CHANGED;
          this.alert.visible = true;
          break;
        default:
          this.alert.visible = false;
      }
    }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();
      validateFields(this.form.email, this.form.password).then(() => {
        if (
          this.form.email.valid === false ||
          this.form.password.valid === false
        ) {
          this.error.text = LOGIN_INVALID_FIELDS;
          this.error.visible = true;
        } else {
          axios.post('/auth/sign_in', { user: this.user })
            .then(
              () => {
                this.fetchSession().then(
                  () => {
                    if (this.prevRoute) {
                      this.$router.push(this.prevRoute)
                    } else {
                      this.$router.push(`/${Tr.getPersistedLocale()}/launchpad`)
                    }
                  }
                )
              }
            )
            .catch((error) => this.onSaveFailure(error));
        }
      })
    },
    onSaveFailure: function (error) {
      this.error.text = error.message;
      if (error.message === "Request failed with status code 401") {
        this.error.text = LOGIN_401;
      }
      this.error.visible = true;
    }
  }
};
</script>
