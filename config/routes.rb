Rails.application.routes.draw do

  root "top#index"

  get "login" => "top#login", as: "login"
  post "login" => "sessions#login"
  post "logout" => "sessions#logout", as: "logout"

  resources :events, except: [:new] do
    member do
      get :buy
      post "buy" => "events#buy_create", as: "buy_create"
      get "buy_result" => "events#result", as: "result"
      patch :like, :unlike, :bkm, :unbkm
    end
    collection do
      get :search
      get :new_1
      get :new_2
    end
  end

  resources :members, only: [:show]
  resources :places, only: [:index, :show]

  resource :account, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]

  resource :my, except: [:new, :create, :destroy] do
    get :info
    get :ticket_his
    get :tickets
    get :tickets_stat
    get :event_his
    get :bkm
  end

  namespace :admin do
    root "admin#top"
    get "login" => "admin#login", as: "login"
    post "login" => "sessions#admin_login"
    post "logout" => "sessions#admin_logout", as: "logout"
    get "top" => "admin#top"
    get "info" => "admin#info"
    get "edit" => "admin#edit"
    patch "update" => "admin#update"
    resource :password, only: [:edit, :update]
    resources :members, except: [:create, :new]
    resources :events, except: [:create, :new]
    resources :places
    resources :tags
  end

end
