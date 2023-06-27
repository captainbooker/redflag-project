class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    authorize @user, :create_employee?
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    authorize @user, :create_employee?
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
  