RainCms::Application.routes.draw do
  #routes for admin ==============================
  get "admin/home/help"
  match "admin", to: "admin/home#index", via: [:get]
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    resources :pages
    resources :channels
    resources :keystores
  end
  #routes for front ==============================
  root :to => "welcome#index"
  #match '/:profession/:state_code/:dik/:classify_type/(:action(/:id))' => 
  #  'sanction', 
  #  :constraints => { :dik => /\d{4}.\d{2}.\d{2}/,  
  #  :classify_type => /title|date|skip/ }
  match '/:channel(/:id)', to: "welcome#index", via: :get
end