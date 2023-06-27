class TaskPolicy < ApplicationPolicy

  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def create?
    user.project_manager?
  end

  def update?
    assignee == project_manager || (assignee == user && (record.status == 'working' || record.status == 'needs_review'))
  end

  def destroy?
    assignee == project_manager
  end

  def new?
    user.project_manager?
  end

  private

  def project_manager
    task.project.project_manager
  end

  def assignee
    task.assignee
  end
end
