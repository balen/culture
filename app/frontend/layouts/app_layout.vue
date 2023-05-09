<template>
  <div class="container-fluid">
    <app-top/>
    <slot></slot>
    <app-bottom/>
  </div>
</template>

<script>
import userSessionMixin from "@/mixins/user_session.mixin"
import AppTop from "@/layouts/app_top.vue"
import AppBottom from "@/layouts/app_bottom.vue"

/*
  The web view shows the HTML in the app page
 */
export default {
  name: "AppLayout",
  components: {
    AppTop,
    AppBottom
  },
  mixins: [
    userSessionMixin,
  ]
}
</script>

<style scoped></style>
