class Survey::QuestionVariant < ApplicationRecord
  extend Mobility
  
  belongs_to :question,
             class_name: 'Survey::Question',
             foreign_key: 'question_id',
             inverse_of: :question_variants

  translates :question
end
