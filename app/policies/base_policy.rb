# Copyright (c) 2023 Henry Balen. All Rights Reserved.
class BasePolicy
  attr_reader :user, :record

  # Helper method to call Access Control to see if requested action is allowed
  def allowed?(action:)
    # Use it allowed to do stuff to their oen instance
    return true if (@record.class != Symbol) && (@record.class == ::User) && (@record.id == @user.id)

    # And to instances that they own
    if (@record.class != Symbol) && (!@record.is_a?(Class)) && (@record.has_attribute?(:user_id))
      return true if @record.user_id == @user.id
    end

    # false # defeult is not to allow anything
    @user.present?
  end

  # We want the "user" to be either the logged in user or the zoom user
  # that owns/hosts the zoom session. So store both in a context object
  # for the Policies to use
  def initialize(user, record)
    @user = user
    @record = record
  end

  # Base scope
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
