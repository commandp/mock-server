class ApiRequestsController < ApplicationController

  def index
    @api_requests = ApiRequest.all
  end

  def new
    @api_request = ApiRequest.new
  end

  def show
    @api_request = ApiRequest.find(params[:id])
  end

  def create
    @api_request = ApiRequest.new(api_request_params)
    if @api_request.save
      redirect_to api_requests_path, notice: "#{@api_request.name} 建立成功"
    else
      render :new
    end
  end

  def edit
    @api_request = ApiRequest.find(params[:id])
  end

  def update
    @api_request = ApiRequest.find(params[:id])
    if @api_request.update(api_request_params)
      redirect_to api_request_path(@api_request), notice: "#{@api_request.name} 更新成功"
    else
      render :edit
    end
  end

  def destroy
    @api_request = ApiRequest.find(params[:id])
    name = @api_request.name
    @api_request.destroy!
    redirect_to api_requests_path, notice: "#{name} 已經 gg 了"
  end

  def handle_request
    @api_request = ApiRequest.send("by_#{request.method.downcase}").where(request_path: request.path.downcase).first
    if @api_request.present?
      render json: @api_request.return_json, status: @api_request.status_code.to_sym
    else
      render status: :not_found
    end
  end

  private

  def api_request_params
    params.require(:api_request).permit(:request_method, :request_path, :return_json, :status_code)
  end

end
