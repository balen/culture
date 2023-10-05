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

    def setup_responses(responses)
      # Create submission, questions etc
      survey_submission = create(:survey_submission, survey: survey, organization_survey: organization_survey)
      responses.each do |question, value|
        create(:survey_response, 
          submission: survey_submission,
          question: question,
          response: { value: value }  
        )
      end
    end

    it 'handles 2 responses' do
      setup_responses(
        question("PS02") => 5,
        question("GM01") => 6
      )

      expect(Survey::Response.count).to eq(2)
    end

    it 'handles 6 responses' do
      setup_responses(
        question("PS01") => 5,
        question("PS02") => 5,
        question("PS03") => 5,
        question("GM01") => 6,
        question("GM02") => 6,
        question("GM03") => 6
      )

      expect(Survey::Response.count).to eq(6)
    end

    it 'calculates scores correctly' do
      setup_responses(
        question("PS02") => 5,
        question("GM01") => 6
      )

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