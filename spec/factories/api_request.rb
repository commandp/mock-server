FactoryGirl.define do
  factory :api_request do
    request_method 'get'
    request_path '/some_path'
    status_code :ok
    return_json '{"a": "b"}'
    name '厲害的 API'
    description 'API 超厲害'
    project
  end
end
