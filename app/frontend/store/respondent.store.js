/*
 */
import { NEW } from './model.store';

export const NEW_RESPONDENT = 'NEW RESPONDENT';

export const respondentModel = 'respondent';

export const respondentEndpoints = {
  [respondentModel]: '/respondent'
}

export const respondentStore = {
  actions: {
    [NEW_RESPONDENT]({ dispatch }, attributes) {
      return dispatch(NEW, { model: respondentModel, selected: false, ...attributes })
    }
  },
  selected: {
    [respondentModel]: undefined
  },
  getters: {
  }
}
