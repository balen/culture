class ScoreCalculator
  # These weights are derived from the sample spreadsheet
  WEIGHTS = {
    PS: {
      PS01: { invert: true, weight: Rational(100, 7 * 6)},
      PS02: { invert: false, weight: Rational(100, 7 * 6)},
      PS03: { invert: true, weight: Rational(100, 7 * 6)},
      PS04: { invert: false, weight: Rational(100, 7 * 6)},
      PS05: { invert: true, weight: Rational(100, 7 * 6)},
      PS06: { invert: false, weight: Rational(100, 7 * 6)},
      PS07: { invert: false, weight: Rational(100, 7 * 6)}
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
      GM01: { invert: true, weight: Rational(100, 8 * 6)},
      GM02: { invert: true, weight: Rational(100, 8 * 6)},
      GM03: { invert: true, weight: Rational(100, 8 * 6)},
      GM04: { invert: true, weight: Rational(100, 8 * 6)},
      GM05: { invert: false, weight: Rational(100, 8 * 6)},
      GM06: { invert: false, weight: Rational(100, 8 * 6)},
      GM07: { invert: false, weight: Rational(100, 8 * 6)},
      GM08: { invert: false, weight: Rational(100, 8 * 6)}
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
    min = (min < 0 && score < 0) ? min : (min + score).round(2)
    max = (max(group_short_code: group_short_code, exclude: excluded) + score).round(2)
    {
      # if min is - and score is - then we keep min
      min: min,
      max: max,
      width: (max - min).round(2)
    }
  end

  def psychological_safety(organization_id:, access_code:, survey_respondent_id: nil)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :PS, survey_respondent_id: survey_respondent_id)
  end

  def total_motivation(organization_id:, access_code:, survey_respondent_id: nil)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :TM, survey_respondent_id: survey_respondent_id)
  end

  def team_trust(organization_id:, access_code:, survey_respondent_id: nil)
    individual_scores(organization_id: organization_id, access_code: access_code, group_short_code: :TT, survey_respondent_id: survey_respondent_id)
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
        # Most got from 0 to 6 except TM which is 1 to 7 so also take that into account
        min += (group_short_code == :TM) ? q[:weight] : 0
      end
    end

    min.to_f.round(2)
  end

  def max(group_short_code:, exclude: [])
    max = 0.0
    WEIGHTS[group_short_code].each do |k, q|
      next if exclude.include? k

      if q[:weight] < 0
        max += q[:weight]
      else
        # Most got from 0 to 6 except TM which is 1 to 7 so also take that into account
        max += (group_short_code == :TM) ? 7 * q[:weight] : 6 * q[:weight]
      end
    end

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
        # Most got from 0 to 6 except TM which is 1 to 7 so also take that into account
        if WEIGHTS[group_short_code][response.short_code.to_sym][:invert]
          raw_score = (group_short_code == :TM) ? 8 - raw_score : 7 - raw_score
        else
          raw_score = (group_short_code == :TM) ? raw_score : raw_score - 1
        end
        
        # Apply the weight
        scores[response.short_code] += raw_score * WEIGHTS[group_short_code][response.short_code.to_sym][:weight]
        counts[response.short_code] += 1
      end
    end

    # Provide average for each question answered
    scores.map{|code, value| [code, (value / counts[code]).to_f.round(2) ] }.to_h
  end
end