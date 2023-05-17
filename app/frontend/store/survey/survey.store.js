import { NEW, FETCH_BY_ID, FETCH_SELECTED, PATCH_RELATED, SELECT, UNSELECT } from '../model.store';
// import { getOrderedRelationships } from '@/utils/jsonapi_utils';
import {
  NEW_SURVEY,
  NEW_GROUP,
  NEW_QUESTION,
  NEW_SUBMISSION,
  CLEAR_SURVEY_SUBMISSIONS,
  DUPLICATE_SURVEY,
  DUPLICATE_QUESTION,
  NEW_RESPONSE,
  START_SUBMISSION
} from './survey.actions';
import {
  surveyModel,
  groupModel,
  questionModel,
  answerModel,
  submissionModel,
  responseModel,
} from './survey.model';

import { v4 as uuidv4 } from 'uuid';

import { utils } from 'jsonapi-vuex';
import { getId } from '@/utils/utils';

import { organizationSurveyModel } from '../organization_survey.store';
// import { personModel } from '../person.store';

export const GET_CACHED_INDEX = 'GET CACHED INDEX';
export const GET_CACHED_GROUPS = 'GET CACHED GROUP';
export const GET_CACHED_QUESTIONS = 'GET CACHED QUESTIONS';
export const GET_CACHED_ANSWERS = 'GET CACHED ANSWERS';

