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
          <div class="col-3">
            <b-link :to="'/survey/submit/' + survey_info.access_code">{{ survey_info.access_code }}</b-link>
          </div>
          <!-- TODO: link to download the responses -->
          <div class="col-3">{{ survey_info.number_submissions }}</div>
        </div>
      </template>
    </sidebar-vue>
    <modal id="add-access-code" title="Add Survey" @ok="onNew">
      <b-form-group label="Access Code">
        <b-form-input id="survey-access-code" type="text" v-model="newAccessCode"></b-form-input>
      </b-form-group>
      <b-form-group label="Survey">
        <model-select
          v-model="survey_id"
          model="survey"
          field="name"
        ></model-select>
      </b-form-group>
    </modal>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import SidebarVue from '@/components/shared/sidebar_vue.vue';
import modelMixin from '@/mixins/model.mixin';
import modelUtilsMixin from '@/mixins/model_utils.mixin'
import Modal from '@/components/shared/modal.vue';
import ModelSelect from '@/components/shared/model_select.vue';

import { NEW_ORGANIZATION_SURVEY } from '@/store/organization_survey.store'

export default {
  name: 'OrganizationSidebar',
  components: {
    SidebarVue,
    Modal,
    ModelSelect
  },
  mixins: [
    modelMixin,
    modelUtilsMixin
  ],
  data: () => ({
    newAccessCode: null,
    survey_id: null
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
          survey_id: this.survey_id,
          organization_id: this.selected.id
        }
      ).then((data) => {
        console.debug("done");
        this.fetch_model_by_id('organization', this.selected.id);
      })
    }
  }
}

</script>