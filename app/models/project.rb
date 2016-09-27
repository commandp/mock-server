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

  after_commit :append_to_routes, on: :create
  after_commit :reload_routes, on: :destroy

  validates_presence_of :name

  def uncollection_apis
    apis.uncollection
  end

  def append_to_routes
    slug = self.slug

    ActionDispatch::Routing::Mapper.new(MockServer::Application.routes).instance_exec do
      match "#{slug}/*path", to: 'request_handler#handle', via: :all, defaults: { format: :json }
    end
  end

  def reload_routes
    DynamicRouter.reload
  end
end
