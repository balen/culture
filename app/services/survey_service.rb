class SurveyService
  attr_accessor :survey

  # Return unique number questions in a random order
  def randomQuestions(number: 15)
    pool = @survey.questions.to_a
    results = []

    for i in 1..number do
      idx = rand(pool.size)
      results.concat pool.slice!(idx,1)
    end

    results
  end

  def self.getService(survey:)
    SurveyService.new(survey)
  end

  def initialize(survey)
    @survey = survey
  end
end