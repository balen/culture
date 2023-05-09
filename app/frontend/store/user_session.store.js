export const SET_SESSION_USER = "SET SESSION USER";
export const GET_SESSION_USER = "GET SESSION USER";

export const userSessionStore = {
  state: {
    user: {}
  },
  mutations: {
    [SET_SESSION_USER](state, user) {
      state.user = user
    }
  },
  getters: {
    // Get the current session from the store
    currentUserSession(state, getters) {
      return state.user;
    }
  },
  actions: {
    [GET_SESSION_USER]({ commit, dispatch, state }, attrs = null) {
      let force = false
      if (attrs && attrs.force) {
        force = attrs.force
      }
      // only fetch session if we don't have one
      // return a promise with the session user either way
      return new Promise((res, rej) => {
        if (!state.user.id || force) {
          dispatch('jv/get', '/user/session/me').then((user) => {
            commit(SET_SESSION_USER, user)
            res(user);
          }).catch((error) => {
            // If we can not get the session then set no no user
            commit(SET_SESSION_USER, {})
            res({});
          })
        } else {
          res(state.user);
        }
      })
    }
  }
}
