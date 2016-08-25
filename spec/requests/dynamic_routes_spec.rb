require 'rails_helper'

describe 'DynamicRouter', type: :request do

  context 'GET' do
    let(:req) { create(:api_request, request_method: 'get') }
    it 'works' do
      json = {a: 'b'}.to_json
      get req.request_path
      expect(ActiveSupport::JSON.decode(response.body)).to eq(req.return_json)
      expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[req.status_code.to_sym])
    end
  end

  context 'PUT' do
    let(:req) { create(:api_request, request_method: 'put', status_code: 200) }
    it 'works' do
      json = {a: 'b'}.to_json
      put req.request_path
      expect(ActiveSupport::JSON.decode(response.body)).to eq(req.return_json)
      expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[req.status_code.to_sym])
    end
  end

  context 'POST' do
    let(:req) { create(:api_request, request_method: 'post', status_code: 201) }
    it 'works' do
      json = {a: 'b'}.to_json
      post req.request_path
      expect(ActiveSupport::JSON.decode(response.body)).to eq(req.return_json)
      expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[req.status_code.to_sym])
    end
  end

  context 'PATCH' do
    let(:req) { create(:api_request, request_method: 'patch', status_code: 200) }
    it 'works' do
      json = {a: 'b'}.to_json
      patch req.request_path
      expect(ActiveSupport::JSON.decode(response.body)).to eq(req.return_json)
      expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[req.status_code.to_sym])
    end
  end

  context 'DELETE' do
    let(:req) { create(:api_request, request_method: 'delete', status_code: 200) }
    it 'works' do
      json = {a: 'b'}.to_json
      delete req.request_path
      expect(ActiveSupport::JSON.decode(response.body)).to eq(req.return_json)
      expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[req.status_code.to_sym])
    end
  end
end
