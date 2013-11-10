RainCms::Application.routes.draw do
  namespace :admin do
    resources :pages
  end

  namespace :admin do
    resources :channels
  end

  namespace :admin do
    resources :keystores
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end