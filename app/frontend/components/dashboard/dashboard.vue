<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <div class="row">
    <div class="col" v-if="loggedIn">
      <organization-manage></organization-manage>
    </div>
    <div v-else class="intro-text container">
      <div class="d-flex mt-4">
        {{ $t('dashboard.intro_text') }}
      </div>
      <div class="d-flex mt-2 mb-2">
        {{ $t('dashboard.survey_code_text') }}
      </div>
      <div class="d-flex">
        <div class="w-50">
          <b-form-input 
            v-model="access_code" 
            type="text" 
            :placeholder="$t('survey.access_code')"
            autofocus="true"
            :state="valid"
            debounce="500"
          ></b-form-input>
          <div class="invalid-feedback">
            {{ error.text }}
          </div>
        </div>
        <div class="ml-2">
          <b-button variant="success" @click="onNext">GO</b-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import modelMixin from '@/mixins/model.mixin';
import modelUtilsMixin from '@/mixins/model_utils.mixin'
import userSessionMixin from "@/mixins/user_session.mixin"
import OrganizationManage from '@/components/organizations/organization_manage.vue';

import { mapActions } from 'vuex';
import { FIND_SURVEY } from '@/store/survey/survey.actions';
import Tr from "@/i18n/translation"

export default {
  name: "Dashboard",
  components: {
    OrganizationManage
  },
  mixins: [
    modelMixin,
    modelUtilsMixin,
    userSessionMixin
  ],
  data() {
    return {
      valid: null,
      access_code: null,
      error: {
        visible: false,
        text: " PROBLEM",
      }
    }
  },
  watch: {
    access_code(n, o) {
      if (n != o) {
        this.error.visible = false
        this.valid = true
      }
    }
  },
  methods: {
    ...mapActions({
      findSurvey: FIND_SURVEY
    }),
    onNext: function () {
      // if we have a respondent id we check it and go to the survey
      // Otherwise we got to a page to gen the respondent id and then go to the survey
      if (this.access_code) {
        this.findSurvey({ access_code: this.access_code }).then(
          survey => {
            if (survey.id) {
              // got to the survey
              this.$router.push(`/${Tr.getPersistedLocale()}/intro/${this.access_code}`);
            }
          }
        ).catch((error) => {
          this.error.text = "Survey not found!"
          this.error.visible = true
          this.valid = false
        });
      }
    }
  }
}
</script>

<style scoped>
.intro-text {
  width: 500px;
  margin-top: 50px;
  margin-right: auto;
  margin-left: auto;
  margin-bottom: 0px;
}
</style>
