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
end
