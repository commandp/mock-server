class ParamsGuard

  def initialize(params)
    @params = params_white_list(params)
  end

  def filtered_params
    replace_file_with_attachment_url
    @params
  end

  private

  def params_white_list(params)
    params.except(:defaults, :controller, :action, :format)
  end

  def replace_file_with_attachment_url
    @params.each do |param|
      if @params[param].is_a?(ActionDispatch::Http::UploadedFile)
        attachment = Attachment.create!(file: @params[param])
        @params[param] = attachment.file.url
      end
    end
  end
end
