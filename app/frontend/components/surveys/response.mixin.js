import { utils } from "jsonapi-vuex"
import { submissionModel, questionModel, responseModel } from "@/store/survey"
import { PATCH_FIELDS } from "@/store/model.store"
import { mapActions, mapState, mapMutations } from "vuex"
import { NEW_RESPONSE } from "@/store/survey";

export const responseMixin = {
  computed: {
    ...mapState(['previewMode']),
  },
  methods: {
    ...mapMutations({
      mergeRecords: 'jv/mergeRecords',
      newResponse: NEW_RESPONSE
    }),
    ...mapActions({
      patch: PATCH_FIELDS,
    }),
    getExistingResponse(relationships) {
      let existingResponses = this.$store.getters['jv/get']({
        _jv: {
          type: responseModel,
        }
      }, `$[?(@.question.id=='${relationships.question.data.id}' && @.submission.id=='${relationships.submission.data.id}')]`)
      // console.log('existing responses', existingResponses)
      return Object.values(existingResponses)[0]
    },
    getResponse(question, selectedSubmission) {
      // console.debug('getting response...')
      if (!question || !selectedSubmission) {
        // console.debug('missing one of question or selectedSubmission', this.question, this.selectedSubmission)
        return undefined;
      }
      let relationships = {
        question: {
          data: {
            id: question.id,
            type: questionModel
          }
        },
        submission: {
          data: {
            id: selectedSubmission.id,
            type: submissionModel
          }
        }
      }
      let text = '';
      let answers = []
      // first check for a linked field
      // console.debug("now i have both", this.question, this.selectedSubmission)
      let existingResponse = this.getExistingResponse(relationships)
      if (existingResponse?.id) {
        return utils.deepCopy(existingResponse)
      }
      // if there's not one, create a new one
      // console.debug("getting a new response")
      this.newResponse({ relationships, answers, text, socialmedia });
      return utils.deepCopy(this.getExistingResponse(relationships))
    },
    // saving the response only
    saveResponse(response) {
      // return this.mergeRecords(response); // this version only saves locally
      return this.jvPost(response); // this version saves to the server
    }
  }
}

export default responseMixin;
