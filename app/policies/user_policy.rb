class UserPolicy < ApplicationPolicy
  def create_employee?
    user.project_manager?
  end
end
  