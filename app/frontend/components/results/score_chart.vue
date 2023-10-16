<template>
  <div>
    <v-chart 
      class="chart"
      :option="options"
      :style="barStyle"
      autoresize 
      width="auto"
    />
  </div>
</template>

<script>
import { use } from 'echarts/core';
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent
} from 'echarts/components';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart, ScatterChart } from 'echarts/charts';
import VChart, { THEME_KEY } from 'vue-echarts';
use([
  CanvasRenderer,
  BarChart,
  ScatterChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent
]);

export default {
  name: "ScoreChart",
  props: {
    labels: {
      type: Array
    },
    bar_data: null,
    score_data: null,
    score_max: {
      default: 100
    },
    score_min: {
      default: 0
    },
    height: {
      default: "300px"
    }
  },
  components: {
    VChart
  },
  provide: {
    [THEME_KEY]: "vintage"
  },
  computed: {
    barStyle() {
      return {
        height: this.height
      }
    },
    options() {
      let yAxis = [
        {
          max: this.score_max,
          min: this.score_min,
          type: 'value',
          name: 'score',
          position: 'left'
        }
      ];

      let series = [
        {
          symbolSize: 10,
          data: this.score_data,
          type: 'scatter',
          yAxisIndex: 0,
          itemStyle: { color: 'red' }
        }
      ];

      if (this.bar_data) {
        yAxis[1] = {
          type: 'value',
          name: 'count',
          position: 'right'
        }

        series[1] = {
          data: this.bar_data,
          type: 'bar',
          yAxisIndex: 1,
          itemStyle: { color: 'lightblue' },
        }
      }

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
          data: this.labels
        },
        yAxis: yAxis,
        series: series
      }
    }
  }
}
</script>

<style scoped>
</style>