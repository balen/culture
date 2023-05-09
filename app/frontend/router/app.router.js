/*
 */
import { store } from '@/store/model.store';

import { createRouter, createWebHistory, createWebHashHistory } from 'vue-router'
import { GET_SESSION_USER } from '@/store/user_session.store';

// Login
import LoginScreen from '@/components/login/login_screen.vue'
import ForgotPassword from '@/components/login/forgot_password.vue'
import Login from '@/components/login/login.vue';
import NewPassword from '@/components/login/new_password.vue';

const loginRoutes = [
  { path: 'forgot', component: ForgotPassword },
  { path: 'password-reset', component: NewPassword },
  { path: '', component: Login, name: "login" },
]

// dashboard
import Dashboard from '@/components/dashboard/dashboard.vue';

export const router = createRouter({
  // Provide the history implementation to use. We are using the hash history for simplicity here.
  history: createWebHistory(), //(process.env.BASE_URL),
  routes: [
    {
      path: '/login',
      component: LoginScreen,
      children: loginRoutes,
      meta: { guest: true },
      props: true
    },
    {
      path: '/dashboard',
      component: Dashboard,
      meta: {
        // requiresAuth: true
      }
    },
    {
      path: '',
      redirect: '/dashboard'
    }
  ]
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // GET SESSION USER only fetches if we don't have one :)
    // TODO this might mess up auto-logout we'll see
    // router.app.$
    store.dispatch(GET_SESSION_USER).then((session) => {
      if (!session.id) {
        next({
          path: '/login',
          query: { redirect: to.fullPath }
        })
      } else {
        console.debug("sending to /dashboard");
        next({
          path: '/dashboard',
          query: { redirect: to.fullPath }
        })
      }
    }).catch((error) => {
      console.error(error)
      next();
    })
  } else {
    next() // make sure to always call next()!
  }
})
