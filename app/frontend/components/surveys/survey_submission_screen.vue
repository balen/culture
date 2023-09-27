<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
<div v-if="number_questions > 0" class="mt-5">
  <h5>{{ questions[current_question].question }}</h5>
  <likert
    :settings="questions[current_question].likert_setting"
    v-model="responses[questions[current_question].id].response.value"
    class="mt-5"
  ></likert>
  <div class="mt-2 d-flex justify-content-between">
    <div class="d-flex justify-content-start">
      <b-button v-if="current_question > 0" data-cy="likert-button-prev" class="ml-5" variant="secondary" @click="prevQuestion">{{ $t('previous') }}</b-button>
    </div>
    <div class="d-flex justify-content-end">
      <b-button v-if="current_question < (number_questions - 1)" data-cy="likert-button-next" class="mr-5" variant="primary" @click="nextQuestion">{{ $t('next') }}</b-button>
      <b-button v-if="current_question == (number_questions - 1)" data-cy="likert-button-next" class="mr-5" variant="success" @click="submitResponses">{{ $t('submit') }}</b-button>
    </div>
  </div>
</div>
</template>

<script>
import { mapActions } from 'vuex';
import { START_SUBMISSION, NEW_SUBMISSION } from '@/store/survey/survey.actions';
import Likert from '@/components/surveys/likert.vue'
import modelMixin from '@/mixins/model.mixin';
import submissionMixin from './submission.mixin';
import modelUtilsMixin from '@/mixins/model_utils.mixin'
import { organizationSurveyModel } from '@/store/organization_survey.store';
import {
  submissionModel,
  responseModel
} from '@/store/survey/survey.model';
import Tr from "@/i18n/translation"

export default {
  name: "SurveySubmissionScreen",
  props: {
    access_code: null
  },
  data: () => ({
    questions: [],
    current_question: 0,
    number_questions: 0,
    responses: {}
  }),
  components: {
    Likert
  },
  mixins: [
    modelMixin,
    modelUtilsMixin,
    submissionMixin
  ],
  methods: {
    ...mapActions({
      startSubmission: START_SUBMISSION,
      newSubmission: NEW_SUBMISSION
    }),
    nextQuestion() {
      let current = this.current_question;
      if (!this.selected_model(submissionModel)) {
        this.createSubmission().then(() => this.saveResponse(current))
      } else {
        this.saveResponse(current);
      }

      if (this.current_question < (this.number_questions - 1)) {
        this.current_question += 1;
      }
    },
    prevQuestion() {
      if (this.current_question > 0) {
        this.current_question -= 1;
      }
    },
    saveResponse(question) {
      var submission = this.selected_model(submissionModel);
      this.responses[this.questions[question].id].submission_id = submission.id;
      if (this.responses[this.questions[question].id].id) {
        return this.save_model(responseModel, this.responses[this.questions[question].id]).then(
          (obj) => {
            this.responses[this.questions[question].id] = obj;
          }
        ).catch( () => {})
      } else {
        return this.new_model(responseModel, this.responses[this.questions[question].id]).then(
          (obj) => {
            this.responses[this.questions[question].id] = obj;
          }
        ).catch(() => { })
      }
    },
    // Create a submisison and make it the selected one
    createSubmission() {
      var org_survey = this.selected_model(organizationSurveyModel);
      return this.newSubmission(
        { 
          surveyId: org_survey.survey.id, 
          organizationSurveyId: org_survey.id,
          questions: this.questions.map(o => o.id)
        }
      );
    },
    /*
    1. On first next page create a submission (make it selected) and add a response
    2. Every subsequent step save the response
    3. If we go back then it is an update to the response on a next
    4. At end the submission is saved and is no longer draft
    */
    submitResponses() {
      let current = this.current_question;
      // var submission = this.selected_model(submissionModel);
      this.saveResponse(current).finally(
        () => {
          this.submitSelectedSubmission().then(
            () => { 
              this.$router.push(`/${Tr.getPersistedLocale()}/thankyou/${this.access_code}`);
            }
          )
        }
      )
    }
  },
  mounted() {
    // Check from ...
    this.$nextTick(() => {
      if (this.access_code) {
        // fetch the survey based in access code
        this.fetch_models(organizationSurveyModel, {
          filter: `{"op":"all","queries":[["access_code", "=", "${this.access_code}"]]}`
        }).then(
          (data) => {
            this.unselect_model(submissionModel);
            // Make the survey the selected one
            this.select_model(organizationSurveyModel, Object.values(data)[0].id)
            // Get the set of questions for the submission
            this.startSubmission({ access_code: this.access_code }).then(
              (questions) => {
                this.questions = Object.values(questions).filter(obj => (typeof obj.json === 'undefined'));
                this.number_questions = this.questions.length;
                // Place holder(s) for responses
                this.questions.forEach((q) => { 
                  this.responses[q.id] = {
                    question_id: q.id,
                    response: {
                      value: null
                    }
                  }
                })
              }
            )
          }
        );
      }
    })
  }
};
</script>

<style lang="scss" scoped>
</style>
