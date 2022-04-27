Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :accounts,  controllers: { omniauth_callbacks: 'accounts/omniauth_callbacks' }
  get "u/:username" => "public#profile", as: :profile
  resources :communities do
    resources :posts
  end
  resources :subscriptions
  resources :comments

  get '/search', to: "public#index"
  post "post/vote" => "votes#create"
  root to: "public#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
