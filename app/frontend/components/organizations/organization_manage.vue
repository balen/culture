<template>
  <div class="mb-3">
    <organization-table></organization-table>
    <organization-sidebar :model="model"></organization-sidebar>
  </div>
</template>

<script>
import OrganizationTable from './organization_table.vue';
import OrganizationSidebar from './organization_sidebar.vue';
import { organizationModel as model } from '@/store/organization.store';

export default {
  name: "OrganizationManage",
  data: () => ({
    model
  }),
  components: {
    OrganizationTable,
    OrganizationSidebar
  },
  mixins: [
  ]
}
</script>

<style></style>
