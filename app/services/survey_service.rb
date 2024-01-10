class SurveyService
  attr_accessor :survey

  # Return unique number questions in a random order
  def randomQuestions(number: 15, respondent: nil)
    # TODO: change so that we get questions that have not been answered first

    # if we have access code and a current respondent
    #  then we know what questions they have been asked and
    #  use that to weight the "random" questions ....
    already_asked_ids = []
    already_asked = []
    if respondent
      already_asked_ids = respondent.submissions.map{|s| s.questions}.reduce(:+).uniq
      already_asked = @survey.questions.where("survey_questions.id in (?)", already_asked_ids).to_a
    end

    # pool = @survey.questions.to_a
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
      for i in (pool.size + 1)..number do
        idx = rand(already_asked.size)
        results.concat already_asked.slice!(idx,1)
      end
    end

    results
  end

  def deterministicQuestions(respondent: nil)
    results = []

    already_asked_ids = []
    if respondent
      already_asked_ids = respondent.submissions.map{|s| s.questions}.reduce(:+).uniq
    end

    pool = if already_asked_ids.size > 0
          @survey.questions.where("survey_questions.id not in (?)", already_asked_ids).to_a
        else
          @survey.questions.to_a
        end

    pool.first(15)
  end

  def self.getService(survey:)
    SurveyService.new(survey)
  end

  def initialize(survey)
    @survey = survey
  end
end