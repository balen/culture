require 'rails_helper'

RSpec.describe ScoreCalculator, type: :service do
  describe '.calculate_scores' do
    def survey
      Survey.first
    end

    def organization
      Organization.first
    end

    def organization_survey
      OrganizationSurvey.first
    end

    def question(short_code)
      Survey::Question.find_by short_code: short_code
    end

    it '2 responses' do
      survey_submission = create(:survey_submission, survey: survey, organization_survey: organization_survey)
      create(:survey_response, submission: survey_submission, question: question("PS02"), response: { 'value' => '5' })
      create(:survey_response, submission: survey_submission, question: question("GM01"), response: { 'value' => '6' })

      expect(Survey::Response.count).to eq(2)
    end

    it '6 responses' do
      survey_submission = create(:survey_submission, survey: survey, organization_survey: organization_survey)
      create(:survey_response, submission: survey_submission, question: question("PS01"), response: { 'value' => '5' })
      create(:survey_response, submission: survey_submission, question: question("PS02"), response: { 'value' => '5' })
      create(:survey_response, submission: survey_submission, question: question("PS03"), response: { 'value' => '5' })
      create(:survey_response, submission: survey_submission, question: question("GM01"), response: { 'value' => '6' })
      create(:survey_response, submission: survey_submission, question: question("GM02"), response: { 'value' => '6' })
      create(:survey_response, submission: survey_submission, question: question("GM03"), response: { 'value' => '6' })

      expect(Survey::Response.count).to eq(6)
    end

    it 'calculates scores correctly' do
      survey_submission = create(:survey_submission, survey: survey, organization_survey: organization_survey)
      create(:survey_response, submission: survey_submission, question: question("PS02"), response: { 'value' => '5' })
      create(:survey_response, submission: survey_submission, question: question("GM01"), response: { 'value' => '6' })

      calc = described_class.new

      gm_scores = calc.growth_mindset(organization_id: organization.id, access_code: "ABCD")   
      expect(gm_scores).to eq(
        {
          # GM01 is inverted
          "GM01" => ((8 - 6) * Rational(100, 56)).to_f.round(2)
        }
      )

      ps_scores = calc.psychological_safety(organization_id: organization.id, access_code: "ABCD")   
      expect(ps_scores).to eq(
        {
          "PS02" => (5 * Rational(100, 49)).to_f.round(2)
        }
      )

      gm_total = calc.total(scores: gm_scores)
      gm_expected = gm_scores.map{|s, v| v }.reduce(:+).to_f.round(2)
      expect(gm_total).to eq(gm_expected)

      ps_total = calc.total(scores: ps_scores)
      ps_expected = ps_scores.map{|s, v| v }.reduce(:+).to_f.round(2)
      expect(ps_total).to eq(ps_expected)
    end
  end
end