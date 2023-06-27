class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = @project.tasks

    respond_to do |format|
      format.html
      format.json { render json: @tasks }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @task }
    end
  end

  def new
    @task = @project.tasks.new
    authorize @task
  end

  def create
    @task = @project.tasks.new(task_params)
    authorize @task

    if @task.save
      redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    authorize @task
    
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :work_focus, :due_date, :status, :project_manager_id, :assignee_id, subtasks_attributes: [:id, :title, :description, :_destroy])
  end
end
