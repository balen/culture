<template>
  <div class="row">
    <div class="col-12 px-0">
      <b-nav small align="center">
        <!-- <b-nav-item :disabled="!loggedIn" to="/current_meeting">Current Meeting</b-nav-item>
        <b-nav-item :disabled="!loggedIn" to="/admin/meetings">Meetings</b-nav-item>
        <b-nav-item :disabled="!loggedIn" to="/history">History</b-nav-item> -->
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
  mixins: [
    authMixin,
    userSessionMixin
  ]
}
</script>

<style scoped></style>
