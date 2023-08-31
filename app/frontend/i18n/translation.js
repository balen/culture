import i18n from "@/i18n/index.js"

import { SET_LOCALE } from '@/store/app.store';
import { store } from '@/store/model.store';
import { router } from "@/router/app.router"

const Trans = {
  isLocaleSupported(locale) {
    return Trans.supportedLocales.includes(locale)
  },

  getUserLocale() {
    const locale = window.navigator.language ||
      window.navigator.userLanguage ||
      Trans.defaultLocale

    // return {
    //   locale: locale,
    //   localeNoRegion: locale.split('-')[0]
    // }
    // return loclocale.split('-')[0]le

    // Return just the langiage part from the browser
    return locale.split('-')[0]
  },

  get defaultLocale() {
    return import.meta.env.VITE_DEFAULT_LOCALE
  },

  get supportedLocales() {
    return import.meta.env.VITE_SUPPORTED_LOCALES.split(",")
  },

  set currentLocale(newLocale) {
    i18n.global.locale.value = newLocale
  },

  getPersistedLocale() {
    const persistedLocale = store.state.locale
    const userLocale = Trans.getUserLocale()

    if (Trans.isLocaleSupported(persistedLocale)) {
      return persistedLocale
    } else if (currentLocale) {
      return currentLocale
    } else if (Trans.isLocaleSupported(userLocale)) {
      return userLocale
    } else {
      return defaultLocale
    }
  },

  async switchLanguage(newLocale, fromRouter = false) {
    store.commit(SET_LOCALE, newLocale)
    if (i18n.global.locale.value != newLocale) {
      Trans.currentLocale = newLocale
      document.querySelector("html").setAttribute("lang", newLocale)

      try {
        if (!fromRouter) {
          await router.replace({ params: { locale: newLocale } })
        }
      } catch (e) {
        console.log(e)
        router.push("/")
      }
    }
  },

  async routeMiddleware(to, _from, next) {
    let paramLocale = to.params.locale

    if (!Trans.isLocaleSupported(paramLocale)) {
      return next(Trans.defaultLocale)
    }

    await Trans.switchLanguage(paramLocale, true)

    return next()
  }
}

export default Trans
