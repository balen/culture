/*
 */
import { NEW } from './model.store';

export const NEW_ORGANIZATION = 'NEW ORGANIZATION';

export const organizationModel = 'organization';

export const organizationEndpoints = {
  [organizationModel]: '/organization'
}

export const organizationStore = {
  actions: {
    [NEW_ORGANIZATION]({ dispatch }, attributes) {
      return dispatch(NEW, { model: organizationModel, selected: false, ...attributes })
    }
  },
  selected: {
    [organizationModel]: undefined
  },
  getters: {
  }
}
