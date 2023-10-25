<template>
  <div>
    <b-button variant="success" 
      :state="state"
      @click="onNext"
      data-cy="start-survey-button"
      :disabled="disabled"
    >
      <slot>{{ $t('survey.start') }}</slot>
    </b-button>
  </div>
</template>

<script>
import modelMixin from '@/mixins/model.mixin';
import modelUtilsMixin from '@/mixins/model_utils.mixin'
import Tr from "@/i18n/translation"

export default {
  name: "SurveyStartButton",
  props: {
    access_code: null,
    respondent_id: null,
    state: null,
    disabled: false
  },
  mixins: [
    modelMixin,
    modelUtilsMixin
  ],
  methods: {
    onNext: function () {
      console.debug("*** GO TO", `/${Tr.getPersistedLocale()}/survey/submit/${this.access_code}`)
      this.$router.push(`/${Tr.getPersistedLocale()}/survey/submit/${this.access_code}`);
    }
  }
}
</script>

<style>
</style>