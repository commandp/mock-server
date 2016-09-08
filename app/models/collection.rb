# == Schema Information
#
# Table name: collections
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_collections_on_project_id  (project_id)
#

class Collection < ApplicationRecord

  belongs_to :project
  has_many :api_requests

end
