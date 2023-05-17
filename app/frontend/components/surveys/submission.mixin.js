import { mapActions, mapMutations } from "vuex";
import { UNSELECT, PATCH_FIELDS } from "@/store/model.store";
import { submissionModel, NEW_SUBMISSION, SubmissionStatus } from "@/store/survey";
import { responseModel, surveyModel } from "@/store/survey/survey.model";
import toastMixin from '@/mixins/toast.mixin'

export const submissionMixin = {
  mixins: [toastMixin],
  computed: {
    selectedSubmission() {
      return this.selected_model(submissionModel);
    }
  },
  methods: {
    ...mapMutations({
      unselect: UNSELECT,
    }),
    ...mapActions({
      jvPost: 'jv/post',
      patch: PATCH_FIELDS,
      newSubmission: NEW_SUBMISSION
    }),
    getStoreResponses(submission) {
      return Object.values(this.$store.getters['jv/get']({
        _jv: {
          type: responseModel
        }
      }, `$[?(@.submission.id=='${submission.id}')]`));
    },
    submitSelectedSubmission() {
      var submission = this.selected_model(submissionModel);
      return this.toastPromise(new Promise((res, rej) => {
        this.patch({ model: submissionModel, item: { ...this.selectedSubmission, submission_state: SubmissionStatus.SUBMITTED }, fields: ['submission_state'] }).then((data) => {
          this.unselect({ submissionModel })
          res(data)
        }).catch(rej)
      }));
    }
  }
}

export default submissionMixin;
