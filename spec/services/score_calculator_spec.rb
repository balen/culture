require 'rails_helper'

RSpec.describe ScoreCalculator, type: :service do
  describe '.calculate_scores' do
    let(:survey) { create(:survey) }
    let(:question_1) { create(:question, short_code: "PS02", question: 'Members of this team are able to bring up problems and tough issues') }
    let(:question_2) { create(:question, short_code: "GM01", question: 'I don’t think I personally can do much to increase my intelligence.') }

    # let(:survey_submission) { create(:survey_submission, survey: survey) }
    # let(:response_1) { create(:response, submission: survey_submission, question: question_1, response: { 'value' => '5' }) }
    # let(:response_2) { create(:response, submission: survey_submission, question: question_2, response: { 'value' => '6' }) }

    before do
      # response_1
      # response_2
    end

    it 'calculates scores correctly' do
      # scores = described_class.calculate_scores(survey.id)

      # expect(scores).to eq({
      #   "PS" => 5,
      #   "GM" => 2
      # })
    end
  end
end