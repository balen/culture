import { createI18n } from "vue-i18n"
// import pluralRules from "./rules/pluralization"
// import numberFormats from "./rules/numbers.js"
// import datetimeFormats from "./rules/datetime.js"
import en from "./locales/en.json"
import fr from "./locales/fr.json"
// import pt_BR from "./locales/pt_BR.json"

const i18n = createI18n({
  legacy: false,
  globalInjection: true,
  locale: import.meta.env.VITE_DEFAULT_LOCALE, //'en',
  fallbackLocale: import.meta.env.VITE_FALLBACK_LOCALE,
  // fallbackLocale: 'en',
  messages: {
    en: en,
    fr: fr
    // pt_BR: pt_BR
  },
  runtimeOnly: false
  // pluralRules,
  // numberFormats,
  // datetimeFormats
})

export default i18n;