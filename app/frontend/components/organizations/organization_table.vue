<template>
  <div>
    <table-vue 
      @new="openNewModal"
      defaultSortBy='organizations.name'
      :defaultSortDesc="true"
      :model="model"
      :columns="columns"
      ref="organizations-table"
    >
      <template #cell(title)="{ item }">
        <router-link :to="'/organization/' + item.id">{{ item.name }}</router-link>
      </template>
    </table-vue>
    <modal id="add-organization" title="Add Organization" @ok="onNew">
      <b-form-group label="Organization Name">
        <b-form-input id="organization-new-organization-name" type="text" v-model="newOrganizationName"></b-form-input>
      </b-form-group>
    </modal>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import Modal from '@/components/shared/modal.vue';
import TableVue from '@/components/shared/table_vue.vue';
import { organization_columns as columns } from './organization';
import { NEW_ORGANIZATION, organizationModel as model } from '@/store/organization.store'

export default {
  name: 'OrganizationTable',
  components: {
    TableVue,
    Modal
  },
  mixins: [
  ],
  data: () => ({
    columns,
    model,
    newOrganizationName: null
  }),
  methods: {
    ...mapActions({
      newOrganization: NEW_ORGANIZATION
    }),
    openNewModal() {
      this.newOrganizationName = null;
      this.$bvModal.show('add-organization');
    },
    onNew() {
      this.newOrganization({name: this.newOrganizationName }).then((data) => {
         this.$refs['organizations-table'].fetchPaged()
      })
    }
  },
  mounted() {
    this.$refs['organizations-table'].fetchPaged()
  }
}
</script>
