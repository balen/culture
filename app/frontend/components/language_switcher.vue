<template>
  <select @change="switchLanguage" v-model="locale" v-if="locale">
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
    }
  },
  methods: {
    switchLanguage() {
      Tr.switchLanguage(this.locale)
    }
  },
  mounted() {
    this.locale = Tr.getPersistedLocale()
  },
}

</script>
