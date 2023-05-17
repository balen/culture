<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <b-row>
    <b-col>
      <!-- TODO -->
      <h2>Survey submitted</h2>
      <p>{{ thankYou }}</p>
    </b-col>
  </b-row>
</template>

<script>
import { SURVEY_DEFAULT_THANK_YOU } from '@/constants/strings';
export default {
  name: "SurveyThankYou",
  computed: {
    thankYou() {
      return SURVEY_DEFAULT_THANK_YOU;
    }
  }
}
</script>

<style></style>
