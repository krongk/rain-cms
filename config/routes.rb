RainCms::Application.routes.draw do
  
  #routes for admin ==============================
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    resources :pages
    resources :channels
    resources :keystores
    get "home/index"
    get "home/help"
    get "templetes/index"
    get "templetes/show"
    get "templetes/new"
    post "templetes/create"
    get "templetes/edit"
    post "templetes/update"
    get "templetes/destroy"
    get "templetes/update_cache"
  end
  #routes for front ==============================
  root :to => "welcome#index"
  match '/search(/page/:page)', to: "welcome#search", via: :get, as: 'search'
  match '/tag/:tag', to: "welcome#tag", as: 'tag', via: :get
  
  #match '/:profession/:state_code/:dik/:classify_type/(:action(/:id))' => 
  #  'sanction', 
  #  :constraints => { :dik => /\d{4}.\d{2}.\d{2}/,  
  #  :classify_type => /title|date|skip/ }
  match '/:channel(/:id)', to: "welcome#index", via: :get
  match '/:channel(/page/:page)', to: "welcome#index", via: :get

end
