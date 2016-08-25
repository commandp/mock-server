# == Schema Information
#
# Table name: api_requests
#
#  id             :integer          not null, primary key
#  request_method :string
#  request_path   :string
#  return_code    :string
#  return_value   :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ApiRequest < ApplicationRecord

  after_save :reload_route
  validates_presence_of :request_method, :request_path, :return_code, :return_value

  private

  def reload_route
    DynamicRouter.reload
  end

end
