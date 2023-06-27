class RegistrationsController < Devise::RegistrationsController
  before_action :check_project_manager, only: [:new, :create]

  private

  def check_project_manager
    unless current_user&.project_manager?
      redirect_to root_path, alert: "Only project managers can create employee accounts."
    end
  end
end
