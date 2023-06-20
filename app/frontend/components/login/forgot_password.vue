<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <div class="row justify-content-center mt-5">
    <div class="col-md-6">
      <h3>Set/Reset Password</h3>
      <p>Don't worry, this happens to the best of us.</p>
      <p>
        If an account with this address exists, you will receive an email with a
        link to complete the password process.
      </p>
      <b-alert :show="alert.visible" :variant="alert.variant">{{
        alert.text
      }}</b-alert>
      <b-form @submit="onSubmit">
        <email-field v-model="person.email" @validated="form.email.valid = $event"
          :validateNow="form.email.validate"></email-field>
        <div class="d-flex flex-row-reverse">
          <b-button :disabled="submitDisabled" type="submit" variant="primary" class="px-5">Send me a link</b-button>
        </div>
      </b-form>
    </div>
  </div>
</template>

<script>
import EmailField from "@/components/shared/email_field.vue";
import { http } from "@/utils/http";
import { validateFields } from "@/utils/utils.js";
import {
  LOGIN_INVALID_FIELDS,
  SOMETHING_WENT_WRONG,
} from "@/constants/strings";
import Tr from "@/i18n/translation"

// import settingsMixin from "@/store/settings.mixin";

export default {
  name: "ForgotPassword",
  mixins: [],
  data: () => ({
    person: {
      email: "",
    },
    alert: {
      variant: "danger",
      visible: false,
      text: "",
    },
    successfullySent: false,
    form: {
      email: {
        valid: null,
        validate: null,
      },
    }
  }),
  components: {
    EmailField,
  },
  computed: {
    submitDisabled: function () {
      return this.form.email.valid === false;
    },
  },
  methods: {
    onSubmit: async function (event) {
      event.preventDefault();
      await validateFields(this.form.email);
      if (this.form.email.valid === false) {
        this.error.text = LOGIN_INVALID_FIELDS;
        this.error.visible = true;
      } else {
        http
          .post("/auth/password.json", { person: this.person })
          .then((data) => {
            this.successfullySent = data.status === 201;
            if (this.successfullySent) {
              this.$router.push(`/${Trans.getPersistedLocale()}/?alert=reset_sent`);
            } else {
              this.alert.text = SOMETHING_WENT_WRONG(this.configByName('email_reply_to_address'));
              this.alert.visible = true;
            }
          })
          .catch((error) => {
            // this.alert.text = SOMETHING_WENT_WRONG(this.configByName('email_reply_to_address'));
            // this.alert.visible = true;
            // Even if we have a problem we need to pretend that we do not
            this.$router.push(`/${Tr.getPersistedLocale()}/?alert=reset_sent`);
          });
      }
    },
  }
};
</script>
