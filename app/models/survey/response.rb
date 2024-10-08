# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class Survey::Response < ApplicationRecord
  belongs_to :question,
             class_name: 'Survey::Question',
             foreign_key: 'question_id'

  belongs_to :submission,
             class_name: 'Survey::Submission',
             foreign_key: 'submission_id',
             inverse_of: :responses

  before_save :set_response_text

  #
  # Extract the values from all the entries and save a plain text
  # version that can be used for searchin the responses in a "report"
  #
  def set_response_text
    if response
      flattened_response = flatten_response(response)

      strip_uuid = [:singlechoice, :multiplechoice].include?(question.question_type)
      if strip_uuid
        self.response_as_text = flattened_response.values.flatten.collect{|v| v[37..-1]}.reject { |e| e.to_s.empty? }.join('; ').strip
      else
        self.response_as_text = flattened_response.values.join(' ').strip
      end
    end
  end

  #
  def flatten_response(hash)
    hash.each_with_object({}) do |(k, v), h|
      if v.is_a? Hash
        flatten_response(v).map do |h_k, h_v|
          if k == 'socialmedia'
            h["#{k}.#{h_k}".to_sym] = "#{h_k}:#{h_v}" unless h_v.blank?
          else
            h["#{k}.#{h_k}".to_sym] = h_v unless h_v.blank?
          end
        end
      else
        h[k] = v
      end
    end
  end
end
