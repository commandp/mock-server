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

end
