<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
<div>
  <b-row>
    <b-col>
      <!-- <p>{{ $t('message.hello', { msg: 'hello' }) }}</p> -->
      <p>
      {{ $t('survey.intro_random') }}<br>
      {{ $t('survey.intro_enough') }}<br>
      {{ $t('survey.intro_purpose') }}
      </p>
      <p>
        {{ $t('survey.intro_anonymous') }}
      </p>
      <p>
        {{ $t('survey.intro_team') }}<br>
        {{ $t('survey.intro_NA') }}
      </p>
    </b-col>
  </b-row>
  <div class="d-flex mt-4">
    <div class="mr-3">
      <b>{{ $t('survey.intro_identifier') }}</b>
    </div>
    <div>
      <b-form-input 
        v-model="respondent_id" 
        type="text" 
        :placeholder="$t('survey.intro_idfield')"
        :state="valid"
        debounce="500"
        data-cy="respondent-id"
      ></b-form-input>
      <div class="invalid-feedback" data-cy="invalid-respondent-id">
        {{ error.text }}
      </div>

      <!-- <b-alert :show="error.visible" variant="danger">{{ error.text }}</b-alert> -->
    </div>
  </div>
  <b-row class="mt-4">
    <b-col>
      <b-button variant="success" @click="onNext" data-cy="start-survey-button">{{ $t('next') }}</b-button>
    </b-col>
  </b-row>
</div>
</template>

<script>
import modelMixin from '@/mixins/model.mixin';
import modelUtilsMixin from '@/mixins/model_utils.mixin'
import Tr from "@/i18n/translation"

export default {
  name: "IntroScreen",
  props: {
    access_code: null
  },
  mixins: [
    modelMixin,
    modelUtilsMixin
  ],
  data() {
    return {
      valid: null,
      respondent_id: null,
      error: {
        visible: false,
        text: "",
      }
    }
  },
  watch: {
    respondent_id(n,o) {
      if (n != o) {
        this.error.visible = false
        this.valid = true
      }
    }
  },
  methods: {
    onNext: function() {
      // if we have a respondent id we check it and go to the survey
      // Otherwise we got to a page to gen the respondent id and then go to the survey
      if (this.respondent_id) {
        this.fetch_model_by_id('respondent', this.respondent_id).then(
          respondent => {
            if (respondent.id) {
              // got to the survey
              // survey/submit/:access_code
              this.$router.push(`/${Tr.getPersistedLocale()}/survey/submit/${this.access_code}`);
            } else {
              // if id is null report an error
              // this.$router.push(`/${Tr.getPersistedLocale()}/new_respondent/${this.access_code}`);
              this.error.text = "Respondent ID not found"
              this.error.visible = true
              this.valid = false
            }
          }
        )
      } else {
        // TODO: clear respondent ... 
        // Go to the new respondent screen
        this.$router.push(`/${Tr.getPersistedLocale()}/survey/submit/${this.access_code}`);
        // this.$router.push(`/${Tr.getPersistedLocale()}/new_respondent/${this.access_code}`);
      }
    }    
  }
}
</script>

<style></style>
