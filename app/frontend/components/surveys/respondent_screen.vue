<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
<div v-if="respondent != null">
  <b-row>
    <b-col>
      <p>
        Here's your respondent identifier:
        <span class="respondent-id mr-2 ml-2">{{ respondent.respondent_id }}</span>
        <button @click="copy" class="btn btn-primary btn-sm">Copy to Clipboard</button>
        <span class="text-success ml-2" v-if="copySuccess">Copied!</span> 
      </p>
      <p>
        You have answered X questions ...
        <!-- It is only displayed once, and now. Write it down or copy it and paste it in a secure note. 
        It must remain confidential and not be shared with anyone else. 
        This identifier allows you to keep track of changes over time.
        The graph with your scores will show the history of the scores. -->
      </p>
    </b-col>
  </b-row>
  <b-row class="mt-4">
    <b-col>
      <b-button variant="success" @click="onNext">Results</b-button>
    </b-col>
  </b-row>
</div>
</template>

<script>
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
      copySuccess: false
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
      // TODO: we show the results screen
      // this.$router.push(`/${Tr.getPersistedLocale()}/survey/submit/${this.access_code}`);
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
      }
    )
  }
}
</script>

<style lang="scss" scoped>
.respondent-id {
  color: darkgreen;
}
</style>
