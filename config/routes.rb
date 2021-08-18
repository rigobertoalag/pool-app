Rails.application.routes.draw do
  get 'sessions/create'
  # get 'welcome/index'
  # get 'welcome/app'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:create]
      resources :pools, controller: 'my_pools', except: %i[new edit] do
        resources :questions, except: %i[new edit]
        resources :answers, only: [:update, :destroy, :create]
      end
      match "*unmatched", via: [:options], to: "master_api#xhr_options_request"
    end
  end

  get "/", to: "welcome#index"
  get "/auth/:provider/callback", to: "sessions#create"

end
