class Organization < ApplicationRecord
  validates :name, uniqueness: true

  # link to surveys
  has_many  :organization_surveys
  has_many  :surveys, through: :organization_surveys
  # has_many  :submissions, through: :organization_surveys
end
