/*
 */
import { NEW } from './model.store';

export const NEW_RESPONDENT = 'NEW RESPONDENT';
export const CURRENT_RESPONDENT = 'CURRENT RESPONDENT';

export const respondentModel = 'respondent';

export const respondentEndpoints = {
  [respondentModel]: '/respondent'
}

export const respondentStore = {
  actions: {
    [NEW_RESPONDENT]({ dispatch }, attributes) {
      return dispatch(NEW, { model: respondentModel, selected: false, ...attributes })
    },
    [CURRENT_RESPONDENT]({ dispatch, state }, attributes) {
      return new Promise((res, rej) => {
        dispatch('jv/get', '/respondent/current').then((respondent) => {
          state.selected[respondentModel] = respondent;
          res(respondent);
        }).catch((error) => {
          state.selected[respondentModel] = undefined;
          res({});
        })
      })
    }
  },
  selected: {
    [respondentModel]: undefined
  },
  getters: {
  }
}
