class SurveyService
  attr_accessor :survey

  # Return unique number questions in a random order
  def randomQuestions(number: 15, respondent: nil)
    # if we have access code and a current respondent
    #  then we know what questions they have been asked and
    #  use that to weight the "random" questions ....
    already_asked_ids = get_already_asked_ids(respondent: respondent)

    pool = if already_asked_ids.size > 0
              @survey.questions.where("survey_questions.id not in (?)", already_asked_ids).to_a
            else
              @survey.questions.to_a
            end

    results = []
    if pool.size > number
      for i in 1..number do
        idx = rand(pool.size)
        results.concat pool.slice!(idx,1)
      end
    else
      remainder = number - pool.size
      # First get from the pool
      for i in 1..pool.size do
        idx = rand(pool.size)
        results.concat pool.slice!(idx,1)
      end
      # Then get from the rest
      if remainder > 0
        already_asked = get_already_asked(ids: already_asked_ids)
        for i in (pool.size + 1)..number do
          idx = rand(already_asked.size)
          results.concat already_asked.slice!(idx,1)
        end
      end
    end

    results
  end

  # 
  def deterministicQuestions(respondent: nil)
    results = []
    already_asked_ids = get_already_asked_ids(respondent: respondent)

    # Go through each group proportion the questions from each accordingly
    groups = @survey.groups
    nbr_groups = groups.count
    per_group = 15 / nbr_groups
    remainder = 15 % nbr_groups
    pool = []
    groups.each do |group|
      amount = per_group + remainder if remainder
      remainder = 0
      if already_asked_ids.size > 0
        pool.concat group.questions.where("survey_questions.id not in (?)", already_asked_ids).to_a.first(amount)
      else
        pool.concat group.questions.to_a.first(amount)
      end
    end

    remainder = 15 - pool.size
    if remainder > 0
      already_asked = get_already_asked(ids: already_asked_ids)
      for i in (pool.size + 1)..15 do
        pool.concat already_asked.slice!(i,1)
      end
    end

    pool
  end

  def get_already_asked_ids(respondent: nil)
    return [] unless respondent

    questions = respondent.submissions.map{|s| s.questions}
    return [] unless questions.size > 0

    questions.reduce(:+).uniq
  end

  def get_already_asked(ids: [])
    return [] if ids.nil?
    return [] unless ids.length > 0

    @survey.questions.where("survey_questions.id in (?)", ids).to_a
  end

  def self.getService(survey:)
    SurveyService.new(survey)
  end

  def initialize(survey)
    @survey = survey
  end
end