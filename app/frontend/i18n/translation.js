// import i18n from "@/i18n"
import i18n from "@/i18n/index.js"

const Trans = {
  isLocaleSupported(locale) {
    return Trans.supportedLocales.includes(locale)
  },

  getUserLocale() {
    const locale = window.navigator.language ||
      window.navigator.userLanguage ||
      Trans.defaultLocale

    return {
      locale: locale,
      localeNoRegion: locale.split('-')[0]
    }
  },

  get defaultLocale() {
    return 'en' //import.meta.env.VITE_DEFAULT_LOCALE
  },

  get supportedLocales() {
    return import.meta.env.VITE_SUPPORTED_LOCALES.split(",")
  },

  set currentLocale(newLocale) {
    i18n.global.locale.value = newLocale
  },

  getPersistedLocale() {
    const persistedLocale = localStorage.getItem("user-locale")

    if (Trans.isLocaleSupported(persistedLocale)) {
      return persistedLocale
    } else {
      return 'en'
    }
  },

  async switchLanguage(newLocale) {
    Trans.currentLocale = newLocale
    document.querySelector("html").setAttribute("lang", newLocale)
    localStorage.setItem("user-locale", newLocale)
  },

  async routeMiddleware(to, _from, next) {
    let paramLocale = to.params.locale
    paramLocale ||= 'en'

    if (!Trans.isLocaleSupported(paramLocale)) {
      return next('en')
    }

    await Trans.switchLanguage(paramLocale)

    return next()
  }
}

export default Trans
