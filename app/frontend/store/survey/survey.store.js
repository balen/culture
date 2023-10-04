import { NEW, FETCH_BY_ID, FETCH_SELECTED, PATCH_RELATED, SELECT, UNSELECT } from '../model.store';

import {
  NEW_SUBMISSION,
  NEW_RESPONSE,
  START_SUBMISSION,
  FIND_SURVEY
} from './survey.actions';
import {
  surveyModel,
  groupModel,
  questionModel,
  submissionModel,
  responseModel,
} from './survey.model';

import { v4 as uuidv4 } from 'uuid';

import { utils } from 'jsonapi-vuex';

import { organizationSurveyModel } from '../organization_survey.store';

export const surveyEndpoints = {
  [surveyModel]: '/survey',
  [groupModel]: '/group',
  [questionModel]: '/question',
  [submissionModel]: '/submission',
  [responseModel]: '/response'
}

export const surveyStore = {
  selected: {
    [surveyModel]: undefined,
    [groupModel]: undefined,
    [questionModel]: undefined,
    [submissionModel]: undefined,
  },
  state: {
    previewMode: false,
    redirMessage: false
  },
  mutations: {
    [NEW_RESPONSE](state, { relationships = {}, text = '', answers = [] }) {
      let id = uuidv4();
      let item = {
        id,
        response: { text, answers },
        _jv: {
          id,
          relationships,
          type: responseModel
        }
      };
      utils.updateRecords(state.jv, { [id]: item })
      return item;
    }
  },
  actions: {
    [START_SUBMISSION]({ dispatch }, { model, access_code }) {
      return dispatch('jv/get', `${surveyEndpoints[surveyModel]}/start/${access_code}`)
    },
    [FIND_SURVEY]({ dispatch }, { model, access_code }) {
      return dispatch('jv/get', `${surveyEndpoints[surveyModel]}/find/${access_code}`)
    },
    [NEW_SUBMISSION]({ dispatch, state }, { surveyId, organizationSurveyId, questions }) {
      let relationships = {
        survey: {
          data: {
            type: surveyModel,
            id: surveyId
          }
        },
        organization_survey: {
          data: {
            type: organizationSurveyModel,
            id: organizationSurveyId
          }
        }
      };
      return dispatch(NEW, { model: submissionModel, relationships, selected: true, questions })
    }
  }
}
