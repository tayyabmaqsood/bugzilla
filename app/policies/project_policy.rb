class ProjectPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    user.present? && user.user_type == 'manager'
  end

  def new?
    user.user_type == 'manager'
  end

  def edit?
    user.user_type == 'manager'
  end

  def create?
    user.user_type == 'manager'
  end

  def update?
    user.present? && user.user_type == 'manager'
  end

  def destroy?
    user.user_type == 'manager'
  end

  def add_resources?
    user.present? && user.user_type == 'manager'
  end

  def remove_users_from_project
    user.present? && user.user_type == 'manager'
  end

    private

    def project
      record
    end

end
