class RequestHandlerController < ApplicationController
  include ErrorHandling

  before_action :set_default_format, :find_request

  def handle
    if @request.present?
      merge_params_from_path
      check_required_headers(@request)
      check_required_params(@request)
      render json: JsonTemplateHandler.new(@request.return_json, filtered_params).render, status: @request.status_code.to_sym
    else
      fail ApplicationError, 'api not exist!'
    end
  end

  private

  def find_request
    @memo = RequestRoutes.instance.match(request.path, request.method)
    if @memo.present?
      @request = ApiRequest.find_by(id: @memo[:request_id])
    else
      fail ApplicationError
    end
  end

  def merge_params_from_path
    match_date = @memo[:pattern].match("/#{params[:path]}")
    match_date.names.zip(match_date.captures).to_h.each do |k, v|
      params[k] = v
    end
  end

  def filtered_params
    clone_params = params.clone
    ParamsGuard.new(clone_params).filtered_params
  end

  def set_default_format
    request.format = :json
  end

  def check_required_params(api_request)
    required = api_request.parameters.required.pluck(:name)
    params.required(required)
  rescue ActionController::ParameterMissing => exception
    raise MissingParamError, caused_by: exception.param
  end

  def check_required_headers(api_request)
    api_request.headers.each do |header|
      unless request.headers[header.key].present? && request.headers[header.key] == header.value
        fail MissingHeaderError, caused_by: header.key
      end
    end
  end
end
