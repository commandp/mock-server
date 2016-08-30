class ApiRequestsController < ApplicationController

  before_action :set_default_format, only: [:handle_request]
  before_action :find_project

  def index
    @api_requests = @project.api_requests
  end

  def new
    @api_request = @project.api_requests.build
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

  def handle_request
    @api_request = ApiRequest.send("by_#{request.method.downcase}").where(request_path: request_path).first
    if @api_request.present?
      render json: @api_request.return_json, status: @api_request.status_code.to_sym
    else
      head :not_found
    end
  end

  private

  def api_request_params
    params.require(:api_request).permit(:name, :description, :request_method, :request_path, :return_json, :status_code)
  end

  def set_default_format
    request.format = :json
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def request_path
    full_path = request.path
    full_path.gsub("/#{@project.name.downcase}", '')
  end

end
