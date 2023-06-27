# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class ResourceController < ApplicationController
  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token
  before_action :load_resource

  respond_to :json

  before_action :prevent_cache

  include ResourceMethods
end
