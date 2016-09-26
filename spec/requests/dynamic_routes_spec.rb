require 'rails_helper'

describe 'DynamicRouter', type: :request do

  context 'with different http method' do

    %w(GET PUT POST PATCH DELETE).each do |attr|

      it "works with #{attr}" do
        req = create(:api_request, request_method: attr)
        send(attr.downcase, "/#{req.project.slug.downcase}#{req.request_path}")
        expect(response.body).to eq(req.return_json)
        expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[req.status_code.to_sym])
      end

    end

  end

  context 'with params' do
    it 'works with request params' do
      json = '{"whatever": "<%= whatever %>"}'
      req = create(:api_request, return_json: json )
      parsed_json = '{"whatever": "nice"}'
      send(req.request_method.downcase, "/#{req.project.slug.downcase}#{req.request_path}?whatever=nice")
      expect(response.body).to eq parsed_json
    end

    it 'works with file upload' do
      json = '{"file": "<%= file %>"}'
      req = create(:api_request, return_json: json, request_method: :post )
      post "/#{req.project.slug.downcase}#{req.request_path}", params: { file: fixture_file_upload("#{fixture_path}/test.png") }
      parsed_json = "{\"file\": \"#{Attachment.last.file.url}\"}"
      expect(response.body).to eq parsed_json
    end

    it 'works with path params' do
      json = '{"id": "<%= id %>"}'
      req = create(:api_request, request_path: "/articles/:id/new", return_json: json )
      parsed_json = '{"id": "3"}'
      send(req.request_method.downcase, "/#{req.project.slug.downcase}/articles/3/new")
      expect(response.body).to eq parsed_json
    end
  end

  context 'with parameter set' do

    let(:api_request) { create(:api_request, request_method: 'POST') }

    context 'without required param' do
      let!(:parameter) { create(:parameter, api_request: api_request, required: true, name: 'name') }

      it 'renders error' do
        post "/#{api_request.project.slug.downcase}#{api_request.request_path}"
        expect(response.body).to eq (MissingParamError.new(caused_by: parameter.name).to_json)
      end

    end

    context 'with required param' do
      let!(:parameter) { create(:parameter, api_request: api_request, required: false, name: 'name') }

      it 'success' do
        post "/#{api_request.project.slug.downcase}#{api_request.request_path}"
        expect(response.body).to eq api_request.return_json
        expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[api_request.status_code.to_sym])
      end
    end

    context 'without required header' do
      let!(:header) { create(:header, api_request: api_request) }

      it 'renders error' do
        post "/#{api_request.project.slug.downcase}#{api_request.request_path}"
        expect(response.body).to eq (MissingHeaderError.new(caused_by: header.key).to_json)
      end

    end

    context 'with required header' do
      let!(:header) { create(:header, api_request: api_request) }

      it 'success' do
        post "/#{api_request.project.slug.downcase}#{api_request.request_path}", headers: { header.key => header.value }
        expect(response.body).to eq api_request.return_json
        expect(response.status).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[api_request.status_code.to_sym])
      end

    end
  end

end
