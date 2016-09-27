class DynamicRouter

  def self.load
    # FIXME 每次都問有沒有 table 有點沒效率，但是不問的話在 setup 的時候就會 gg, 希望後代子孫能來修復這塊
    return unless ActiveRecord::Base.connection.data_source_exists? 'projects'

    MockServer::Application.routes.draw do
      Project.all.each do |project|
        match "#{project.slug}/*path", to: 'request_handler#handle', via: :all, defaults: { format: :json }
      end
    end
  end

  def self.reload
    MockServer::Application.routes_reloader.reload!
    RequestRoutes.instance.reload
  end
end
