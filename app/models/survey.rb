class Survey < ApplicationRecord
  # See https://github.com/shioyama/mobility
  extend Mobility

  has_many :groups,
          class_name: 'Survey::Group',
          inverse_of: :survey,
          dependent: :destroy
  accepts_nested_attributes_for :groups, allow_destroy: true

  has_many :questions, through: :groups, class_name: 'Survey::Question'
  has_many :submissions, class_name: 'Survey::Submission', dependent: :destroy

  before_destroy :check_for_use
  # before_destroy :check_if_public, :check_for_use

  translates :name
  validates :name, presence: true # TODO: does this work with mobility?

  has_many  :organization_surveys
  has_many  :organizations, through: :organization_surveys

  private

  def check_for_use
    # If it has submissions with responses then we do not delete the survey
    raise 'can not delete a survey that has responses in the system' if submissions.joins(:responses).any?
  end
end
