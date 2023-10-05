class ScoreCalculator
  # These weights are derived from the sample spreadsheet
  WEIGHTS = {
    PS: {
      PS01: { invert: true, weight: Rational(100, 42)},
      PS02: { invert: false, weight: Rational(100, 42)},
      PS03: { invert: true, weight: Rational(100, 42)},
      PS04: { invert: false, weight: Rational(100, 42)},
      PS05: { invert: true, weight: Rational(100, 42)},
      PS06: { invert: false, weight: Rational(100, 42)},
      PS07: { invert: false, weight: Rational(100, 42)}
    },
    TM: {
      # Goes from -100 to +100
      TM01: { invert: false, weight: 10.0},
      TM02: { invert: false, weight: 5.0},
      TM03: { invert: false, weight: Rational(10, 6)},
      TM04: { invert: false, weight: Rational(-10, 6)},
      TM05: { invert: false, weight: -5.0},
      TM06: { invert: false, weight: -10.0}
    },
    GM: {
      GM01: { invert: true, weight: Rational(100, 48)},
      GM02: { invert: true, weight: Rational(100, 48)},
      GM03: { invert: true, weight: Rational(100, 48)},
      GM04: { invert: true, weight: Rational(100, 48)},
      GM05: { invert: false, weight: Rational(100, 48)},
      GM06: { invert: false, weight: Rational(100, 48)},
      GM07: { invert: false, weight: Rational(100, 48)},
      GM08: { invert: false, weight: Rational(100, 48)}
    }
  }

  # we get the avareage for each question - based on the number of responses
  def total(scores:)
    scores.map{|s, v| v }.reduce(:+).to_f.round(1)
  end

  def range(group_short_code:, scores:)
    score = total(scores: scores)
    excluded = scores.map{|s, v| s.to_sym}
    min = min(group_short_code: group_short_code, exclude: excluded)
    {
      # if min is - and score is - then we keep min
      min: (min < 0 && score < 0) ? min : min + score,
      max: max(group_short_code: group_short_code, exclude: excluded) + score
    }
  end

  def psychological_safety(organization_id:, access_code:, survey_respondent_id: nil)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :PS, survey_respondent_id: survey_respondent_id)
  end

  def total_motivation(organization_id:, access_code:, survey_respondent_id: nil)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :TM, survey_respondent_id: survey_respondent_id)
  end

  def growth_mindset(organization_id:, access_code:, survey_respondent_id: nil)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :GM, survey_respondent_id: survey_respondent_id)
  end

  def min(group_short_code:, exclude: [])
    min = 0.0
    WEIGHTS[group_short_code].each do |k, q|
      next if exclude.include? k

      if q[:weight] < 0
        min += 7 * q[:weight]
      else
        min += q[:weight]
      end
    end
    # Rails.logger.debug "**** MIN FOR #{group_short_code} is #{min}"
    min.to_f.round(2)
  end

  def max(group_short_code:, exclude: [])
    max = 0.0
    WEIGHTS[group_short_code].each do |k, q|
      next if exclude.include? k
      # Rails.logger.debug "CALC for #{k}"

      if q[:weight] < 0
        max += q[:weight]
      else
        max += 7 * q[:weight]
      end
    end
    # Rails.logger.debug "**** #{group_short_code} exclude #{exclude}"
    # Rails.logger.debug "**** MAX FOR #{group_short_code} is #{max}"
    max.to_f.round(2)
  end

  # need dimension of the question
  # s = calc.psychological_safety(organization_id: "47b8292c-3266-483a-b5fb-bb21d239d6c4", access_code: "ABCD")
  def individual_scores(organization_id:, access_code:, group_short_code:, survey_respondent_id: nil)
    scores = {}
    counts = {}
    response_data = if survey_respondent_id
                      View::ResponseView.responses(organization_id: organization_id, access_code: access_code, group_short_code: group_short_code, survey_respondent_id: survey_respondent_id)
                    else
                      View::ResponseView.responses(organization_id: organization_id, access_code: access_code, group_short_code: group_short_code)
                    end

    response_data.each do |submission_id, responses|
      responses.each do |response|
        scores[response.short_code] ||= 0
        counts[response.short_code] ||= 0
        raw_score = response.response_as_text.to_i
        
        # Invert the score if needed
        if WEIGHTS[group_short_code][response.short_code.to_sym][:invert]
          raw_score = 8 - raw_score
        end
        
        # Apply the weight
        scores[response.short_code] += (raw_score - 1) * WEIGHTS[group_short_code][response.short_code.to_sym][:weight]
        counts[response.short_code] += 1
      end
    end

    # Provide average for each question answered
    scores.map{|code, value| [code, (value / counts[code]).to_f.round(2) ] }.to_h
  end
end