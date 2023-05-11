<!-- Copyright (c) 2023 Henry Balen. All Rights Reserved. -->
<template>
  <div class="row">
    <div class="col" v-if="loggedIn">
      <organization-manage></organization-manage>
    </div>
  </div>
</template>

<script>
import { userSessionMixin } from '@/mixins/user_session.mixin';
import OrganizationManage from '@/components/organizations/organization_manage.vue';


export default {
  name: "Dashboard",
  mixins: [userSessionMixin],
  components: {
    OrganizationManage
  }
}
</script>
