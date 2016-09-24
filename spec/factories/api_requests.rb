FactoryGirl.define do
  factory :api_request do
    request_method 'get'
    sequence(:request_path) { |n| "/some_path#{n}" }
    status_code :ok
    return_json '{"a": "b"}'
    name '厲害的 API'
    description 'API 超厲害'
    project
  end
end
