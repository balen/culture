<template>
  <div class="mb-3">
    <!-- RESULTS HERE {{ id }} -->
    <div class="d-flex justify-content-center mt-1 " v-if="results">
      <div class="mr-2">
        <b-card
          bg-variant="primary" text-variant="white"
          title="Psychological Safety"
          class="text-center score-card"
          data-cy="ps-results-card"
        >
          <b-card-text>
            {{ results.ps.range.min }} to
            {{ results.ps.range.max }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels('ps')"
            :score_data="scoresFor('ps')"
          ></score-chart>
        </div>
      </div>
      <div class="mr-2">
        <b-card
          bg-variant="primary" text-variant="white"
          title="Total Motivation"
          class="text-center score-card"
          data-cy="tm-results-card"
        >
          <b-card-text>
            {{ results.tm.range.min }} to
            {{ results.tm.range.max }}
          </b-card-text>
      </b-card>
        <div>
          <score-chart
            :labels="labels('tm')"
            :score_data="scoresFor('tm')"
            :score_min="-100"
          ></score-chart>
        </div>
      </div>
      <div class="mr-2">
        <b-card
          bg-variant="primary" text-variant="white"
          title="Growth Mindset"
          class="text-center score-card"
          data-cy="gm-results-card"
        >
          <b-card-text>
            {{ results.gm.range.min }} to
            {{ results.gm.range.max }}
          </b-card-text>
      </b-card>
        <div>
          <score-chart
            :labels="labels('gm')"
            :score_data="scoresFor('gm')"
          ></score-chart>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { http } from "@/utils/http";
import ScoreChart from './score_chart.vue';

export default {
  name: "MyResultsScreen",
  props: ['id'],
  data: () => ({
    results: null
  }),
  components: {
    ScoreChart
  },
  methods: {
    labels(group) {
      return this.results[group].questions
    },
    dataFor(group) {
      let dataset = []
      this.results[group].questions.forEach(
        (idx) => {
          if (this.results[group].summary[idx]) {
            dataset = dataset.concat(this.results[group].summary[idx])
          } else {
            dataset = dataset.concat(0)
          }
        }
      )
      return dataset;
    },
    scoresFor(group) {
      let dataset = []
      this.results[group].questions.forEach(
        (idx) => {
          if (this.results[group].scores[idx]) {
            dataset = dataset.concat(this.results[group].scores[idx])
          } else {
            dataset = dataset.concat(null)
          }
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
