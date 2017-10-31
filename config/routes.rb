Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, constraints: { format: 'json' } do

    resources :sessions, only: [:create]
    resources :users
    resources :categories
    resources :sub_categories do
      resources :products
    end
  end
end
