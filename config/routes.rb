Rails.application.routes.draw do

  root 'projects#index'

  resources :projects do
    resources :api_requests
  end

  DynamicRouter.load

end
