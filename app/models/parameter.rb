# == Schema Information
#
# Table name: parameters
#
#  id             :integer          not null, primary key
#  required       :boolean
#  name           :string           not null
#  value          :text             default("")
#  param_type     :string           not null
#  api_request_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_parameters_on_api_request_id  (api_request_id)
#

class Parameter < ApplicationRecord

  belongs_to :api_request

end
