<template>
  <div class="detail">
    <sidebar-vue v-if="selected" model="organization">
      <template #header>
        <h3>{{ selected.name }}</h3>
        <div class="d-flex justify-content-end">
          <div class="d-inline mx-1" title="newval">
            <b-button @click="openNewModal" variant="primary" title="New">
              <b-icon-plus></b-icon-plus>
            </b-button>
          </div>
        </div>
      </template>
      <template #content v-if="selected">
        <div class="row mb-5">
          <div class="col-6"><b>Survey</b></div>
          <div class="col-3"><b>Code</b></div>
          <div class="col-3"><b># Submissions</b></div>
        </div>
        <div class="row mb-5" v-for="(survey_info) in this.selected.organization_surveys" :key="survey_info.id" :id="survey_info.id">
          <div class="col-6"><b>{{ survey_info.survey.name }}</b></div>
          <div class="col-3">{{ survey_info.access_code }}</div>
          <div class="col-3">{{ survey_info.number_submissions }}</div>
        </div>
      </template>
    </sidebar-vue>
    <modal id="add-access-code" title="Add Survey" @ok="onNew">
      <b-form-group label="Access Code">
        <b-form-input id="survey-access-code" type="text" v-model="newAccessCode"></b-form-input>
      </b-form-group>
    </modal>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import SidebarVue from '@/components/sidebar_vue.vue';
import modelMixin from '@/mixins/model.mixin';
import Modal from '@/components/modal.vue';
import { NEW_ORGANIZATION_SURVEY } from '@/store/organization_survey.store'

export default {
  name: 'OrganizationSidebar',
  components: {
    SidebarVue,
    Modal
  },
  mixins: [
    modelMixin,
  ],
  data: () => ({
    newAccessCode: null
  }),
  computed: {
    surveyInfos() {
      return Object.values(this.selected.organization_surveys);
    }
  },
  methods: {
    ...mapActions({
      newOrganizationSurvey: NEW_ORGANIZATION_SURVEY
    }),
    openNewModal() {
      this.newAccessCode = null;
      this.$bvModal.show('add-access-code');
    },
    onNew() {
      this.newOrganizationSurvey(
        { 
          access_code: this.newAccessCode,
          survey_id: 1, // TODO: we need the survey id
          organization_id: this.selected.id
        }
      ).then((data) => {
        console.debug("done");
        // TODO: we need to refresh the selected?
        // this.$refs['organizations-table'].fetchPaged()
      })
    }
  }
}

</script>