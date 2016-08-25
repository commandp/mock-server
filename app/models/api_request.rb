# == Schema Information
#
# Table name: api_requests
#
#  id             :integer          not null, primary key
#  request_method :string
#  request_path   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  return_json    :json
#  status_code    :integer
#

class ApiRequest < ApplicationRecord

  after_save :reload_route
  validates_presence_of :request_method, :request_path, :status_code, :return_json

  REQUEST_METHOD = %w( get post put patch delete )
  REQUEST_METHOD.each do |req|
    scope "by_#{req}".to_sym, -> { where(request_method: req) }
  end

  enum status_code: Rack::Utils::SYMBOL_TO_STATUS_CODE

  private

  def reload_route
    DynamicRouter.reload
  end

end
