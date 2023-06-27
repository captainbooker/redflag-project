class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :edit, :destroy]
  before_action :authenticate_user!

  def index
    @projects = Project.all
    
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @projects }
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @project }
    end
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @project
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    authorize @project

    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :due_date, :project_manager_id)
  end
end