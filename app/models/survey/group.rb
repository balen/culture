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

  belongs_to :survey

  translates :name
end
