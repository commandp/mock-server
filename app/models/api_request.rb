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
#  name           :string           default(""), not null
#  description    :text             default(""), not null
#

class ApiRequest < ApplicationRecord

  after_save :reload_route
  before_save :downcase_request_path_and_set_path
  validates_presence_of :request_method, :request_path, :status_code, :return_json

  REQUEST_METHOD = %w( get post put patch delete )
  REQUEST_METHOD.each do |req|
    scope "by_#{req}".to_sym, -> { where(request_method: req.upcase) }
  end

  enum status_code: Rack::Utils::SYMBOL_TO_STATUS_CODE

  private

  def reload_route
    DynamicRouter.reload
  end

  def downcase_request_path_and_set_path
    self.request_path.downcase!
    if !self.request_path.start_with?('/')
      self.request_path = '/' + self.request_path
    end
  end

end
