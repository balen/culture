# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Survey::QuestionVariant < ApplicationRecord
  extend Mobility
  
  belongs_to :question,
             class_name: 'Survey::Question',
             foreign_key: 'question_id',
             inverse_of: :question_variants

  translates :question
end
