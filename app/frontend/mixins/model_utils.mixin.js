/*
**/
// import { toastMixin } from "@/mixins";
import { utils } from 'jsonapi-vuex'

import { FETCH_BY_ID, DELETE, SAVE, SELECT, SELECTED, FETCH, UNSELECT } from "@/store/model.store";
// import {
//   MODEL_SAVE_ERROR, MODEL_SAVE_SUCCESS, MODEL_DELETE_SUCCESS, MODEL_DELETE_ERROR,
//   MODEL_MASS_UPDATE_SUCCESS, MODEL_MASS_UPDATE_ERROR
// } from "@/constants/strings";

export const modelUtilsMixin = {
  mixins: [
  ],
  methods: {
    get_model(model, id) {
      let res = this.$store.getters['jv/get']({ _jv: { id: id, type: model } })
      return utils.deepCopy(res)
    },
    select_model(model, itemOrId) {
      return this.$store.commit(SELECT, { model: model, itemOrId });
    },
    unselect_model(model) {
      return this.$store.commit(UNSELECT, { model: model });
    },
    selected_model(model) {
      return this.$store.getters[SELECTED]({ model: model })
    },
    save_model(model, instance) {
      return this.$store.dispatch(SAVE, { model: model, selected: false, item: instance });
    },
    fetch_model_by_id(model, id) {
      return this.$store.dispatch(FETCH_BY_ID, { model: model, id: id })
    },
    fetch_models(model, params, url = null) {
      return this.$store.dispatch(FETCH, { model: model, url: url, params });
    },
    delete_model_by_id(model, id) {
      return this.$store.dispatch(DELETE, { model: model, itemOrId: id });
    },
    // update_all(model, ids, attrs) {
    //   return this.$store.dispatch(UPDATE_ALL, {model: model, ids: ids, attrs: attrs})

    // }
  }
}

export default modelUtilsMixin;
