class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def show
    @project = Project.includes(:api_requests).find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def index
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "#{@project.name}建立成功"
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: "#{@project.name} 更新成功"
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    name = @project.name
    @project.destroy!
    redirect_to projects_path, notcie: "#{name} 已經 gg"
  end


  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
