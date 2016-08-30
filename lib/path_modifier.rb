class PathModifier

  def initialize(app)
    @app = app
  end

  def call(env)
    %w(PATH_INFO REQUEST_URI REQUEST_PATH ORIGINAL_FULLPATH).each do |header_name|
      # This naively downcases the entire String. You may want to split it and downcase
      # selectively. REQUEST_URI has the full url, so be careful with modifying it.
      env[header_name].try(:downcase!)
    end
    @app.call(env)
  end

end
