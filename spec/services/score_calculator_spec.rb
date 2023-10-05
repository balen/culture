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
        question("PS01") => 5, question("PS02") => 5, question("PS03") => 5,
        question("GM01") => 6, question("GM02") => 6, question("GM03") => 6
      )

      expect(Survey::Response.count).to eq(6)
    end

    it 'calculates lowest PS' do
      setup_responses(
        question("PS01") => 7, question("PS02") => 1, question("PS03") => 7,
        question("PS04") => 1, question("PS05") => 7, question("PS06") => 1,
        question("PS07") => 1
      )
      calc = described_class.new
      ps_scores = calc.psychological_safety(organization_id: organization.id, access_code: "ABCD")   
      ps_total = calc.total(scores: ps_scores)

      expect(ps_total).to eq(0)
    end

    it 'calculates average PS' do
      setup_responses(
        question("PS01") => 4, question("PS02") => 4, question("PS03") => 4,
        question("PS04") => 4, question("PS05") => 4, question("PS06") => 4,
        question("PS07") => 4
      )
      calc = described_class.new
      ps_scores = calc.psychological_safety(organization_id: organization.id, access_code: "ABCD")   
      ps_total = calc.total(scores: ps_scores)

      expect(ps_total).to eq(50)
    end

    it 'calculates highest PS' do
      setup_responses(
        question("PS01") => 1, question("PS02") => 7, question("PS03") => 1,
        question("PS04") => 7, question("PS05") => 1, question("PS06") => 7,
        question("PS07") => 7
      )
      calc = described_class.new
      ps_scores = calc.psychological_safety(organization_id: organization.id, access_code: "ABCD")   
      ps_total = calc.total(scores: ps_scores)

      expect(ps_total).to eq(100)
    end

    it 'calculates lowest GM' do
      setup_responses(
        question("GM01") => 7, question("GM02") => 7, question("GM03") => 7,
        question("GM04") => 7, question("GM05") => 1, question("GM06") => 1,
        question("GM07") => 1, question("GM08") => 1
      )
      calc = described_class.new
      gm_scores = calc.growth_mindset(organization_id: organization.id, access_code: "ABCD")   
      gm_total = calc.total(scores: gm_scores)

      expect(gm_total).to eq(0)
    end

    it 'calculates average GM' do
      setup_responses(
        question("GM01") => 4, question("GM02") => 4, question("GM03") => 4,
        question("GM04") => 4, question("GM05") => 4, question("GM06") => 4,
        question("GM07") => 4, question("GM08") => 4
      )
      calc = described_class.new
      gm_scores = calc.growth_mindset(organization_id: organization.id, access_code: "ABCD")   
      gm_total = calc.total(scores: gm_scores)

      expect(gm_total).to eq(50)
    end

    it 'calculates highest GM' do
      setup_responses(
        question("GM01") => 1, question("GM02") => 1, question("GM03") => 1,
        question("GM04") => 1, question("GM05") => 7, question("GM06") => 7,
        question("GM07") => 7, question("GM08") => 7
      )
      calc = described_class.new
      gm_scores = calc.growth_mindset(organization_id: organization.id, access_code: "ABCD")   
      gm_total = calc.total(scores: gm_scores)

      expect(gm_total).to eq(100)
    end

    it 'calculates lowest TM' do
      setup_responses(
        question("TM01") => 1, question("TM02") => 1, question("TM03") => 1,
        question("TM04") => 7, question("TM05") => 7, question("TM06") => 7
      )
      calc = described_class.new
      tm_scores = calc.total_motivation(organization_id: organization.id, access_code: "ABCD")   
      tm_total = calc.total(scores: tm_scores)

      expect(tm_total).to eq(-100)
    end

    it 'calculates average TM' do
      setup_responses(
        question("TM01") => 4, question("TM02") => 4, question("TM03") => 4,
        question("TM04") => 4, question("TM05") => 4, question("TM06") => 4
      )
      calc = described_class.new
      tm_scores = calc.total_motivation(organization_id: organization.id, access_code: "ABCD")   
      tm_total = calc.total(scores: tm_scores)

      expect(tm_total).to eq(0)
    end

    it 'calculates highest TM' do
      setup_responses(
        question("TM01") => 7, question("TM02") => 7, question("TM03") => 7,
        question("TM04") => 1, question("TM05") => 1, question("TM06") => 1
      )
      calc = described_class.new
      tm_scores = calc.total_motivation(organization_id: organization.id, access_code: "ABCD")   
      tm_total = calc.total(scores: tm_scores)

      expect(tm_total).to eq(100)
    end
  end
end