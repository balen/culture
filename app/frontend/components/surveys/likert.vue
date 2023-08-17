<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <div>
    <ul class="likert">
      <li  v-for="(likert_category) in settings.likert_categories" :key="likert_category.id" :id="likert_category.id" >
        <input type="radio" name="likert" :value="likert_category.value" v-model="selectedValue">
        <label v-if="likert_category.value == 1">{{ settings.left_label }}</label>
        <label v-else-if="likert_category.value == 7">{{ settings.right_label }}</label>
        <label v-else>{{ likert_category.label }}</label>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Likert',
  props: {
    value: null,
    settings: {
      type: Object,
      default: null
    }
  },
  data: () => ({
    selectedValue: null
  }),
  watch: {
    selectedValue(n,o) {
      this.$emit('input', n);
    },
    value(n,o) {
      this.selectedValue = n
    }
  }
}
</script>

<style lang="scss" scoped>
/* TODO - make the radio buttons larger for tablet use
 input[type='radio'] { 
  transform: scale(4); 
 }
 */
.likert {
  list-style:none;
  width:100%;
  margin:0;
  padding:0 0 35px;
  display:block;
  border-bottom:2px solid #efefef;
}
.likert:last-of-type {border-bottom:0;}
.likert:before {
  content: '';
  position:relative;
  top:11px;
  left:7%;
  display:block;
  background-color:#efefef;
  height:4px;
  width:84%;
}
.likert li {
  display:inline-block;
  width:14%;
  text-align:center;
  vertical-align: top;
}
.likert li input[type=radio] {
  display:block;
  position:relative;
  top:0;
  left:50%;
  margin-left:-6px;  
}
.likert li label {width:100%;}
</style>
