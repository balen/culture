// 
import { BootstrapVue, IconsPlugin, BootstrapVueIcons } from 'bootstrap-vue';
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import { router } from '@/router/app.router';
import { store } from '@/store/model.store';

import Vue from 'vue';
import { createApp } from 'vue';

import VueCookies from 'vue-cookies';
import VuePluralize from 'vue-pluralize';

import CultureApp from './app.vue';

Vue.use(BootstrapVue, {
  BSkeleton: { animation: 'fade' }
});
Vue.use(VueCookies, {});
Vue.use(VuePluralize);
Vue.use(IconsPlugin)
Vue.use(BootstrapVueIcons)

// Create the Vue app
const app = createApp(CultureApp);
app.use(router) // Set up the router
app.use(store) // Set up the store
app.mount('#app') // Display app using element with id 'app'
