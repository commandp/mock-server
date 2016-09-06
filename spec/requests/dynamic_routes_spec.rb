require 'rails_helper'

describe 'DynamicRouter', type: :request do

  context 'with different http method' do

    %w(GET PUT POST PATCH DELETE).each do |attr|

      it "works with #{attr}" do
        req = create(:api_request, request_method: attr)
        send(attr.downcase, "/#{req.project.name.downcase}#{req.request_path}")
        expect(response.body).to eq(req.return_json)
        expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[req.status_code.to_sym])
      end

    end

  end

  context 'with params' do

    it 'works with path params' do
      json = '{"id": "<%= id %>"}'
      req = create(:api_request, request_path: '/posts/:id', return_json: json )
      parsed_json = '{"id": "3"}'
      send(req.request_method.downcase, "/#{req.project.name.downcase}/posts/3")
      expect(response.body).to eq parsed_json
    end

    it 'works with request params' do
      json = '{"whatever": "<%= whatever %>"}'
      req = create(:api_request, return_json: json )
      parsed_json = '{"whatever": "nice"}'
      send(req.request_method.downcase, "/#{req.project.name.downcase}#{req.request_path}?whatever=nice")
      expect(response.body).to eq parsed_json
    end

    it 'works with file upload' do
      json = '{"file": "<%= file %>"}'
      req = create(:api_request, return_json: json, request_method: :post )
      post "/#{req.project.name.downcase}#{req.request_path}", params: { file: fixture_file_upload("#{fixture_path}/test.png") }
      parsed_json = "{\"file\": \"#{Attachment.last.file.url}\"}"
      expect(response.body).to eq parsed_json
    end

  end

  context 'with parameter set' do

    let(:api_request) { create(:api_request, request_method: 'POST') }

    context 'without required param' do
      let!(:parameter) { create(:parameter, api_request: api_request, required: true, name: 'name') }

      it 'renders error' do
        error_json = {
                      error: "ParameterMissing",
                      message: "Param is missing or the value is empty: name"
        }.to_json
        post "/#{api_request.project.name.downcase}#{api_request.request_path}"
        expect(response.body).to eq error_json
        expect(response.status).to eq 400
      end

    end

    context 'with required param' do
      let!(:parameter) { create(:parameter, api_request: api_request, required: false, name: 'name') }

      it 'success' do
        post "/#{api_request.project.name.downcase}#{api_request.request_path}"
        expect(response.body).to eq api_request.return_json
        expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[api_request.status_code.to_sym])
      end
    end
  end

end
