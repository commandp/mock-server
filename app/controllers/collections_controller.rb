class CollectionsController < ApplicationController

  before_action :find_project

  def new
    @collection = @project.collections.build
  end

  def create
    @collection = @project.collections.build(collection_params)
    if @collection.save
      redirect_to @project, notice: "#{@collection.name} 分類建立成功"
    else
      render :new
    end
  end

  def edit
    @collection = @project.collections.find(params[:id])
  end

  def update
    @collection = @project.collections.find(params[:id])
    if @collection.update(collection_params)
      redirect_to @project, notice: "#{@collection.name} 更新成功"
    else
      render :edit
    end
  end

  def destroy
    @collection = @project.collections.find(params[:id])
    name = @collection.name
    @collection.destroy
    redirect_to @project, notice: "#{name} 分類刪除成功"
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

end
