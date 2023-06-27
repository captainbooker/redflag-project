class ProjectPolicy < ApplicationPolicy
  def create?
    user.project_manager?
  end

  def new?
    user.project_manager?
  end

  def edit?
    user.project_manager?
  end

  def destroy?
    user.project_manager?
  end
end
