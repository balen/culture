<template>
  <select @change="switchLanguage" v-model="locale">
    <option
      v-for="sLocale in supportedLocales"
      :key="`locale-${sLocale}`"
      :value="sLocale"
      :selected="locale === sLocale"
    >
      {{ $t(`locale.${sLocale}`) }}
    </option>
  </select>
</template>

<script>
import Tr from "@/i18n/translation";
import i18n from "@/i18n/index.js"

export default {
  name: 'LanguageSwitcher',
  data() {
    return { 
      locale: null
    };
  },
  computed: {
    supportedLocales() {
      return Tr.supportedLocales
    },
    currentLocale() {
      return i18n.global.locale.value
    }
  },
  watch: {
    currentLocale(n,o) {
      this.locale = n
    }
  },
  methods: {
    async switchLanguage() {
      const newLocale = this.locale

      await Tr.switchLanguage(newLocale)
    }
  },
  mounted() {
    this.locale = i18n.global.locale.value
  },
}

</script>
