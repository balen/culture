<!--  -->
<template>
  <app-layout>
    <router-view></router-view>
  </app-layout>
</template>

<script>
import userSessionMixin from "@/mixins/user_session.mixin";
import AppLayout from "@/layouts/app_layout.vue"

export default {
  name: "CultureApp",
  components: {
    AppLayout
  },
  mixins: [
    userSessionMixin
  ],
  data() {
    return {
      showOverlay: false
    }
  },
  computed: {
  },
  methods: {
  },
  mounted() {
    // console.debug("***** APP MOUNTED *****")
  }
}
</script>

<style lang="scss" scoped></style>
