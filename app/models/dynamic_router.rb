class DynamicRouter

  def self.load
    # FIXME 每次都問有沒有 table 有點沒效率，但是不問的話在 setup 的時候就會 gg, 希望後代子孫能來修復這塊
    return unless ActiveRecord::Base.connection.table_exists? 'api_requests'
    MockServer::Application.routes.draw do
      ApiRequest.all.each do |req|
        match ":project_id/#{req.request_path}", to: "api_requests#handle_request", via: [req.request_method.try(:to_sym)], defaults: { format: :json }
      end
    end
  end

  def self.reload
    MockServer::Application.routes_reloader.reload!
  end

end
