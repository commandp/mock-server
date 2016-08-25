class ApiRequestsController < ApplicationController

  def handle_request
    @api_request = ApiRequest.send("by_#{request.method.downcase}").where(request_path: request.path.downcase).first
    if @api_request.present?
      render json: @api_request.return_json, status: @api_request.status_code.to_sym
    else
      render status: :not_found
    end
  end
end
