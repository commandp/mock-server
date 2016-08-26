Rails.application.routes.draw do

  root 'api_requests#index'

  resources :api_requests

  DynamicRouter.load
end
