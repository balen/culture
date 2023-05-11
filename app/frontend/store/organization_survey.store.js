/*
 */
import { NEW } from './model.store';

export const NEW_ORGANIZATION_SURVEY = 'NEW ORGANIZATION SURVEY';

export const organizationSurveyModel = 'organization_survey';

export const organizationSurveyEndpoints = {
  [organizationSurveyModel]: '/organization_survey'
}

export const organizationSurveyStore = {
  actions: {
    [NEW_ORGANIZATION_SURVEY]({ dispatch }, attributes) {
      return dispatch(NEW, { model: organizationSurveyModel, selected: false, ...attributes })
    }
  },
  selected: {
    [organizationSurveyModel]: undefined
  },
  getters: {
  }
}
