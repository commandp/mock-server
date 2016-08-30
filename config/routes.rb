Rails.application.routes.draw do

  root 'projects#index'

  resources :projects do
    resources :api_requests
  end

  resources :settings, only: [:index, :update]

  DynamicRouter.load

end
