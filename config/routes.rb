Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:create]
      resources :pools, controller: 'my_pools', except: %i[new edit] do
        resources :questions, except: %i[new edit]
        resources :answers, only: [:update, :destroy, :create]
      end
    end
  end
end
