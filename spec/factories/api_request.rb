FactoryGirl.define do
  factory :api_request do
    request_method 'get'
    request_path '/some_path'
    status_code 200
    return_json {{a: 'b'}}
    name '厲害的 API'
    description 'API 超厲害'
  end
end
