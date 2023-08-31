<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
<div>
  <b-row>
    <b-col>
      <!-- <p>{{ $t('message.hello', { msg: 'hello' }) }}</p> -->
      <p>
      The following 15 random questions will help assess your workplace culture.
      After enough questions have been answered, scores will be displayed, with explanations.
      This will allow you to understand what can be done to improve aspects of your workplace culture that have scores.
      </p>
      <p>
      This survey is anonymous. No-one can know who answers, not even the developers of this application.
      </p>
      <p>
      Note: in the following questions, where a "team" is mentioned, 
      think of the people you interact with the most to perform your tasks.
      If a question does not apply, simply click Next."
      </p>
      <!-- <p>
      You will have the ability to use a respondent identifier to track changes over time.
      You need to complete 15 questions to get a respondent identifier.
      After that you can answer more questions and not need to hit "Submit" to have your answer recorded
      </p> -->
    </b-col>
  </b-row>
  <b-row class="mt-4">
    <b-col sm="9">
      If you have a respondent identifier please enter here before continuing
    </b-col>
    <b-col sm="3">
      <b-form-input 
        v-model="respondent_id" 
        type="text" 
        placeholder="Enter your respondent identifier"
        :state="valid"
        debounce="500"
      ></b-form-input>
      <div class="invalid-feedback">
        {{ error.text }}
      </div>

      <!-- <b-alert :show="error.visible" variant="danger">{{ error.text }}</b-alert> -->
    </b-col>
  </b-row>
  <b-row class="mt-4">
    <b-col>
      <b-button variant="success" @click="onNext">NEXT</b-button>
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
              // if id is null report and error
              // this.$router.push(`/${Tr.getPersistedLocale()}/new_respondent/${this.access_code}`);
              this.error.text = "Respondent ID not found"
              this.error.visible = true
              this.valid = false
            }
          }
        )
      } else {
        // Go to the new respondent screen
        this.$router.push(`/${Tr.getPersistedLocale()}/survey/submit/${this.access_code}`);
        // this.$router.push(`/${Tr.getPersistedLocale()}/new_respondent/${this.access_code}`);
      }
    }    
  }
}
</script>

<style></style>
