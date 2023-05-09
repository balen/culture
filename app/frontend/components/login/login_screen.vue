<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <router-view></router-view>
</template>

<script>
import { userSessionMixin } from '@/mixins/user_session.mixin';

export default {
  name: "LoginScreen",
  props: ['redirect'],
  components: {
  },
  mixins: [
    userSessionMixin
  ],
  watch: {
    loggedIn(newval, oldval) {
      if (newval) {
        this.$router.replace(this.redirect)
      }
    }
  },
};
</script>

<style lang="scss" scoped>
// @media (max-width: 576px) {
//   .login-screen {
//     width: 100%;
//   }
// }
// @media (min-width: 577px) {
//   .login-screen {
//     width: 500px;
//     margin: 0 auto;
//   }
// }
</style>
