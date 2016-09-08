# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#
# Indexes
#
#  index_projects_on_slug  (slug)
#

class Project < ApplicationRecord

  extend FriendlyId

  friendly_id :name, use: [:slugged, :finders]

  has_many :api_requests, dependent: :destroy
  alias_method :apis, :api_requests
  has_many :collections

  validates_presence_of :name

end
