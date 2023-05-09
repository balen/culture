class Survey::LikertCategory < ApplicationRecord
  extend Mobility

  belongs_to :likert_setting,
            class_name: 'Survey::LikertSetting',
            foreign_key: 'likert_setting_id',
            inverse_of: :likert_categories

  translates :label
end
