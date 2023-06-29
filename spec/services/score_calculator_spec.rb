require 'rails_helper'

RSpec.describe ScoreCalculator, type: :service do
  describe '.calculate_scores' do
    let(:survey) { create(:survey) }
    let(:survey_group_ps) { create(:survey_group, short_code: "PS", survey: survey) }
    let(:survey_group_gm) { create(:survey_group, short_code: "GM", survey: survey) }

    let(:question_ps) { 
      create(:survey_question, 
        short_code: "PS02", 
        question_type: 'likert', 
        question: 'Members of this team are able to bring up problems and tough issues',
        group: survey_group_ps
      ) 
    }
    let(:question_gm) { 
      create(:survey_question, 
        short_code: "GM01",
        question_type: 'likert',
        question: 'I don’t think I personally can do much to increase my intelligence.',
        group: survey_group_gm
      ) 
    }

    let(:organization) { create(:organization)}
    let(:organization_survey) { 
      create(:organization_survey,
        survey: survey,
        organization: organization,
        access_code: "1234"
      )
    }

    let(:survey_submission) { create(:survey_submission, survey: survey, organization_survey: organization_survey) }
    let(:response_1) { create(:survey_response, submission: survey_submission, question: question_ps, response: { 'value' => '5' }) }
    let(:response_2) { create(:survey_response, submission: survey_submission, question: question_gm, response: { 'value' => '6' }) }

    before do
      response_1
      response_2
    end

    it 'calculates scores correctly' do
      calc = described_class.new

      gm_scores = calc.growth_mindset(organization_id: organization.id, access_code: "1234")   
      expect(gm_scores).to eq(
        {
          # GM01 is inverted
          "GM01" => ((8 - 6) * Rational(100, 56)).to_f.round(2)
        }
      )

      ps_scores = calc.psychological_safety(organization_id: organization.id, access_code: "1234")   
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