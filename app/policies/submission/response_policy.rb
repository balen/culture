class Submission::ResponsePolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
