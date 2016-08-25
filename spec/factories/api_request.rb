FactoryGirl.define do
  factory :api_request do
    request_method 'get'
    request_path '/some_path'
    status_code 200
    return_json {{a: 'b'}}
  end
end
