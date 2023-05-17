import { mapGetters, mapActions } from 'vuex';
import toastMixin from '@/mixins/toast.mixin';
import { SAVE, SELECT, SELECTED, FETCH_SELECTED, DELETE, UNSELECT, PATCH_FIELDS } from '@/store/model.store';
import { SURVEY_SAVE_ERROR, SURVEY_SAVE_ERROR_DELETE, SURVEY_SAVE_SUCCESS, SURVEY_SAVE_SUCCESS_DELETE } from '@/constants/strings'
import { surveyModel as model } from '@/store/survey';
import { GET_CACHED_INDEX, GET_CACHED_GROUPS, GET_CACHED_QUESTIONS, GET_CACHED_ANSWERS } from '@/store/survey/survey.store';

export const surveyMixin = {
  mixins: [toastMixin],
  computed: {
    ...mapGetters({
      selected: SELECTED
    }),
    survey() {
      return this.selected({ model });
    }
  },
  methods: {
    ...mapGetters({
      getCachedIndex: GET_CACHED_INDEX,
      getCachedPages: GET_CACHED_GROUPS,
      getCachedQuestions: GET_CACHED_QUESTIONS,
      getCachedAnswers: GET_CACHED_ANSWERS
    }),
    ...mapActions({
      patch: PATCH_FIELDS
    }),
    saveSurvey(newSurvey, success_text = SURVEY_SAVE_SUCCESS, error_text = SURVEY_SAVE_ERROR) {
      if (!newSurvey) {
        newSurvey = this.survey;
      }
      return this.toastPromise(this.$store.dispatch(SAVE, { model, selected: true, item: newSurvey }), success_text, error_text)
    },
    selectSurvey(itemOrId) {
      this.$store.commit(SELECT, { model, itemOrId });
    },
    unselectSurvey() {
      this.$store.commit(UNSELECT, { model })
    },
    fetchSelectedSurvey() {
      console.debug("FETCHING SELCTED SURVEY")
      return this.$store.dispatch(FETCH_SELECTED, { model });
    },
    deleteSurvey(itemOrId, success_text = SURVEY_SAVE_SUCCESS_DELETE, error_text = SURVEY_SAVE_ERROR_DELETE) {
      if (!itemOrId) {
        itemOrId = this.survey;
      }
      return this.toastPromise(this.$store.dispatch(DELETE, { model, itemOrId }), success_text, error_text);
    },
    getNbrSurveyGroups(survey) {
      if (survey.groups) {
        return Object.values(survey.groups).length
      } else {
        return 0
      }
    },
    getSurveyGroups(survey) {
      if (survey.groups) {
        let groups = this.getCachedGroups()
        if (groups && (groups.length > 0)) {
          return groups
        } else {
          return Object.values(survey.groups) //.sort((a, b) => a.sort_order - b.sort_order)
        }
      } else {
        return []
      }
    },
    patchSurveyField(survey, field, success_text = SURVEY_SAVE_SUCCESS, error_text = SURVEY_SAVE_ERROR) {
      // console.debug("attempting to patch survey field", field, "with value", survey[field])
      this.toastPromise(this.patch({ model, item: survey, fields: [field] }), success_text, error_text)
    },
    fetchSurveyToastPromise(promise, success_text, error_text) {
      return this.toastPromise(new Promise((res, rej) => {
        promise.then((data) => {
          this.fetchSelectedSurvey().then(() => res(data)).catch(rej)
        }).catch(rej)
      }), success_text, error_text);
    }
  }
}

export default surveyMixin;
