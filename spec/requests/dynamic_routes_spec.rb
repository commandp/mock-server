require 'rails_helper'

describe 'DynamicRouter', type: :request do

  context 'GET' do
    it 'works' do
      create(:api_request, request_method: 'get', request_path: '/some_path', return_code: 200, return_value: "{'a': 'b'}".to_json)
      get '/some_path'
      expect(response.body).to eq("{'a': 'b'}".to_json)
    end
  end
end
