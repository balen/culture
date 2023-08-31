# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    # If it is the intro for a survey then we want to make sure we need a new respondent id
    # so clear any that may be cached in the session
    if request.path.include? "/intro/"
      # Rails.logger.debug "******* INDEX #{request.path}"
      set_current_respondent_id(respondent_id: nil)
    end
  end
end
