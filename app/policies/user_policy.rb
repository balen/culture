#
class UserPolicy < ApplicationPolicy

  def me?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user
        scope.where(id: @user.id)
      else
        # return no records
        scope.where(id: nil)
      end
    end
  end

end