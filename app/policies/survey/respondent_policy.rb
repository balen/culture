class Survey::RespondentPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      # scope.all
      scope.where(id: nil) # return no records
    end
  end
end
