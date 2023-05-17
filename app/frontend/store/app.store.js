export const SET_PER_PAGE = 'SET PER PAGE';

export const appStore = {
  state: {
    perPage: 20
  },
  mutations: {
    [SET_PER_PAGE](state, amt) {
      state.perPage = amt;
    }
  }
}
