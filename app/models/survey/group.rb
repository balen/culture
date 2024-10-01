# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Survey::Group < ApplicationRecord
  extend Mobility

  has_many :questions,
           -> { where(deleted_at: nil) },
           class_name: 'Survey::Question',
           foreign_key: 'group_id',
           inverse_of: :group,
           dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  has_and_belongs_to_many :surveys, class_name: "Survey", foreign_key: "group_id"

  translates :name
end
