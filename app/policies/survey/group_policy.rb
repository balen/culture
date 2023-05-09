class Survey::PagePolicy < ApplicationPolicy
  class Scope < PlannerPolicy::Scope
    def resolve
      scope.all
    end
  end
end
