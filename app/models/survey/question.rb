# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Survey::Question < ApplicationRecord
  extend Mobility

  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :deleted, -> { where('survey_questions.deleted_at is not null') }
  default_scope { includes(:group) }

  belongs_to :group,
            class_name: 'Survey::Group',
            foreign_key: 'group_id',
            inverse_of: :questions

  has_one :survey, through: :group

  has_many :question_variants,
          class_name: 'Survey::QuestionVariant',
          foreign_key: 'question_id',
          inverse_of: :question,
          dependent: :destroy

  has_many :answers,
          class_name: 'Survey::Answer',
          foreign_key: 'question_id',
          inverse_of: :question,
          dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true

  has_many :responses, dependent: :destroy, class_name: 'Survey::Response', foreign_key: 'question_id'

  validates_inclusion_of :question_type, in:
    [
      :textfield, :textbox,
      :singlechoice, :multiplechoice,
      :dropdown,
      :boolean, # true or false
      :likert
      # score 1 to 5 with labels at each end
    ]
  
  has_one :likert_setting,
          class_name: 'Survey::LikertSetting',
          inverse_of: :survey_question,
          dependent: :destroy
  accepts_nested_attributes_for :likert_setting, update_only: true

  translates :question

  def soft_delete
    if responses.any?
      self.deleted_at = Time.now
      self.save!
    else
      self.destroy
    end
  end

  def question_type
    read_attribute(:question_type).to_sym
  end

  def question_type= (value)
    write_attribute(:question_type, value.to_s)
  end

  def update_answers(new_answers) # A collection of answers that have been passed in
    # If the answer is new then create one and add it (i.e. answer does not have an id)
    # If the answer has an id then update the value
    # Any left over are for deletion
    updates = Hash[ new_answers.map { |a| ( (a[:id] && (a[:id].to_i > 0)) ? [a[:id].to_i, a] : nil) }.compact ]
    newAnswers = new_answers.collect { |a| ( (a[:id] && (a[:id].to_i > 0)) ? nil : a) }.compact

    answers.each do |answer|
      if updates[answer.id]
        answer.update_attributes( updates[answer.id] )
      else
        # delete it and remove it from the collection
        candidate = answers.delete(answer)
      end
    end

    # now create the new ones
    newAnswers.each do |answer|
      answers << SurveyAnswer.new(answer)
    end
  end
end
