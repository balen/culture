// import Vue from 'vue'
// import Vuex from 'vuex'
import { jsonapiModule, utils } from 'jsonapi-vuex'
import { http } from '@/utils/http';

import { getId } from '@/utils/utils';

import { userSessionStore } from './user_session.store';

// Store for global app states
import { appStore } from './app.store';

// import merge from 'lodash.merge'
import { createStore } from 'vuex'

export const SELECT = 'SELECT';
export const UNSELECT = 'UNSELECT';
export const SELECTED = 'SELECTED';
export const FETCH_SELECTED = 'FETCH SELECTED';
export const FETCH_BY_ID = 'FETCH BY ID'
export const FETCH = 'FETCH';
export const NEW = 'NEW';
export const SAVE = 'SAVE';
export const DELETE = 'DELETE';
export const SEARCH = 'SEARCH';
export const CLEAR = 'CLEAR';
export const PATCH_FIELDS = 'PATCH FIELDS';

const endpoints = {
}

// Vue.use(Vuex)
export const store = createStore({
  modules: {
    jv: jsonapiModule(
      http,
      {
        preserveJson: true,
        clearOnUpdate: false
      }
    )
  },
  state: {
    selected: {
      // ...meetingStore.selected,
    },
    ...userSessionStore.state,
    ...appStore.state
  },
  getters: {
    [SELECTED](state, getters) {
      return ({ model }) => {
        if (!state.selected[model]) return undefined;
        let res = getters['jv/get']({ _jv: { id: state.selected[model], type: model } })
        return utils.deepCopy(res)
      }
    },
    ...userSessionStore.getters
  },
  mutations: {
    [SELECT](state, { model, itemOrId }) {
      state.selected[model] = getId(itemOrId);
    },
    [UNSELECT](state, { model }) {
      state.selected[model] = undefined;
    },
    [CLEAR](state, { model }) {
      this.commit('jv/clearRecords', { _jv: { type: model } })
    },
    ...userSessionStore.mutations,
    ...appStore.mutations
  },
  actions: {
    [NEW]({ commit, dispatch }, { model, selected = false, relationships = {}, ...attrs }) {
      let newModel = {
        ...attrs,
        _jv: {
          type: model,
          relationships
        }
      }

      return new Promise((res, rej) => {
        dispatch('jv/post', newModel).then((savedModel) => {
          if (selected) {
            commit(SELECT, { model, itemOrId: savedModel });
          }
          res(savedModel);
        }).catch(rej);
      });
    },
    [SAVE]({ commit, dispatch }, { model, selected = true, item, params }) {
      if (item._jv) {
        if (!item._jv.type) {
          _jv.type = model
        }
      }
      else {
        item._jv = { type: model }
      }

      return new Promise((res, rej) => {
        dispatch('jv/patch', [item, { params }]).then((savedModel) => {
          // to get around the fact that the getter returns a copy,
          // re-select the saved model so that the getter updates.
          if (selected) {
            commit(SELECT, { model, itemOrId: savedModel });
          }
          res(savedModel);
        }).catch(rej)
      });
    },
    [DELETE]({ dispatch, commit, state }, { model, itemOrId, unselect = true }) {
      return new Promise((res, rej) => {
        dispatch('jv/delete', `${endpoints[model]}/${getId(itemOrId)}`).then((data) => {
          if (unselect && state.selected[model]) {
            commit(UNSELECT, { model })
          }
          res(data)
        }).catch(rej)
      })
    },
    [SEARCH]({ dispatch }, { model, params }) {
      return dispatch('jv/search', [endpoints[model], { params }])
    },
    // need a way to override the default URL
    [FETCH]({ dispatch }, { model, url = null, params }) {
      if (url) {
        return dispatch('jv/get', [url, { params }])
      } else {
        return dispatch('jv/get', [endpoints[model], { params }])
      }
    },
    [FETCH_SELECTED]({ state, dispatch }, { model }) {
      if (!state.selected[model]) {
        return Promise.reject(`No ${model} selected`)
      }
      return dispatch(FETCH_BY_ID, { model, id: state.selected[model] })
    },
    [FETCH_BY_ID]({ dispatch }, { model, id }) {
      // We do need this - not all fetch by id will be selected models
      return dispatch('jv/get', `${endpoints[model]}/${id}`)
    },
    [PATCH_FIELDS]({ dispatch, commit }, { model, item, fields = [], selected = true }) {
      // limited field selection
      let smallItem = {
        // always include lock version so that we have optimistic locking
        lock_version: item.lock_version || 0,
        ...fields.map(field => ({ [field]: item[field] })).reduce((p, c) => ({ ...p, ...c }), {}),
        id: item.id,
        _jv: {
          type: model,
          id: item.id
        }
      }
      return new Promise((res, rej) => {
        dispatch('jv/patch', smallItem).then((savedModel) => {
          if (selected) {
            commit(SELECT, { model, itemOrId: savedModel });
          }
          res(savedModel);
        }).catch(rej);
      });
    },
    ...userSessionStore.actions,
  }
});
