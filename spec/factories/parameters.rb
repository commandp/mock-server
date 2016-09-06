FactoryGirl.define do
  factory :parameter do
    required false
    name "name"
    value "MyText"
    param_type "text"
    api_request
  end
end
