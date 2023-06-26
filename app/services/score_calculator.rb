class ScoreCalculator
  # These weights are derived from the sample spreadsheet
  WEIGHTS = {
    PS: {
      PS01: { invert: true, weight: 2.0},
      PS02: { invert: false, weight: 2.0},
      PS03: { invert: true, weight: 2.0},
      PS04: { invert: false, weight: 2.0},
      PS05: { invert: true, weight: 2.0},
      PS06: { invert: false, weight: 2.0},
      PS07: { invert: false, weight: 2.0}
    },
    TM: {
      TM01: { invert: false, weight: 10.0},
      TM02: { invert: false, weight: 5.0},
      TM03: { invert: false, weight: 1.66},
      TM04: { invert: false, weight: -1.66},
      TM05: { invert: false, weight: -5.0},
      TM06: { invert: false, weight: -10.0}
    },
    GM: {
      GM01: { invert: true, weight: 1.8},
      GM02: { invert: true, weight: 1.8},
      GM03: { invert: true, weight: 1.8},
      GM04: { invert: true, weight: 1.8},
      GM05: { invert: false, weight: 1.8},
      GM06: { invert: false, weight: 1.8},
      GM07: { invert: false, weight: 1.8},
      GM08: { invert: false, weight: 1.8}
      
    }
  }

  # calc = ScoreCalculator.new
  # calc.psychological_safety(organization_id: "47b8292c-3266-483a-b5fb-bb21d239d6c4", access_code: "ABCD")

  # we get the avareage for each question - based on the number of responses
  def summarize(scores:)
    scores.map{|s, v| v }.reduce(:+) / scores.count
  end

  def psychological_safety(organization_id:, access_code:)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :PS)
  end

  def total_motivation(organization_id:, access_code:)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :TM)
  end

  def growth_mindset(organization_id:, access_code:)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :GM)
  end

  def min(group_short_code:)
    min = 0.0
    WEIGHTS[group_short_code].each do |k, q|
      if q[:weight] < 0
        min += 7 * q[:weight]
      else
        min += q[:weight]
      end
    end
    min
  end

  def max(group_short_code:)
    max = 0.0
    WEIGHTS[group_short_code].each do |k, q|
      if q[:weight] < 0
        max += q[:weight]
      else
        max += 7 * q[:weight]
      end
    end
    max
  end

  def individual_scores(organization_id:, access_code:, group_short_code:)
    scores = {}
    response_data = View::ResponseView.responses(organization_id: organization_id, access_code: access_code, group_short_code: group_short_code)

    response_data.each do |submission_id, responses|
      responses.each do |response|
        scores[submission_id] ||= 0
        if WEIGHTS[group_short_code][response.short_code.to_sym][:invert]
          scores[submission_id] += (8 - response.response_as_text.to_i) * WEIGHTS[group_short_code][response.short_code.to_sym][:weight]
        else
          scores[submission_id] += (8 - response.response_as_text.to_i) * WEIGHTS[group_short_code][response.short_code.to_sym][:weight]
        end
      end
    end

    scores
  end
end