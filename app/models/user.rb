# Copyright (c) 2023 Henry Balen. All Rights Reserved.
# frozen_string_literal: true
class User < ApplicationRecord
  validates :email, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable

end
