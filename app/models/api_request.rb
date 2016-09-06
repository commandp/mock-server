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
#  project_id     :integer
#
# Indexes
#
#  index_api_requests_on_project_id  (project_id)
#

require 'mustermann'
class ApiRequest < ApplicationRecord

  belongs_to :project

  has_many :parameters, dependent: :destroy

  validates_presence_of :request_method, :request_path, :status_code, :return_json

  after_save :reload_route
  before_save :downcase_request_path_and_set_path
  before_save :upcase_request_method
  before_save :delete_request_path_end_slash

  REQUEST_METHOD = %w( get post put patch delete )
  REQUEST_METHOD.each do |req|
    scope "by_#{req}".to_sym, -> { where(request_method: req.upcase) }
  end

  enum status_code: Rack::Utils::SYMBOL_TO_STATUS_CODE

  def self.by_path(path)
    all.each do |req|
      pattern = Mustermann.new(req.request_path, type: :rails)
      if pattern.match path
        return req
      end
    end
    nil
  end

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

  def upcase_request_method
    self.request_method.upcase!
  end

  def delete_request_path_end_slash
    self.request_path = self.request_path.chomp('/')
  end

end
