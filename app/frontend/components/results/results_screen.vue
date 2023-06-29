<template>
  <div class="mb-3">
    <!-- RESULTS HERE {{ id }} -->
    <div class="d-flex justify-content-center mt-1 " v-if="results">
      <div class="mr-2">
        <b-card
          bg-variant="primary" text-variant="white"
          title="Psychological Safety"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.ps.total }}
          </b-card-text>
        </b-card>
        <div>
          <Bar :data="psData" :options="options" :style="barStyle"/>
        </div>
      </div>
      <div class="mr-2">
        <b-card
          bg-variant="primary" text-variant="white"
          title="Total Motivation"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.tm.total }}
          </b-card-text>
        </b-card>
        <div>
          <Bar :data="tmData" :options="options" :style="barStyle"/>
        </div>
      </div>
      <div class="mr-2">
        <b-card
          bg-variant="primary" text-variant="white"
          title="Growth Mindset"
          class="text-center score-card"
        >
          <b-card-text>
            {{ results.gm.total }}
          </b-card-text>
        </b-card>
        <div>
          <Bar :data="gmData" :options="options" :style="barStyle"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {
  Chart as ChartJS,
  Colors,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
  PointElement,
  ScatterController
} from 'chart.js';
import { http } from "@/utils/http";
import { Bar } from 'vue-chartjs'

ChartJS.register(CategoryScale, LinearScale, BarElement, PointElement, ScatterController,
                 Title, Tooltip, Legend, Colors)

export default {
  name: "ResultsScreen",
  props: ['id'],
  data: () => ({
    results: null,
    options: {
      responsive: false,
      scales: {
        x: {
          border: {
            display: true
          },
          grid: {
            drawOnChartArea: false,
            drawTicks: true,
          }
        },
        countScale: {
          position: 'left',
          suggestedMin: 0,
          suggestedMax: 15,
          grid: {
            drawTicks: true,
            drawOnChartArea: false,
          }
        },
        scoreScale: {
          position: 'right',
          suggestedMin: 0,
          suggestedMax: 100,
          grid: {
            drawTicks: true,
            drawOnChartArea: false,
          }
        }
      }
    }
  }),
  components: {
    Bar
  },
  mixins: [
  ],
  computed: {
    barStyle() {
      return {
        height: "200px"
      }
    },
    psData() {
      return {
        labels: this.labels('ps'),
        datasets: [
          {
            yAxisID: 'countScale',
            label: 'Number of Responses',
            data: this.dataFor('ps')
          },
          {
            yAxisID: 'scoreScale',
            type: 'scatter',
            label: 'Score',
            data: this.scoresFor('ps'),
            order: 2
          }
        ]
      }      
    },
    tmData() {
      return {
        labels: this.labels('tm'),
        datasets: [
          {
            yAxisID: 'countScale',
            type: 'bar',
            label: 'Number of Responses',
            data: this.dataFor('tm'),
            order: 1
          },
          {
            yAxisID: 'scoreScale',
            type: 'scatter',
            label: 'Score',
            data: this.scoresFor('tm'),
            order: 2
          }
        ]
      }
    },
    gmData() {
      return {
        labels: this.labels('gm'),
        datasets: [
          {
            yAxisID: 'countScale',
            label: 'Number of Responses',
            data: this.dataFor('gm')
          },
          {
            yAxisID: 'scoreScale',
            type: 'scatter',
            label: 'Score',
            data: this.scoresFor('gm'),
            order: 2
          }
        ]
      }
    }
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
}
</style>
