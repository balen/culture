class Survey::Answer < ApplicationRecord
  extend Mobility

  belongs_to :question,
            class_name: 'Survey::Question',
            foreign_key: 'question_id',
            inverse_of: :answers

  translates :answer
end
