class Survey::Group::Question::LikertSettingPolicy < PlannerPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
