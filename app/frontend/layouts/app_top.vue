<template>
  <div>
    <div class="row">
      <div class="col-12 px-0">
        <b-navbar toggleable="lg" type="dark" variant="secondary">
          <b-navbar-brand href="#">Culture</b-navbar-brand>
          <b-navbar-nav class="ml-auto">
            <LanguageSwitcher class="mr-3" />
            <b-nav-text class="mr-3" v-if="loggedIn">Logged in as: {{ currentUser.email ? currentUser.email : '' }}</b-nav-text>
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
import AppTopNav from '@/layouts/app_top_nav.vue';
import Tr from "@/i18n/translation";
import LanguageSwitcher from "@/components/language_switcher.vue";

/*
 */
export default {
  name: "AppTop",
  components: {
    AppTopNav,
    LanguageSwitcher
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
