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

    it 'calculates lowest P2T' do
      setup_responses(
        question("P2T1") => 1, question("P2T2") => 1, question("P2T3") => 1,
        question("P2T4") => 1, question("P2T5") => 1, question("P2T6") => 1
      )
      calc = described_class.new
      p2t_scores = calc.propensity_to_trust(organization_id: organization.id, access_code: "ABCD")
      p2t_total = calc.total(scores: p2t_scores)

      expect(p2t_total).to eq(0)
    end

    it 'calculates average P2T' do
      setup_responses(
        question("P2T1") => 4, question("P2T2") => 4, question("P2T3") => 4,
        question("P2T4") => 4, question("P2T5") => 4, question("P2T6") => 4
      )
      calc = described_class.new
      p2t_scores = calc.propensity_to_trust(organization_id: organization.id, access_code: "ABCD")
      p2t_total = calc.total(scores: p2t_scores)

      expect(p2t_total).to eq(50) # or the expected average score
    end

    it 'calculates highest P2T' do
      setup_responses(
        question("P2T1") => 7, question("P2T2") => 7, question("P2T3") => 7,
        question("P2T4") => 7, question("P2T5") => 7, question("P2T6") => 7
      )
      calc = described_class.new
      p2t_scores = calc.propensity_to_trust(organization_id: organization.id, access_code: "ABCD")
      p2t_total = calc.total(scores: p2t_scores)

      expect(p2t_total).to eq(100) # or the expected highest score
    end

    it 'calculates lowest PTW' do
      setup_responses(
        question("PTW1") => 1, question("PTW2") => 1, question("PTW3") => 1,
        question("PTW4") => 7, question("PTW5") => 7, question("PTW6") => 1
      )
      calc = described_class.new
      ptw_scores = calc.perceived_trustworthiness(organization_id: organization.id, access_code: "ABCD")
      ptw_total = calc.total(scores: ptw_scores)

      expect(ptw_total).to eq(0)
    end

    it 'calculates average PTW' do
      setup_responses(
        question("PTW1") => 4, question("PTW2") => 4, question("PTW3") => 4,
        question("PTW4") => 4, question("PTW5") => 4, question("PTW6") => 4
      )
      calc = described_class.new
      ptw_scores = calc.perceived_trustworthiness(organization_id: organization.id, access_code: "ABCD")
      ptw_total = calc.total(scores: ptw_scores)

      expect(ptw_total).to eq(50)
    end

    it 'calculates highest PTW' do
      setup_responses(
        question("PTW1") => 7, question("PTW2") => 7, question("PTW3") => 7,
        question("PTW4") => 1, question("PTW5") => 1, question("PTW6") => 7
      )
      calc = described_class.new
      ptw_scores = calc.perceived_trustworthiness(organization_id: organization.id, access_code: "ABCD")
      ptw_total = calc.total(scores: ptw_scores)

      expect(ptw_total).to eq(100)
    end

    it 'calculates lowest CB' do
      setup_responses(
        question("CB01") => 1, question("CB02") => 1, question("CB03") => 1,
        question("CB04") => 7, question("CB05") => 7, question("CB06") => 1
      )
      calc = described_class.new
      cb_scores = calc.cooperative_behaviours(organization_id: organization.id, access_code: "ABCD")
      cb_total = calc.total(scores: cb_scores)

      expect(cb_total).to eq(0)
    end

    it 'calculates average CB' do
      setup_responses(
        question("CB01") => 4, question("CB02") => 4, question("CB03") => 4,
        question("CB04") => 4, question("CB05") => 4, question("CB06") => 4
      )
      calc = described_class.new
      cb_scores = calc.cooperative_behaviours(organization_id: organization.id, access_code: "ABCD")
      cb_total = calc.total(scores: cb_scores)

      expect(cb_total).to eq(50)
    end

    it 'calculates highest CB' do
      setup_responses(
        question("CB01") => 7, question("CB02") => 7, question("CB03") => 7,
        question("CB04") => 1, question("CB05") => 1, question("CB06") => 7
      )
      calc = described_class.new
      cb_scores = calc.cooperative_behaviours(organization_id: organization.id, access_code: "ABCD")
      cb_total = calc.total(scores: cb_scores)

      expect(cb_total).to eq(100)
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

    it 'calculates PS range for no answers' do
      calc = described_class.new
      scores = calc.psychological_safety(organization_id: organization.id, access_code: "ABCD")
      range = calc.range(group_short_code: :PS, scores: scores)

      expect(range[:min]).to eq(0)
      expect(range[:max]).to eq(100)
    end

    it 'calculates TM range for no answers' do
      calc = described_class.new
      scores = calc.total_motivation(organization_id: organization.id, access_code: "ABCD")
      range = calc.range(group_short_code: :TM, scores: scores)

      expect(range[:min]).to eq(-100)
      expect(range[:max]).to eq(100)
    end

    it 'calculates GM range for no answers' do
      calc = described_class.new
      scores = calc.growth_mindset(organization_id: organization.id, access_code: "ABCD")
      range = calc.range(group_short_code: :GM, scores: scores)

      expect(range[:min]).to eq(0)
      expect(range[:max]).to eq(100)
    end

    it 'calculates GM range with half the answers' do
      setup_responses(
        question("GM01") => 4, question("GM02") => 4,
        question("GM05") => 4, question("GM06") => 4
      )
      calc = described_class.new
      scores = calc.growth_mindset(organization_id: organization.id, access_code: "ABCD")
      range = calc.range(group_short_code: :GM, scores: scores)

      expect(range[:min]).to eq(25)
      expect(range[:max]).to eq(75)
    end

  end
end