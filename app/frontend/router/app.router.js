/*
 */
import { store } from '@/store/model.store';

import { createRouter, createWebHistory, RouterView } from 'vue-router'
import { GET_SESSION_USER } from '@/store/user_session.store';

// Login
import LoginScreen from '@/components/login/login_screen.vue'
import ForgotPassword from '@/components/login/forgot_password.vue'
import Login from '@/components/login/login.vue';
import NewPassword from '@/components/login/new_password.vue';

import ResultsScreen from '@/components/results/results_screen.vue';
import MyResultsScreen from '@/components/results/my_results_screen.vue';

import SurveySubmissionScreen from '@/components/surveys/survey_submission_screen.vue'
import SurveyThankYou from '@/components/surveys/survey_thank_you.vue';
import IntroScreen from '@/components/surveys/intro_screen.vue';
import RespondentScreen from '@/components/surveys/respondent_screen.vue';
// individual result screen
import Tr from "@/i18n/translation"

const loginRoutes = [
  { path: 'forgot', component: ForgotPassword },
  { path: 'password-reset', component: NewPassword },
  { path: '', component: Login, name: "login" },
]

// Launchpad
import Launchpad from '@/components/launchpad/launchpad.vue';

export const router = createRouter({
  // Provide the history implementation to use. We are using the hash history for simplicity here.
  history: createWebHistory(), //(process.env.BASE_URL),
  routes: [
    {
      path: "/:locale?",
      component: RouterView,
      beforeEnter: Tr.routeMiddleware,
      children: [
        {
          path: 'admin',
          component: LoginScreen,
          children: loginRoutes,
          meta: { guest: true },
          props: true
        },
        {
          path: 'results/:id',
          component: ResultsScreen,
          props: true
        },
        {
          path: 'myresults/:id',
          component: MyResultsScreen,
          props: true,
          meta: { intro: true }
        },
        {
          path: 'launchpad',
          component: Launchpad,
          meta: {
            // requiresAuth: true
          }
        },
        // {
        //   path: 'surveys/:access_code/thankyou',
        //   component: SurveyThankYou,
        //   props: true,
        //   meta: { guest: true }
        // },
        {
          path: 'intro/:access_code',
          component: IntroScreen,
          props: true,
          meta: { guest: true, intro: true }
        },
        {
          path: 'thankyou/:access_code',
          component: RespondentScreen,
          props: true,
          meta: { guest: true }
        },
        {
          path: 'survey/submit/:access_code',
          component: SurveySubmissionScreen,
          props: true,
          meta: { guest: true },
          beforeEnter: (to, from) => {
            if (from.meta.intro) {
              return true
            } else {
              return {
                path: `/${Tr.getPersistedLocale()}`,
              }
            }
          },
        },
        {
          path: '',
          component: Launchpad
        },
        { 
          path: '/:pathMatch(.*)*', 
          name: 'NotFound', 
          component: Launchpad 
        }
      ]
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
        next({
          path: '/launchpad',
          query: { redirect: to.fullPath }
        })
      }
    }).catch((error) => {
      next();
    })
  } else {
    next() // make sure to always call next()!
  }
})
