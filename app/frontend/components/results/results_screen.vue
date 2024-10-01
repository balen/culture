<template>
  <div class="mb-3">
    <div v-if="results">
    </div>
    <div class="d-flex mt-1 justify-content-center flex-wrap" v-if="results">
      <div class="m-1" v-if="results.ps.questions.length > 0">
        <b-card
          bg-variant="primary" text-variant="white"
          :title="results.ps.title"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.ps.total }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels('ps')"
            :bar_data="dataFor('ps')"
            :score_data="scoresFor('ps')"
          ></score-chart>
        </div>
      </div>
      <div class="m-1" v-if="results.tm.questions.length > 0">
        <b-card
          bg-variant="primary" text-variant="white"
          :title="results.tm.title"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.tm.total }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels('tm')"
            :bar_data="dataFor('tm')"
            :score_data="scoresFor('tm')"
            :score_min="-100"
          ></score-chart>
        </div>
      </div>
      <div class="m-1" v-if="results.gm.questions.length > 0">
        <b-card
          bg-variant="primary" text-variant="white"
          :title="results.gm.title"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.gm.total }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels('gm')"
            :bar_data="dataFor('gm')"
            :score_data="scoresFor('gm')"
          ></score-chart>
        </div>
      </div>
      <div class="m-1" v-if="results.p2t.questions.length > 0">
        <b-card
          bg-variant="primary" text-variant="white"
          :title="results.p2t.title"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.p2t.total }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels('p2t')"
            :bar_data="dataFor('p2t')"
            :score_data="scoresFor('p2t')"
          ></score-chart>
        </div>
      </div>
      <div class="m-1" v-if="results.ptw.questions.length > 0">
        <b-card
          bg-variant="primary" text-variant="white"
          :title="results.ptw.title"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.ptw.total }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels('ptw')"
            :bar_data="dataFor('ptw')"
            :score_data="scoresFor('ptw')"
          ></score-chart>
        </div>
      </div>
      <div class="m-1" v-if="results.cb.questions.length > 0">
        <b-card
          bg-variant="primary" text-variant="white"
          :title="results.cb.title"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.cb.total }}
          </b-card-text>
        </b-card>
        <div>
          <score-chart
            :labels="labels('cb')"
            :bar_data="dataFor('cb')"
            :score_data="scoresFor('cb')"
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
  name: "ResultsScreen",
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
          dataset = dataset.concat([[idx, this.results[group].scores[idx]]])
        }
      )
      return dataset;
    }
  },
  mounted() {
    this.$nextTick(
      () => {
        if (this.id) {
          http.get(`/organization_survey/${this.id}/results`
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
  min-width: 5em;
}
</style>
