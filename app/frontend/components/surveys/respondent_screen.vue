<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
<div v-if="respondent != null" class="center-text container">
  <b-row>
    <b-col>
      <p>
        {{ $t('survey.respondent_here') }}<br>
        <b>{{ $t('survey.respondent_once') }}</b>
        <span class="respondent-id mr-2 ml-2" ref="copybox">{{ respondent.respondent_id }}</span>
        <button @click="copy" class="btn btn-primary btn-sm">{{ $t('survey.respondent_copy') }}</button>
        <span class="text-success ml-2" v-if="copySuccess">{{ $t('survey.respondent_copied') }}</span> 
      </p>
      <p v-if="count">
        {{ $t('survey.respondent_answered', count) }}
      </p>
    </b-col>
  </b-row>
  <b-row class="mt-4">
    <b-col>
      <b-button variant="success" id="see-results" data-cy="button-see-results" @click="onNext">{{ $t('results') }}</b-button>
    </b-col>
  </b-row>
</div>
</template>

<script>
import { http } from "@/utils/http";

import modelMixin from '@/mixins/model.mixin';
import { mapActions } from 'vuex';
import { CURRENT_RESPONDENT } from "@/store/respondent.store";
import Tr from "@/i18n/translation"

export default {
  name: "RespondentScreen",
  props: {
    access_code: null,
  },
  data() {
    return {
      respondent: null,
      copySuccess: false,
      count: null
    }
  },
  mixins: [
    modelMixin
  ],
  methods: {
    ...mapActions({
      currentRespondent: CURRENT_RESPONDENT,
    }),
    onNext: function () {
      // We show the results screen
      this.$router.push(`/${Tr.getPersistedLocale()}/myresults/${this.access_code}`);
    },
    copy() {
      const blobInput = new Blob([this.$refs.copybox.innerHTML], { type: 'text/html' })
      navigator.clipboard.writeText(this.respondent.respondent_id).then(() => {
        this.copySuccess = true;
      });
    }
  },
  mounted() {
    // Ask the server for a new respondent
    this.currentRespondent().then(
      (respondent) => {
        this.respondent = respondent

        http.get(`/organization_survey/${this.access_code}/my_count`
        ).then(
          (response) => {
            this.count = response.data.count
          }
        )
      }
    )
  }
}
</script>

<style lang="scss" scoped>
.respondent-id {
  color: darkgreen;
}

.center-text {
  width: 75%;
  margin-top: 50px;
  margin-right: auto;
  margin-left: auto;
  margin-bottom: 0px;
}

</style>
