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
      patch :like, :unlike
    end
    collection do
      get :new_1
      get :new_2
    end
  end

  resources :members, only: [:show]

  resource :account, only: [:new, :create, :destroy]

  resource :my,except: [:new, :create, :destroy] do
    get :info
    get :ticket_his
    get :tickets
    get :tickets_stat
    get :event_his
    get :bkm
  end

  resource :admin do
    get "login" => "admin#login", as: "login"
    post "login" => "sessions#admin_login"
    post "logout" => "sessions#admin_logout", as: "logout"
    get "top"
    resources :members, except: [:create, :new]
    resources :events, except: [:create, :new]
    resources :places
  end

end
