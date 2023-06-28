<template>
  <div class="row">
    <div class="col-12 px-0">
      <b-nav small align="center" v-if="loggedIn">
        <b-nav-item :disabled="!loggedIn" to="/">Home</b-nav-item>
      </b-nav>
    </div>
  </div>
</template>

<script>
import userSessionMixin from "@/mixins/user_session.mixin"
import { authMixin } from '@/mixins/auth.mixin';

/*
 */
export default {
  name: "AppTopNav",
  components: {
  },
  mixins: [authMixin, userSessionMixin]
}
</script>

<style scoped></style>
