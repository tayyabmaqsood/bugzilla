class BugPolicy < ApplicationPolicy
    def resolve
      scope.all
    end

  def create?
     user.user_type == 'qa'
  end

  def new?
    user.user_type == 'qa'
  end

  def assign_bug_to_developer?
    user.user_type == 'developer'
  end

  private

  def bug
    report
  end
end
