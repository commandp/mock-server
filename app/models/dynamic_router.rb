class DynamicRouter

  def self.load
    MockServer::Application.routes.draw do
      ApiRequest.all.each do |req|
        match req.request_path, to: "api_requests#handle_request", via: [req.request_method.try(:to_sym)]
      end
    end
  end

  def self.reload
    MockServer::Application.routes_reloader.reload!
  end

end
