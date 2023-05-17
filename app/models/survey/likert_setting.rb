# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Survey::LikertSetting < ApplicationRecord
  extend Mobility

  belongs_to :survey_question,
              class_name: 'Survey::Question',
              foreign_key: 'question_id',
              inverse_of: :likert_setting

  has_many :likert_categories,
          class_name: 'Survey::LikertCategory',
          foreign_key: 'likert_setting_id',
          inverse_of: :likert_setting,
          dependent: :destroy
  accepts_nested_attributes_for :likert_categories, allow_destroy: true

  translates :left_label, :right_label
end
