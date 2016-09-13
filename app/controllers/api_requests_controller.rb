class ApiRequestsController < ApplicationController

  include ErrorHandling

  before_action :set_default_format, only: [:handle_request]
  before_action :find_project
  skip_before_action :verify_authenticity_token, only: [:handle_request]

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

  def handle_request
    @api_request = @project.api_requests.send("by_#{request.method.downcase}").by_path(request_path)
    check_required_headers(@api_request)
    check_required_params(@api_request)
    if @api_request.present?
      render json: JsonTemplateHandler.new(@api_request.return_json, filtered_params).render, status: @api_request.status_code.to_sym
    else
      head :not_found
    end
  end

  private

  def api_request_params
    params.require(:api_request).permit(:name, :description, :request_method, :request_path, :return_json, :status_code, :collection_id, parameters_attributes: [:id, :name, :param_type, :required, :_destroy], headers_attributes: [:id, :key, :value, :_destroy])
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

  def filtered_params
    clone_params = params.clone
    ParamsGuard.new(clone_params).filtered_params
  end

  def check_required_params(api_request)
    begin
      required = api_request.parameters.required.pluck(:name)
      params.required(required)
    rescue ActionController::ParameterMissing => exception
      fail MissingParamError, caused_by: exception.param
    end
  end

  def missing_params_error(exception)
  end

  def check_required_headers(api_request)
    api_request.headers.each do |header|
      unless request.headers[header.key].present? && request.headers[header.key] == header.value
        fail MissingHeaderError, caused_by: header.key
      end
    end
  end

end
