# Copyright (c) 2023 Henry Balen. All Rights Reserved.
class ApplicationPolicy < BasePolicy
  def index?
    true
  end

  def show?
    allowed?(action: :show)
  end

  def destroy?
    allowed?(action: :destroy)
  end

  def update?
    allowed?(action: :update)
  end

  def create?
    allowed?(action: :create)
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      # if allowed?(action: :index)
      #   scope.all
      # else
      if scope == User
        scope.where(id: @user.id)
      elsif scope.attribute_method? :user_id
        scope.where(user_id: @user.id)
      elsif @user
        scope.all
      else # return no records
        scope.where(id: nil)
      end
      # end
    end
  end
end
