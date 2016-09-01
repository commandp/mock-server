require 'rails_helper'

describe 'DynamicRouter', type: :routing do

  it 'routable after every api request created' do
    api = create(:api_request)
    expect(send(api.request_method.downcase, "/#{api.project.name.downcase}#{api.request_path}")).to be_routable
  end

end
