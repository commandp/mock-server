class ApiRequestsController < ApplicationController

  before_action :find_project

  def new
    @api_request = @project.api_requests.build
    @api_request.parameters.build
  end

  def show
    @api_request = @project.api_requests.find(params[:id])
  end

  def create
    @api_request = @project.api_requests.build(api_request_params)
    if @api_request.save
      redirect_to url_for(@project), notice: "#{@api_request.name} 建立成功"
    else
      render :new
    end
  end

  def edit
    @api_request = @project.api_requests.find(params[:id])
  end

  def update
    @api_request = @project.api_requests.find(params[:id])
    if @api_request.update(api_request_params)
      redirect_to url_for([@project, @api_request]), notice: "#{@api_request.name} 更新成功"
    else
      render :edit
    end
  end

  def destroy
    @api_request = @project.api_requests.find(params[:id])
    name = @api_request.name
    @api_request.destroy!
    redirect_to url_for(@project), notice: "#{name} 已經 gg 了"
  end

  private

  def api_request_params
    params.require(:api_request).permit(:name, :description, :request_method, :request_path, :return_json, :status_code, :collection_id, parameters_attributes: [:id, :name, :param_type, :required, :_destroy], headers_attributes: [:id, :key, :value, :_destroy])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
