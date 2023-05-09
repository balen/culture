<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <div class="row scrollable">
    <div class="col-12">
      <p>Welcome {{ currentUser.name }}!</p>
    </div>
    <!-- TODO: put in instructions etc. -->
  </div>
</template>

<script>
import { userSessionMixin } from '@/mixins/user_session.mixin';

export default {
  name: "Dashboard",
  mixins: [userSessionMixin]
}
</script>
