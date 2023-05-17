class Survey::Group::Question::AnswerPolicy < PlannerPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
