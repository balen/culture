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
  <div v-else class="mt-5">
    <b-row>
      <b-col>
        <p>
          {{ $t('survey.intro_canadian_postal_code') }}<br>
          {{ $t('survey.intro_canadian_postal_code_reason') }}
        </p>
      </b-col>
    </b-row>
    <div class="d-flex mt-4">
      <div class="mr-3">
        <b>{{ $t('survey.postal_canadian_identifier') }}</b>
      </div>
      <div>
        <b-form-input 
          v-model="postal_code" 
          type="text" 
          :placeholder="Pcode"
          :state="valid"
          debounce="500"
          data-cy="postal-code-id"
        ></b-form-input>
        <div class="invalid-feedback" data-cy="invalid-respondent-id">
          <!-- {{ error.text }} -->
        </div>
      </div>
    </div>
    <b-row class="mt-4">
      <b-col>
        <b-button variant="success" 
          :state="valid"
          @click="onContinue"
          data-cy="start-survey-button"
          :disabled="valid == false"
        >
          <slot>CONTINUE</slot>
        </b-button>
      </b-col>
    </b-row>
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
    responses: {},
    use_postal_code: 'none',
    postal_code: null,
    valid: null,
    error: {
      visible: false,
      text: "",
    }
  }),
  components: {
    Likert
  },
  mixins: [
    modelUtilsMixin,
    submissionMixin
  ],
  watch: {
    postal_code(n,o) {
      if (n != o) {
        this.error.visible = false
        this.valid = true

        if (n) {
          // disable and then enable button
          this.valid = false
          // For Canada validate the FSA (forward sortation area)
          var regex = /^[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTV-Z]/i;
          var match = regex.exec(n);
          if (match) {
            this.valid = true
          } else {
            this.error.text = "Not a valid postal code"
            this.error.visible = true
            this.valid = false
          }
        }
      }
    }
  },
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
          questions: this.questions.map(o => o.id),
          postal_code: this.postal_code
        }
      );
    },
    onContinue() {
      this.unselect_model(submissionModel);
      this.startSubmission({ access_code: this.access_code }).then(
        (questions) => {
          this.questions = Object.values(questions).filter(obj => (typeof obj.json === 'undefined'));
          // Place holder(s) for responses
          this.questions.forEach((q) => { 
            this.responses[q.id] = {
              question_id: q.id,
              response: {
                value: null
              }
            }
          })

          this.number_questions = this.questions.length;
        }
      )
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
            this.use_postal_code = Object.values(data)[0].use_postal_code
            // Get the set of questions for the submission
            if (this.use_postal_code == 'none') {
              this.startSubmission({ access_code: this.access_code }).then(
                (questions) => {
                  this.questions = Object.values(questions).filter(obj => (typeof obj.json === 'undefined'));
                  // Place holder(s) for responses
                  this.questions.forEach((q) => { 
                    this.responses[q.id] = {
                      question_id: q.id,
                      response: {
                        value: null
                      }
                    }
                  })

                  this.number_questions = this.questions.length;
                }
              )
            }
          }
        );
      }
    })
  }
};
</script>

<style lang="scss" scoped>
</style>
