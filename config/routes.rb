Rails.application.routes.draw do
  get "/", to: "welcome#index"
  resources :my_apps, except:[:show, :index]

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
  
  get "/auth/:provider/callback", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

end
