import { mapState, mapActions } from 'vuex';
import { GET_SESSION_USER } from "@/store/user_session.store";

export const userSessionMixin = {
  computed: {
    ...mapState({
      currentUser: 'user'
    }),
    loggedIn() {
      return !!this.currentUser.id
    }
  },
  methods: {
    ...mapActions({
      fetchSession: GET_SESSION_USER,
    })
  },
  mounted() {
    // fetch the current session on mount !!!
    this.fetchSession();
  }
}

export default userSessionMixin;
