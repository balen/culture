class Survey::Group::QuestionPolicy < PlannerPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
