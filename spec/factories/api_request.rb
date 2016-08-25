FactoryGirl.define do
  factory :api_request do
    request_method 'get'
    request_path '/some_path'
    return_code 200
    return_value "{'a': 'b'}".to_json
  end
end
