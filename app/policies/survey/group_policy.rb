class Survey::GroupPolicy < ApplicationPolicy
  class Scope < PlannerPolicy::Scope
    def resolve
      scope.all
    end
  end
end
