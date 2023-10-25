<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
<div>
  <b-row>
    <b-col>
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
        @keyup.enter="onNext"
        data-cy="respondent-id"
      ></b-form-input>
      <div class="invalid-feedback" data-cy="invalid-respondent-id">
        {{ error.text }}
      </div>
    </div>
  </div>
  <b-row class="mt-4">
    <b-col>
      <survey-start-button
        :access_code="access_code"
        :respondent_id="respondent_id"
        :state="valid"
        :disabled="valid == false"
      ></survey-start-button>
    </b-col>
  </b-row>
</div>
</template>

<script>
import modelMixin from '@/mixins/model.mixin';
import modelUtilsMixin from '@/mixins/model_utils.mixin'
import SurveyStartButton from "./survey_start_button.vue"

export default {
  name: "IntroScreen",
  props: {
    access_code: null
  },
  mixins: [
    modelMixin,
    modelUtilsMixin
  ],
  components: { SurveyStartButton },
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

        if (n) {
          // disable and then enable button
          this.valid = false
          this.fetch_model_by_id('respondent', n).then(
            respondent => {
              if (respondent.id) {
                this.valid = true
              } else {
                this.error.text = "Respondent ID not found"
                this.error.visible = true
                this.valid = false
              }
            }
          )
        }          
      }
    }
  }
}
</script>

<style></style>
