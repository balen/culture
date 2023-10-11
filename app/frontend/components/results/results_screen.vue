<template>
  <div class="mb-3">
    <div v-if="results">
    </div>
    <div class="d-flex justify-content-center mt-1 " v-if="results">
      <div class="mr-2 col-4">
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
          <v-chart class="chart" :option="psOptions" :style="barStyle" autoresize width="auto" />
        </div>
      </div>
      <div class="mr-2 col-4">
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
          <v-chart class="chart" :option="tmOptions" :style="barStyle" autoresize width="auto" />
        </div>
      </div>
      <div class="mr-2 col-4">
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
          <v-chart class="chart" :option="gmOptions" :style="barStyle" autoresize width="auto" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { http } from "@/utils/http";

import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart } from 'echarts/charts';
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
} from 'echarts/components';
import VChart, { THEME_KEY } from 'vue-echarts';
use([
  CanvasRenderer,
  BarChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent
]);

import * as echarts from 'echarts';

export default {
  name: "ResultsScreen",
  props: ['id'],
  data: () => ({
    results: null
  }),
  components: {
    VChart
  },
  provide: {
    [THEME_KEY]: "light"
  },
  mixins: [
  ],
  computed: {
    barStyle() {
      return {
        height: "300px"
      }
    },
    psOptions() {
      return {
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'cross' }
        },
        xAxis: {
          axisTick: {
            alignWithLabel: true
          },
          axisLabel: {
            rotate: 45
          },
          type: 'category',
          data: this.labels('ps')
        },
        yAxis: [
          {
            type: 'value',
            name: 'count',
            position: 'right'
          },
          {
            max: 100,
            type: 'value',
            name: 'score',
            position: 'left'
          }
        ],
        series: [
          {
            data: this.dataFor('ps'),
            type: 'bar',
            yAxisIndex: 0
          },
          {
            symbolSize: 10,
            data: this.scoresFor('ps'),
            type: 'scatter',
            yAxisIndex: 1
          },
        ]
      }
    },
    tmOptions() {
      return {
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'cross' }
        },
        xAxis: {
          axisTick: {
            alignWithLabel: true
          },
          axisLabel: {
            rotate: 45
            // align: 'center'
          },
          type: 'category',
          data: this.labels('tm')
        },
        yAxis: [
          {
            type: 'value',
            name: 'count',
            position: 'right'
          },
          {
            max: 100,
            min: -100,
            type: 'value',
            name: 'score',
            position: 'left'
          }
        ],
        series: [
          {
            data: this.dataFor('tm'),
            type: 'bar',
            yAxisIndex: 0
          },
          {
            symbolSize: 10,
            data: this.scoresFor('tm'),
            type: 'scatter',
            yAxisIndex: 1
          },
        ]
      }
    },
    gmOptions() {
      return {
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'cross' }
        },
        xAxis: {
          axisTick: {
            alignWithLabel: true
          },
          axisLabel: {
            rotate: 45
            // align: 'center'
          },
          type: 'category',
          data: this.labels('gm')
        },
        yAxis: [
          {
            type: 'value',
            name: 'count',
            position: 'right'
          },
          {
            max: 100,
            type: 'value',
            name: 'score',
            position: 'left'
          }
        ],
        series: [
          {
            data: this.dataFor('gm'),
            type: 'bar',
            yAxisIndex: 0
          },
          {
            symbolSize: 10,
            data: this.scoresFor('gm'),
            type: 'scatter',
            yAxisIndex: 1
          }
        ]
      }
    },
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
            dataset = dataset.concat([[idx, this.results[group].scores[idx]]])
          } else {
            dataset = dataset.concat([[idx, null]])
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