export const surveyEndpoints = {
  [surveyModel]: '/survey',
  [groupModel]: '/group',
  [questionModel]: '/question',
  [answerModel]: '/answer',
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
    redirMessage: false,
    // A cache for the survey sorting
    indexCache: {
      groups: [], // ordered Groups
      questions: {}, // ordered questions per Group
      answers: {} // ordered answers per question
    }
  },
  getters: {
    [GET_CACHED_INDEX](state, getters) {
      return state.indexCache
    },
    // Groups
    [GET_CACHED_GROUPS](state, getters) {
      return state.indexCache.groups
    },
    // Questions for a Group
    [GET_CACHED_QUESTIONS]: (state) => (group_id) => {
      return state.indexCache.questions[group_id]
    },
    // Answers for a Question
    [GET_CACHED_ANSWERS]: (state) => (question_id) => {
      return state.indexCache.answers[question_id]
    },
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
  plugins: [
    (store) => {
      store.subscribe((mutation, state) => {
        // Build a ordered cache of Survey elements upon select
        if ((mutation.type === SELECT) && (mutation.payload.model === 'survey')) {
          let instance = mutation.payload.itemOrId;
          if (typeof instance == 'string' || !instance) {
            return
          }

          state.indexCache.groups = Object.values(instance.groups).sort((a, b) => a.sort_order - b.sort_order)
          state.indexCache.questions = {}
          state.indexCache.answers = {}
          state.indexCache.groups.forEach(
            (group) => {
              state.indexCache.questions[group.id] = Object.values(group.questions).sort((a, b) => a.sort_order - b.sort_order)
              state.indexCache.questions[group.id].forEach(
                (question) => {
                  state.indexCache.answers[question.id] = Object.values(question.answers).sort((a, b) => a.sort_order - b.sort_order)
                }
              )
            }
          )
        }
        if ((mutation.type === SELECT) && (mutation.payload.model === 'question')) {
          // ensure that the Group is also selected when a question is selected
          store.commit(SELECT, { model: groupModel, itemOrId: mutation.payload.itemOrId.group_id });
        }
        if (mutation.type === UNSELECT) {
          // clear the cache if we unselect the survey
          state.indexCache = {
            groups: [],
            questions: {},
            answers: {}
          }
        }
      })
    }
  ],
  actions: {
    [NEW_SURVEY]({ dispatch }) {
      let newSurvey = {
        name: 'New Survey',
        groups_attributes: [{
          title: 'New Survey',
          questions_attributes: [{
            question: 'New Question',
            question_type: "textfield",
            answers_attributes: [{
              answer: 'Option'
            }]
          }]
        }]
      }
      return dispatch(NEW, { model: surveyModel, selected: true, ...newSurvey })
    },
    [NEW_GROUP]({ dispatch }, { surveyId, questionIds = [], insertAt }) {
      let newGroup = {
        title: 'New Group',
        sort_order_position: insertAt,
        relationships: {
          survey: {
            data: {
              type: surveyModel,
              id: surveyId
            }
          },
        }
      }
      return new Promise((res, rej) => {
        dispatch(NEW, { model: groupModel, selected: true, ...newGroup }).then((savedNewGroup) => {
          savedNewGroup._jv.relationships.questions.data = questionIds.map(id => ({ type: questionModel, id }))
          dispatch(PATCH_RELATED, { item: savedNewGroup, parentRelName: 'questions', childIdName: 'group_id' }).then((data) => {
            res(data)
          }).catch(rej)
        }).catch(rej)
      })
    },
    [NEW_QUESTION]({ dispatch }, { groupId, questionType = "textfield", insertAt }) {
      let newQuestion = {
        question: 'New Question',
        question_type: questionType,
        answers_attributes: [{
          answer: 'Option 1'
        }],
        sort_order_position: insertAt,
        relationships: {
          group: {
            data: {
              type: groupModel,
              id: groupId
            }
          }
        }
      };
      return dispatch(NEW, { model: questionModel, selected: true, ...newQuestion });
    },
    [START_SUBMISSION]({ dispatch }, { model, access_code }) {
      return dispatch('jv/get', `${surveyEndpoints[surveyModel]}/start/${access_code}`)
    },
    [NEW_SUBMISSION]({ dispatch, state }, { surveyId, organizationSurveyId }) {
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
      return dispatch(NEW, { model: submissionModel, relationships, selected: true })
    },
    [CLEAR_SURVEY_SUBMISSIONS]({ dispatch }, { itemOrId }) {
      let id = getId(itemOrId)
      return new Promise((res, rej) => {
        dispatch('jv/delete', `${surveyModel}/{${id}}/${submissionModel}`).then((maybeData) => {
          res(maybeData);
        }).catch(rej)
      });
    },
    [DUPLICATE_SURVEY]({ dispatch }, { item }) {
      let newSurvey = {
        name: `Copy of ${item.name}`,
        description: item.description,
        welcome: item.welcome,
        thank_you: item.thank_you,
        submit_string: item.submit_string,
        use_captcha: item.use_captcha,
        public: false,
        mandatory_star: item.mandatory_star,
        numbered_questions: item.numbered_questions,
        branded: item.branded,
        allow_submission_edits: true,
        unassigned: item.unassigned,
        // FIX - why do we want to do any sorting in the duplicates since the render also does a sort?
        // Groups_attributes: getOrderedRelationships('Groups', item).map(p => ({
        groups_attributes: Object.values(item.groups).sort((a, b) => a.sort_order - b.sort_order).map(p => ({
          title: p.title,
          // questions_attributes: getOrderedRelationships('questions', p).map(q => ({
          questions_attributes: Object.values(p.questions).sort((a, b) => a.sort_order - b.sort_order).map(q => ({
            question: q.question,
            question_type: q.question_type,
            mandatory: q.mandatory,
            // answers_attributes: getOrderedRelationships('answers', q).map(a => ({
            answers_attributes: Object.values(q.answers).sort((a, b) => a.sort_order - b.sort_order).map(a => ({
              other: a.other,
              answer: a.answer,
            })),
          })),
        })),
      }
      return dispatch(NEW, { model: surveyModel, selected: true, ...newSurvey })
    },
    [DUPLICATE_QUESTION]({ dispatch }, { item, insertAt }) {
      let newQuestion = {
        group_id: item.group_id,
        question: item.question,
        question_type: item.question_type,
        mandatory: item.mandatory,
        text_size: item.text_size,
        horizontal: item.horizontal,
        private: item.private,
        regex: item.regex,
        // answers_attributes: getOrderedRelationships('answers', item).map(a => ({
        answers_attributes: Object.values(item.answers).sort((a, b) => a.sort_order - b.sort_order).map(a => ({
          answer: a.answer,
          default: a.default,
          other: a.other,
        }))
      }
      if (insertAt) {
        newQuestion.sort_order_position = insertAt
      }
      let relationships = {
        group: {
          data: {
            id: item.group_id,
            type: groupModel
          }
        }
      }
      return new Promise((res, rej) => {
        // TODO maybe someday instead of re-fetching the survey, we should cache the loaded questions with a local mirror instead?
        dispatch(NEW, { model: questionModel, selected: true, relationships, ...newQuestion }).then((data) => {
          dispatch(FETCH_SELECTED, { model: surveyModel }).then(res).catch(rej)
        }).catch(rej)
      })
    },
  }
}
