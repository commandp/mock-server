module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ApplicationError, with: :error_handler
  end

  def error_handler(exception)
    respond_to do |f|
      f.json do
        render json: exception, status: exception.status
      end
    end
  end

end
