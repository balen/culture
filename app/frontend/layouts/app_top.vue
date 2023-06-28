<template>
  <div>
    <div class="row">
      <div class="col-12 px-0">
        <b-navbar toggleable="lg" type="dark" variant="secondary">
          <b-navbar-brand href="#">Culture</b-navbar-brand>
          <b-navbar-nav class="ml-auto">
            <b-nav-text class="mr-3" v-if="loggedIn">Logged in as: {{ currentUser.email ? currentUser.email : '' }}</b-nav-text>
            <b-nav-form v-if="!loggedIn">
              <b-button size="sm" @click="login" variant="primary">login</b-button>
            </b-nav-form>
            <b-nav-form v-if="loggedIn">
              <b-button size="sm" @click="logout" variant="primary">Logout</b-button>
            </b-nav-form>
          </b-navbar-nav>
        </b-navbar>
      </div>
    </div>
    <app-top-nav></app-top-nav>
  </div>
</template>

<script>
import userSessionMixin from "@/mixins/user_session.mixin"
import { authMixin } from '@/mixins/auth.mixin';
import AppTopNav from './app_top_nav.vue';
import Tr from "@/i18n/translation";

/*
 */
export default {
  name: "AppTop",
  components: {
    AppTopNav
  },
  mixins: [
    authMixin,
    userSessionMixin
  ],
  data() {
    return {
    }
  },
  methods: {
    login() {
      this.$router.push(`/${Tr.getPersistedLocale()}/login`)
    },
    logout() {
      this.signOut().then(() => {
        this.fetchSession({ force: true }).then(
          () => {
            this.$router.push(`/${Tr.getPersistedLocale()}/`)
          }
        )
      })
    }
  }
}
</script>

<style scoped></style>
