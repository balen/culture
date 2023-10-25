<template>
  <div class="mb-3" v-if="results">
    <!-- RESULTS HERE {{ id }} -->
    <div class="d-flex justify-content-center mt-1 ">
      <div class="mr-2">
        <b-card
          bg-variant="primary" text-variant="white"
          :title="results.title"
          class="text-center score-card"
          data-cy="ps-results-card"
        >
          <b-card-text>
            {{ results.range.min }} to
            {{ results.range.max }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels()"
            :score_data="scoresFor()"
            :score_min="min"
          ></score-chart>
        </div>
      </div>
    </div>
    <div class="d-flex justify-content-center mt-1 ">
      <div class="mr-2">
        <survey-start-button
          :access_code="id"
        >{{ $t('survey.answer_more') }}</survey-start-button>
      </div>
    </div>
    </div>
</template>

<script>
import { http } from "@/utils/http";
import ScoreChart from './score_chart.vue';
import SurveyStartButton from "@/components/surveys/survey_start_button.vue"

export default {
  name: "MyResultsScreen",
  props: ['id', 'access_code'],
  data: () => ({
    results: null
  }),
  components: {
    ScoreChart,
    SurveyStartButton
  },
  computed: {
    min() {
      if (this.results.short_code == 'TM') {
        return -100
      } else {
        return 0
      }
    }
  },
  methods: {
    labels() {
      return this.results.questions
    },
    dataFor(group) {
      let dataset = []
      this.results[group].questions.forEach(
        (idx) => {
          if (this.results[group].summary[idx]) {
            dataset = dataset.concat(this.results.summary[idx])
          } else {
            dataset = dataset.concat(0)
          }
        }
      )
      return dataset;
    },
    scoresFor(group) {
      let dataset = []
      this.results.questions.forEach(
        (idx) => {
          dataset = dataset.concat(this.results.scores[idx])
        }
      )
      return dataset;
    }
  },
  mounted() {
    this.$nextTick(
      () => {
        if (this.id) {
          http.get(`/organization_survey/${this.id}/my_results`
          ).then(
            (response) => {
              this.results = response.data
            }
          )
        }
      }
    )
  }
}
</script>

<style scoped>
.score-card div.card-body p.card-text {
  font-size: 45pt;
}
</style>
